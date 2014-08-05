//
//  Word.h
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;

@interface Word : NSManagedObject

@property (nonatomic, retain) NSString * firstLetter;
@property (nonatomic, retain) NSString * word;
@property (nonatomic, retain) NSString * lastLetter;
@property (nonatomic, retain) NSSet *games;
@end

@interface Word (CoreDataGeneratedAccessors)

- (void)addGamesObject:(Game *)value;
- (void)removeGamesObject:(Game *)value;
- (void)addGames:(NSSet *)values;
- (void)removeGames:(NSSet *)values;

@end
