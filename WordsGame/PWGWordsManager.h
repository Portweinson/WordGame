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

@end
