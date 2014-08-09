//
//  PWGGameAlphabets.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGAlphabets.h"

@implementation PWGAlphabets

+ (NSArray *)alphabetForLanguage:(NSString *)languageCode
{
    NSArray *alphabet;
    
    if ([languageCode isEqualToString:kLanguageRussian]) {
        alphabet = [@"А Б В Г Д Е Ё Ж З И Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Э Ю Я" componentsSeparatedByString:@" "];
    } else if ([languageCode isEqualToString:kLanguageEnglish]) {
        alphabet = [@"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z" componentsSeparatedByString:@" "];
    }
    return alphabet;
}

+ (NSCharacterSet *)allowedWordCharactersForLanguage:(NSString *)languageCode
{
    NSCharacterSet *allowedCharacters;
    
    if ([languageCode isEqualToString:kLanguageRussian]) {
        allowedCharacters = [NSCharacterSet characterSetWithCharactersInString:@"АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя"];
    } else if ([languageCode isEqualToString:kLanguageEnglish]) {
        allowedCharacters = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
    }
    return allowedCharacters;
}

+ (NSCharacterSet *)restrictedFirstLetterCharactersForLanguage:(NSString *)languageCode
{
    NSCharacterSet *restrictedCharacters;
    
    if ([languageCode isEqualToString:kLanguageRussian]) {
        restrictedCharacters = [NSCharacterSet characterSetWithCharactersInString:@"ЪЫЬъыь"];
    } else if ([languageCode isEqualToString:kLanguageEnglish]) {
        restrictedCharacters = [NSCharacterSet characterSetWithCharactersInString:@""];
    }
    return restrictedCharacters;
}

+ (NSString *)lastLetterForWord:(NSString *)word withLanguage:(NSString *)languageCode
{
    NSString *lastLetter;
    NSArray *alphabet = [self alphabetForLanguage:languageCode];
    
    for (NSUInteger index = [word length] - 1; index > 0; index--) {
        NSString *character = [word substringWithRange:NSMakeRange(index, 1)];
        if ([alphabet containsObject:[character uppercaseString]]) {
            lastLetter = character;
            break;
        }
    }
    return lastLetter;
}

@end
