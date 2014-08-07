//
//  PWGWordsManager.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGWordsManager.h"
#import "Word.h"

@implementation PWGWordsManager

- (NSUInteger)wordsCountForLanguageCode:(NSString *)languageCode
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"language = %@", languageCode];
    return [Word MR_countOfEntitiesWithPredicate:predicate];
}

@end
