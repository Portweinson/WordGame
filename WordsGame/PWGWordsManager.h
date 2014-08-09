//
//  PWGWordsManager.h
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Word;

@interface PWGWordsManager : NSObject

- (NSUInteger)wordsCountForLanguageCode:(NSString *)languageCode;

- (NSDictionary *)wordsSectionedByFirstLetterForLanguage:(NSString *)languageCode;
- (NSDictionary *)wordsSectionedByFirstLetterForLanguage:(NSString *)languageCode addedByUser:(BOOL)addedByUser;

- (void)saveWord:(Word *)word spelling:(NSString *)spelling definition:(NSString *)definition language:(NSString *)languageCode completion:(void(^)(BOOL success, Word *savedWord))completion;
- (void)deleteWord:(Word *)word completion:(void(^)(BOOL success, NSError *error))completion;

@end
