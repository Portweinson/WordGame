//
//  PWGAddWordViewController.h
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGBaseViewController.h"

@class Word;

@protocol PWGAddWordViewControllerDelegate <NSObject>

@optional

- (void)wordAdded:(Word *)word;

@end



@interface PWGAddWordViewController : PWGBaseViewController

@property (nonatomic, weak) id <PWGAddWordViewControllerDelegate> delegate;
@property (nonatomic, strong) Word *word;
@property (nonatomic, strong) NSString *spelling;
@property (nonatomic, strong) NSString *language;

@end
