//
//  PWGWordsManager.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGWordsManager.h"
#import "PWGAlphabets.h"
#import "Word.h"


@implementation PWGWordsManager


#pragma mark - Entities count methods

- (NSUInteger)wordsCountForLanguageCode:(NSString *)languageCode
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"language = %@", languageCode];
    return [Word MR_countOfEntitiesWithPredicate:predicate];
}


#pragma mark -

- (NSDictionary *)wordsSectionedByFirstLetterForLanguage:(NSString *)languageCode
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"language = %@", languageCode];
    
    return [self wordsSectionedByFirstLetterWithPredicate:predicate forLanguage:languageCode];
}

- (NSDictionary *)wordsSectionedByFirstLetterForLanguage:(NSString *)languageCode addedByUser:(BOOL)addedByUser
{
    NSPredicate *langPredicate = [NSPredicate predicateWithFormat:@"language = %@", languageCode];
    NSPredicate *userPredicate = [NSPredicate predicateWithFormat:@"addedByUser = %@", [NSNumber numberWithBool:addedByUser]];
    
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[langPredicate,
                                                                                  userPredicate]];
    
    return [self wordsSectionedByFirstLetterWithPredicate:predicate forLanguage:languageCode];
}

- (NSDictionary *)wordsSectionedByFirstLetterWithPredicate:(NSPredicate *)predicate forLanguage:(NSString *)languageCode
{
    NSMutableDictionary *wordsDict;
    NSArray *alphabet = [PWGAlphabets alphabetForLanguageWithCode:languageCode];
    
    for (NSString *letter in alphabet) {
        NSPredicate *letterPredicate = [NSPredicate predicateWithFormat:@"firstLetter = %@", [letter lowercaseString]];
        NSPredicate *finalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicate,
                                                                                           letterPredicate]];
        NSArray *words = [Word MR_findAllSortedBy:@"word" ascending:YES withPredicate:finalPredicate];
        if ([words count]) {
            if (!wordsDict) {
                wordsDict = [NSMutableDictionary dictionaryWithCapacity:[alphabet count]];
            }
            [wordsDict setObject:words forKey:letter];
        }
    }
    return wordsDict;
}


@end
