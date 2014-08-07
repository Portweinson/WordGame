//
//  NSLocale+Extended.h
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSLocale (Extended)


#pragma mark - Class methods

+ (NSString *)localizedLanguageNameForLanguageCode:(NSString *)languageCode;
+ (NSString *)defaultLanguageCode;

@end
