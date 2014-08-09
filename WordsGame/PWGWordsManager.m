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

static NSString *const kWordLanguage = @"language";
static NSString *const kWordSpelling = @"spelling";

#define PREDICATE_LANGUAGE(languageCode) [NSPredicate predicateWithFormat:@"language = %@", (languageCode)]
#define PREDICATE_ADDED_BY(addedByUser) [NSPredicate predicateWithFormat:@"addedByUser = %@", (addedByUser)]
#define PREDICATE_FIRST_LETTER(firstLetter) [NSPredicate predicateWithFormat:@"firstLetter = %@", (firstLetter)]
#define PREDICATE_SPELLING(spelling) [NSPredicate predicateWithFormat:@"spelling = %@", (spelling)]


@implementation PWGWordsManager


#pragma mark - Entities count methods

- (NSUInteger)wordsCountForLanguageCode:(NSString *)languageCode
{
    return [Word MR_countOfEntitiesWithPredicate:PREDICATE_LANGUAGE(languageCode)];
}


#pragma mark -

- (NSDictionary *)wordsSectionedByFirstLetterForLanguage:(NSString *)languageCode
{
    return [self wordsSectionedByFirstLetterWithPredicate:PREDICATE_LANGUAGE(languageCode)
                                              forLanguage:languageCode];
}

- (NSDictionary *)wordsSectionedByFirstLetterForLanguage:(NSString *)languageCode addedByUser:(BOOL)addedByUser
{
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[PREDICATE_LANGUAGE(languageCode),
                                                                                  PREDICATE_ADDED_BY(@(addedByUser))]];
    return [self wordsSectionedByFirstLetterWithPredicate:predicate forLanguage:languageCode];
}

- (NSDictionary *)wordsSectionedByFirstLetterWithPredicate:(NSPredicate *)predicate forLanguage:(NSString *)languageCode
{
    NSMutableDictionary *wordsDict;
    NSArray *alphabet = [PWGAlphabets alphabetForLanguageWithCode:languageCode];
    
    for (NSString *letter in alphabet) {
        NSPredicate *finalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicate,
                                                                                           PREDICATE_FIRST_LETTER([letter lowercaseString])]];
        NSArray *words = [Word MR_findAllSortedBy:kWordSpelling ascending:YES withPredicate:finalPredicate];
        if ([words count]) {
            if (!wordsDict) {
                wordsDict = [NSMutableDictionary dictionaryWithCapacity:[alphabet count]];
            }
            [wordsDict setObject:words forKey:letter];
        }
    }
    return wordsDict;
}


#pragma mark - Save/Delete methods

- (void)saveWord:(Word *)word spelling:(NSString *)spelling definition:(NSString *)definition language:(NSString *)languageCode completion:(void(^)(BOOL success, Word *savedWord))completion
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        Word *wordForSave;
        if (word) {
            wordForSave = [word MR_inContext:localContext];
        } else {
            wordForSave = [Word MR_createEntityInContext:localContext];
            wordForSave.language = languageCode;
            wordForSave.addedByUser = @YES;
        }
        wordForSave.spelling = spelling;
        wordForSave.definition = definition;
        wordForSave.firstLetter = [spelling substringToIndex:1];
        wordForSave.lastLetter = [PWGAlphabets lastLetterForWord:spelling withLanguageCode:languageCode];
    } completion:^(BOOL success, NSError *error) {
        if (success) {
            NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[PREDICATE_LANGUAGE(languageCode),
                                                                                          PREDICATE_SPELLING(spelling)]];
            Word *savedWord = [Word MR_findFirstWithPredicate:predicate];
            completion(success, savedWord);
        }
    }];
}

- (void)deleteWord:(Word *)word completion:(void(^)(BOOL success, NSError *error))completion
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [word MR_deleteEntityInContext:localContext];
    } completion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"\nWordManager deleted word successfully\n\n");
        } else if (error) {
            NSLog(@"\nWordManager failed to delete word with error:%@\n\n", [error localizedDescription]);
        }
        completion(success, error);
    }];
}

@end
