//
//  PWGWordsDataImporter.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGWordsDataImporter.h"
#import "PWGAlphabets.h"
#import "Word.h"

static NSString *const kPlistNameSuffix = @"Words";

static NSString *const kPlistKeySpelling = @"spelling";
static NSString *const kPlistKeyAlternateSpelling = @"alternate spelling";
static NSString *const kPlistKeyDefinition = @"definition";

@implementation PWGWordsDataImporter


#pragma mark - import methods

- (void)importWordsFromLocalResourses
{
    for (NSString *languageCode in LANGUAGE_CODES) {
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:[self plistPathForLanguage:languageCode]];
        if ([plistData count]) {
            NSArray *keys = [plistData allKeys];
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                for (NSString *key in keys) {
                    NSArray *words = [plistData objectForKey:key];
                    if ([words count]) {
                        for (NSDictionary *wordInfo in words) {
                            NSString *spelling = [wordInfo objectForKey:kPlistKeySpelling];
                            NSString *definition = [wordInfo objectForKey:kPlistKeyDefinition];
                            NSString *alternateSpelling = [wordInfo objectForKey:kPlistKeyAlternateSpelling];
                            
                            Word *word = [Word MR_createEntityInContext:localContext];
                            word.language = languageCode;
                            word.spelling = spelling;
                            word.alternateSpelling = alternateSpelling;
                            word.definition = [definition stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
                            word.firstLetter = [spelling substringToIndex:1];
                            word.lastLetter = [PWGAlphabets lastLetterForWord:spelling withLanguageCode:languageCode];
                        }
                    }
                }
            } completion:^(BOOL success, NSError *error) {
                if (success) {
                    NSLog(@"\nDataImporter finished pList import for Language: %@\n\n", languageCode);
                } else if (error) {
                    NSLog(@"\nDataImporter failed pList import for Language: %@\nwith error:%@\n\n", languageCode, [error localizedDescription]);
                }
            }];
        }
    }
}


#pragma mark - helper methods

- (NSString *)plistPathForLanguage:(NSString *)language
{
    NSString *plistName = [NSString stringWithFormat:@"%@%@",language, kPlistNameSuffix];
    return [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
}

@end
