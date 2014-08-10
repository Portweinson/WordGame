//
//  PWGGamesManager.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGGamesManager.h"
#import "Game+Extended.h"

#define PREDICATE_START_DATE(startDate) [NSPredicate predicateWithFormat:@"startDate = %@", (startDate)]

@implementation PWGGamesManager

- (void)createGameNamed:(NSString *)name withLanguage:(NSString *)languageCode completion:(void(^)(BOOL success, Game *newGame, NSError *error))completion
{
    NSDate *startDate = [NSDate date];
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        Game *game = [Game MR_createEntityInContext:localContext];
        game.startDate = startDate;
        game.name = ([name length]) ? name : [Game defaultGameName];
        game.language = languageCode;
    } completion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"\nGamesManager created game successfully\n\n");
            
            Game *newGame = [Game MR_findFirstWithPredicate:PREDICATE_START_DATE(startDate)];
            completion(success, newGame, error);
        } else if (error) {
            NSLog(@"\nGamesManager failed to create game with error:%@\n\n", [error localizedDescription]);
        }
    }];
}

@end
