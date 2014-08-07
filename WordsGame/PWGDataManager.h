//
//  PWGDataManager.h
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PWGWordsDataImporter, PWGGamesManager, PWGWordsManager;


@interface PWGDataManager : NSObject

#pragma mark - Properties

@property (nonatomic) BOOL isFirstAppLaunch;
@property (nonatomic, strong) PWGWordsDataImporter *wordsDataImporter;
@property (nonatomic, strong) PWGGamesManager *gamesManager;
@property (nonatomic, strong) PWGWordsManager *wordsManager;


#pragma mark - Class methods

+ (PWGDataManager *)sharedInstance;


#pragma mark - Instance methods

- (void)start;

@end
