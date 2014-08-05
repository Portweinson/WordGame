//
//  Game.h
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Word;

@interface Game : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSOrderedSet *usedWords;
@end

@interface Game (CoreDataGeneratedAccessors)

- (void)insertObject:(Word *)value inUsedWordsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromUsedWordsAtIndex:(NSUInteger)idx;
- (void)insertUsedWords:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeUsedWordsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInUsedWordsAtIndex:(NSUInteger)idx withObject:(Word *)value;
- (void)replaceUsedWordsAtIndexes:(NSIndexSet *)indexes withUsedWords:(NSArray *)values;
- (void)addUsedWordsObject:(Word *)value;
- (void)removeUsedWordsObject:(Word *)value;
- (void)addUsedWords:(NSOrderedSet *)values;
- (void)removeUsedWords:(NSOrderedSet *)values;
@end
