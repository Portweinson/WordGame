//
//  PWGGameViewController.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGGameViewController.h"

@interface PWGGameViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewInput;
@property (weak, nonatomic) IBOutlet UITextField *textFieldInputWord;


@end

@implementation PWGGameViewController


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)exitGameButtonPressed:(UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)endGameButtonPressed:(UIBarButtonItem *)sender
{
    
}


#pragma mark - TextField Keyboard notification handler

- (double)keyboardAnimationDurationForNotification:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    NSNumber *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    return duration.doubleValue;
}

- (int)keyboardAnimationOptionsType:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    NSNumber *curveValue = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    return [curveValue intValue];
}

- (CGRect)keyboardBeginRect:(NSNotification *)notification
{
    NSDictionary* info = notification.userInfo;
    NSValue* keyboardFrameBegin = [info valueForKey:UIKeyboardFrameBeginUserInfoKey];
    return [keyboardFrameBegin CGRectValue];
}

- (CGRect)keyboardEndRect:(NSNotification *)notification
{
    NSDictionary* info = notification.userInfo;
    NSValue* keyboardFrameEnd = [info valueForKey:UIKeyboardFrameEndUserInfoKey];
    return [keyboardFrameEnd CGRectValue];
}

- (void) keyboardHideNotificationHandler:(NSNotification *)notification
{
    CGRect keyboardFrame = [self keyboardEndRect:notification];
    
    [UIView animateWithDuration:[self keyboardAnimationDurationForNotification:notification]
                          delay:0
                        options:[self keyboardAnimationOptionsType:notification] << 16
                     animations:^ {
                         self.viewInput.frame = CGRectOffset(self.viewInput.frame, 0, keyboardFrame.size.height);
                     }
                     completion: ^(BOOL completion) {
                         
                     }];
}

- (void) keyboardShowNotificationHandler:(NSNotification *)notification
{
    CGRect keyboardFrame = [self keyboardEndRect:notification];
    
    [UIView animateWithDuration:[self keyboardAnimationDurationForNotification:notification]
                          delay:0
                        options:[self keyboardAnimationOptionsType:notification] << 16
                     animations:^ {
                         self.viewInput.frame = CGRectOffset(self.viewInput.frame, 0, - keyboardFrame.size.height);
                     }
                     completion: ^(BOOL completion) {
                         
                     }];
}

@end
