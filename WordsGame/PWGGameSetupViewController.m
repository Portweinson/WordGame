//
//  PWGGameSetupViewController.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGGameSetupViewController.h"
#import "PWGWordsManager.h"
#import "Game+Extended.h"
#import "PWGLanguagePickerView.h"

static NSString *const kSegueIDGameSetupToGame = @"Game setup to Game";


@interface PWGGameSetupViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate, PWGLanguagePickerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonDone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldGameName;
@property (weak, nonatomic) IBOutlet PWGLanguagePickerView *pickerGameLanguage;
@property (weak, nonatomic) IBOutlet UILabel *labelWordsCount;

@property (nonatomic, strong) UITapGestureRecognizer *hideKeyboardTapRecognizer;

@end


@implementation PWGGameSetupViewController


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.pickerGameLanguage.pickerDelegate = self;
    [self.pickerGameLanguage selectDefaultLanguageRow:NO];
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
    NSUInteger count = [WORDS_MANAGER wordsCountForLanguageCode:[self.pickerGameLanguage languageCodeForSelectedPickerRow]];
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


#pragma mark - PWGLanguagePickerDelegate

- (void)languagePicker:(PWGLanguagePickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
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
