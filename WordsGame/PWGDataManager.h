//
//  PWGDataManager.h
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWGDataManager : NSObject


#pragma mark - Properties

@property (nonatomic) BOOL isFirstAppLaunch;


#pragma mark - Class methods

+ (PWGDataManager *)sharedInstance;


#pragma mark - Instance methods


@end
