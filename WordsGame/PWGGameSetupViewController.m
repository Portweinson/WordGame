//
//  PWGGameSetupViewController.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGGameSetupViewController.h"
#import "NSLocale+Extended.h"
#import "PWGWordsManager.h"
#import "Game+Extended.h"

static NSString *const kSegueIDGameSetupToGame = @"Game setup to Game";


@interface PWGGameSetupViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonDone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldGameName;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerGameLanguage;
@property (weak, nonatomic) IBOutlet UILabel *labelWordsCount;

@property (nonatomic, strong) UITapGestureRecognizer *hideKeyboardTapRecognizer;

@end


@implementation PWGGameSetupViewController


#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self selectDefaultPickerRow];
    [self refreshWordsCountLabelText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:kSegueIDGameSetupToGame sender:self];
}

- (IBAction)hideKeyboardTapRecognized:(UITapGestureRecognizer *)sender
{
    if ([self.textFieldGameName isFirstResponder]) {
        [self.textFieldGameName resignFirstResponder];
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


#pragma mark -

- (void)refreshWordsCountLabelText
{
    NSUInteger count = [WORDS_MANAGER wordsCountForLanguageCode:[self languageCodeForSelectedPickerRow]];
    NSString *labelText = [NSString stringWithFormat:NSLocalizedString(@"GSVC LABEL Words count", nil), count];
    self.labelWordsCount.text = labelText;
}


#pragma mark - Keyboard notification handlers

- (void) keyboardShowNotificationHandler:(NSNotification *)notification
{
    self.hideKeyboardTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboardTapRecognized:)];
    self.hideKeyboardTapRecognizer.cancelsTouchesInView = YES;
    self.hideKeyboardTapRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.hideKeyboardTapRecognizer];
    
}

- (void) keyboardHideNotificationHandler:(NSNotification *)notification
{
    self.hideKeyboardTapRecognizer.delegate = nil;
    [self.view removeGestureRecognizer:self.hideKeyboardTapRecognizer];
    self.hideKeyboardTapRecognizer = nil;
}

#pragma mark - UIPickerView methods

- (void)selectDefaultPickerRow
{
    NSString *language = [NSLocale defaultLanguageCode];
    NSUInteger index = [LANGUAGE_CODES indexOfObject:language];
    [self.pickerGameLanguage selectRow:index inComponent:0 animated:NO];
}

- (NSString *)languageCodeForSelectedPickerRow
{
    return [LANGUAGE_CODES objectAtIndex:[self.pickerGameLanguage selectedRowInComponent:0]];
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
    return [NSLocale localizedLanguageNameForLanguageCode:LANGUAGE_CODES[row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self refreshWordsCountLabelText];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger currentTextLength = [textField.text length];
    NSUInteger replacementTextLength = [string length];
    NSUInteger rangeLength = range.length;
    NSUInteger newLength = currentTextLength - rangeLength + replacementTextLength;
    
    return newLength <= kGameNameLengthLimit;
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //На случай усложнения логики работы жеста скрытия клавиатуры, пока просто возвращаем YES
    return YES;
}

@end
