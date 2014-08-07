//
//  NSLocale+Extended.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "NSLocale+Extended.h"

@implementation NSLocale (Extended)

+ (NSString *)localizedLanguageNameForLanguageCode:(NSString *)languageCode
{
    return NSLocalizedString([[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:languageCode], nil);
}

+ (NSString *)defaultLanguageCode
{
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if ([LANGUAGE_CODES containsObject:language]) {
        return language;
    } else {
        return kLanguageEnglish;
    }
}

@end
