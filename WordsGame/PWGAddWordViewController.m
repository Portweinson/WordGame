//
//  PWGAddWordViewController.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGAddWordViewController.h"
#import "PWGWordsManager.h"
#import "PWGAlphabets.h"
#import "Word.h"

@interface PWGAddWordViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldWord;
@property (weak, nonatomic) IBOutlet UITextView *textViewDefinition;
@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;
@property (weak, nonatomic) IBOutlet UIButton *buttonDone;

@property (strong, nonatomic) NSCharacterSet *restrictedCharacters;

@end


@implementation PWGAddWordViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self decorateTextView];
    [self prepareDataRepresentation];
    [self changeDoneButtonStateIfNeeded];
    [self.textFieldWord becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldTextChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.textFieldWord];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidChangeNotification
                                                  object:self.textFieldWord];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - View additional setup

- (void)decorateTextView
{
    self.textViewDefinition.layer.borderColor = RGBColor(220, 220, 220).CGColor;
    self.textViewDefinition.layer.borderWidth = 0.8f;
    self.textViewDefinition.layer.cornerRadius = 8.0f;
}

- (void)prepareDataRepresentation
{
    if (self.word) {
        self.textFieldWord.text = self.word.spelling;
        self.textViewDefinition.text = self.word.definition;
    } else if (self.spelling) {
        self.textFieldWord.text = self.spelling;
    }
}


#pragma mark - Custom getters/setters

- (NSCharacterSet *)restrictedCharacters
{
    if (! _restrictedCharacters) {
        _restrictedCharacters = [[PWGAlphabets allowedWordCharactersForLanguage:self.language] invertedSet];
    }
    return _restrictedCharacters;
}


#pragma mark -

- (void)changeDoneButtonStateIfNeeded
{
    self.buttonDone.enabled = [self.textFieldWord.text length];
}


#pragma mark - Actions

- (IBAction)doneButtonPressed:(UIButton *)sender
{
    NSString *spelling = [self.textFieldWord.text lowercaseString];
    BOOL saveAllowed = YES;
    
    if (!self.word || ![self.word.spelling isEqualToString:spelling]) {
        saveAllowed = ! [WORDS_MANAGER wordSpelled:spelling existForLanguage:self.language];
    }

    if (saveAllowed) {
        [WORDS_MANAGER saveWord:self.word spelling:spelling definition:self.textViewDefinition.text language:self.language completion:^(BOOL success, Word*savedWord) {
            if (success) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(wordAdded:)]) {
                    [self.delegate wordAdded:savedWord];
                }
                [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
            }
        }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"AWVC ALERT TITLE word exist", nil), spelling]
                                                        message:NSLocalizedString(@"AWVC ALERT MESSAGE word exist", nil)
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"AWVC ALERT BUTTON CANCEL word exist", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }

}

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark - UITextFieldDelegate

- (void)textFieldTextChanged:(id)notification
{
    [self changeDoneButtonStateIfNeeded];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textViewDefinition becomeFirstResponder];
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChange = NO;
    
    shouldChange = ([string rangeOfCharacterFromSet:self.restrictedCharacters].location == NSNotFound) ? YES : NO;
    if (range.location == 0) {
        NSCharacterSet *restrictedFirstLettersSet = [PWGAlphabets restrictedFirstLetterCharactersForLanguage:self.language];
        shouldChange = ([string rangeOfCharacterFromSet:restrictedFirstLettersSet].location == NSNotFound) ? shouldChange : NO;
    }
    
    return shouldChange;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.textFieldWord resignFirstResponder];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}


#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}


@end
