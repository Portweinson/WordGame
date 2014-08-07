//
//  PWGLanguageManager.h
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWGLanguageManager : NSObject


#pragma mark - Properties

@property (nonatomic, strong) NSString *lastUsedLanguageCode;


#pragma mark - Instance methods

- (NSString *)localizedLanguageNameForLanguageCode:(NSString *)languageCode;
- (NSString *)defaultLanguageCode;

@end
