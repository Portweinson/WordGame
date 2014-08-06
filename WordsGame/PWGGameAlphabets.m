//
//  PWGGameAlphabets.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGGameAlphabets.h"
#import "PWGLanguageCodes.h"

@implementation PWGGameAlphabets

+ (NSArray *)alphabetForLanguageWithCode:(NSString *)languageCode
{
    NSArray *alphabet;
    
    if ([languageCode isEqualToString:kLanguageRussian]) {
        alphabet = @[@"А", @"Б", @"В", @"Г", @"Д", @"Е", @"Ё", @"Ж", @"З", @"И", @"Й", @"К", @"Л", @"М", @"Н", @"О", @"П", @"Р", @"С", @"Т", @"У", @"Ф", @"Х", @"Ц", @"Ч", @"Ш", @"Щ", @"Э", @"Ю", @"Я"];
    } else if ([languageCode isEqualToString:kLanguageEnglish]) {
        alphabet = @[];
    }
    
    return alphabet;
}

@end
