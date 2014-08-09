//
//  PWGAddWordViewController.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGAddWordViewController.h"

@interface PWGAddWordViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldWord;
@property (weak, nonatomic) IBOutlet UITextView *textViewDefinition;
@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;
@property (weak, nonatomic) IBOutlet UIButton *buttonDone;

@end


@implementation PWGAddWordViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self decorateTextView];
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


#pragma mark -

- (void)changeDoneButtonStateIfNeeded
{
    self.buttonDone.enabled = [self.textFieldWord.text length];
}


#pragma mark - Actions

- (IBAction)doneButtonPressed:(UIButton *)sender
{
    
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
    return YES;
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
