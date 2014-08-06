//
//  PWGGameAlphabets.h
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWGGameAlphabets : NSObject

#pragma mark - Class methods

+ (NSArray *)alphabetForLanguageWithCode:(NSString *)languageCode;

@end
