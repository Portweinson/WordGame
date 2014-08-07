//
//  PWGAddWordViewController.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGAddWordViewController.h"

@interface PWGAddWordViewController ()

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
	// Do any additional setup after loading the view.
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


#pragma mark - Actions

- (IBAction)doneButtonPressed:(UIButton *)sender
{
    
}

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}


@end
