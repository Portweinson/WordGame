//
//  PWGDataManager.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGDataManager.h"

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
        
	}
	return self;
}


#pragma mark - Custom getters/setters

- (BOOL)isFirstAppLaunch
{
    return ![USER_DEFAULTS boolForKey:kUDKeyIsNotFirstAppLaunch];
}

@end
