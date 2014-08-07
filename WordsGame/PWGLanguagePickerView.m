//
//  PWGLanguagePickerView.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGLanguagePickerView.h"
#import "PWGLanguageManager.h"

@interface PWGLanguagePickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@end


@implementation PWGLanguagePickerView


#pragma mark - View Settings

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self =  [super initWithCoder:aDecoder];
    if (self) {
        [self prepare];
    }
    return self;
}

- (void)prepare
{
    self.dataSource = self;
    self.delegate = self;
}


#pragma mark - PWGLanguagePickerView methods

- (void)selectDefaultLanguageRow:(BOOL)animated
{
    NSString *language = [LANGUAGE_MANAGER defaultLanguageCode];
    NSUInteger index = [LANGUAGE_CODES indexOfObject:language];
    [self selectRow:index inComponent:0 animated:animated];
}

- (NSString *)languageCodeForSelectedPickerRow
{
    return [LANGUAGE_CODES objectAtIndex:[self selectedRowInComponent:0]];
}


#pragma mark - UIPickerViewDelegate/UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [LANGUAGE_CODES count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [LANGUAGE_MANAGER localizedLanguageNameForLanguageCode:LANGUAGE_CODES[row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pickerDelegate && [self.pickerDelegate respondsToSelector:@selector(languagePicker:didSelectRow:inComponent:)]) {
        [self.pickerDelegate languagePicker:self didSelectRow:row inComponent:component];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
