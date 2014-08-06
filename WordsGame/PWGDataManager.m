//
//  PWGDataManager.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGDataManager.h"
#import "PWGGamesManager.h"
#import "PWGWordsDataImporter.h"

@implementation PWGDataManager


#pragma mark - PWGDataManager Lifecycle

static PWGDataManager *sharedInstance = nil;

+ (PWGDataManager *)sharedInstance
{
    if (!sharedInstance) {
        sharedInstance = [PWGDataManager new];
    }
    return sharedInstance;
}

- (id)init
{
	self = [super init];
	if (self) {
        self.wordsDataImporter = [PWGWordsDataImporter new];
        self.gamesManager = [PWGGamesManager new];
	}
	return self;
}

- (void)start
{
    if (self.isFirstAppLaunch) {
        [self.wordsDataImporter importWordsFromLocalResourses];
    }
}


#pragma mark - Custom getters/setters

- (BOOL)isFirstAppLaunch
{
    return ![USER_DEFAULTS boolForKey:kUDKeyIsNotFirstAppLaunch];
}

@end
