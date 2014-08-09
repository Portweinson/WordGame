//
//  PWGGameAlphabets.h
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWGAlphabets : NSObject

#pragma mark - Class methods

+ (NSArray *)alphabetForLanguage:(NSString *)languageCode;
+ (NSCharacterSet *)allowedWordCharactersForLanguage:(NSString *)languageCode;
+ (NSCharacterSet *)restrictedFirstLetterCharactersForLanguage:(NSString *)languageCode;
+ (NSString *)lastLetterForWord:(NSString *)word withLanguage:(NSString *)languageCode;

@end
