//
//  Word.h
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 09.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;

@interface Word : NSManagedObject

@property (nonatomic, retain) NSNumber * addedByUser;
@property (nonatomic, retain) NSString * firstLetter;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSString * lastLetter;
@property (nonatomic, retain) NSString * definition;
@property (nonatomic, retain) NSNumber * useCount;
@property (nonatomic, retain) NSString * spelling;
@property (nonatomic, retain) NSString * alternateSpelling;
@property (nonatomic, retain) NSSet *games;
@end

@interface Word (CoreDataGeneratedAccessors)

- (void)addGamesObject:(Game *)value;
- (void)removeGamesObject:(Game *)value;
- (void)addGames:(NSSet *)values;
- (void)removeGames:(NSSet *)values;

@end
