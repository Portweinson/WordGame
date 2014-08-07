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

static NSString *const kPlistKeyWord = @"word";
static NSString *const kPlistKeyMeaning = @"meaning";

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
                            NSString *word = [wordInfo objectForKey:kPlistKeyWord];
                            NSString *meaning = [wordInfo objectForKey:kPlistKeyMeaning];
                            
                            Word *wordEntity = [Word MR_createEntityInContext:localContext];
                            wordEntity.language = languageCode;
                            wordEntity.word = word;
                            wordEntity.meaning = meaning;
                            wordEntity.firstLetter = [word substringToIndex:1];
                            wordEntity.lastLetter = [PWGAlphabets lastLetterForWord:word withLanguageCode:languageCode];
                        }
                    }
                }
            } completion:^(BOOL success, NSError *error) {
                
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
