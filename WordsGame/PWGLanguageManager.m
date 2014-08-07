//
//  PWGLanguageManager.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGLanguageManager.h"

@implementation PWGLanguageManager


#pragma mark - Custom getters/setters

- (NSString *)lastUsedLanguageCode
{
    return [USER_DEFAULTS stringForKey:kUDKeyLastUsedLanguage];
}

- (void)setLastUsedLanguageCode:(NSString *)lastUsedLanguageCode
{
    [USER_DEFAULTS setObject:lastUsedLanguageCode forKey:kUDKeyLastUsedLanguage];
}


#pragma mark -

- (NSString *)localizedLanguageNameForLanguageCode:(NSString *)languageCode
{
    return NSLocalizedString([[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:languageCode], nil);
}

- (NSString *)defaultLanguageCode
{
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    if ([self.lastUsedLanguageCode length]) {
        return self.lastUsedLanguageCode;
    } else if ([LANGUAGE_CODES containsObject:language]) {
        return language;
    } else {
        return kLanguageEnglish;
    }
}


@end
