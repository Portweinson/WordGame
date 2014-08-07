//
//  PWGGamesManager.h
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Game;

@interface PWGGamesManager : NSObject

- (Game *)createGameNamed:(NSString *)name withLanguage:(NSString *)languageCode;

@end
