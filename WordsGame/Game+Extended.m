//
//  Game+Extended.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "Game+Extended.h"

const NSUInteger kGameNameLengthLimit = 35;

@implementation Game (Extended)

+ (NSString *)defaultGameName
{
    return NSLocalizedString(@"GAME Default name", nil);
}

@end
