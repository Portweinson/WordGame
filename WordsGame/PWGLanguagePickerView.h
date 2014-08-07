//
//  PWGLanguagePickerView.h
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PWGLanguagePickerView;

@protocol PWGLanguagePickerDelegate <NSObject>

@optional
- (void)languagePicker:(PWGLanguagePickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end


@interface PWGLanguagePickerView : UIPickerView

@property (nonatomic, weak) IBOutlet id <PWGLanguagePickerDelegate> pickerDelegate;

- (void)selectDefaultLanguageRow:(BOOL)animated;
- (NSString *)languageCodeForSelectedPickerRow;

@end
