//
//  PWGViewController.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 06.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGFirstScreenViewController.h"

static NSString *const kSegueIDFirstToGameSetup = @"First Screen to Game Setup";
static NSString *const kSegueIDFirstToEditDict = @"First Screen to Edit Dict";


@interface PWGFirstScreenViewController ()

@property (weak, nonatomic) IBOutlet UIButton *buttonNewGame;
@property (weak, nonatomic) IBOutlet UIButton *buttonContinueGame;
@property (weak, nonatomic) IBOutlet UIButton *buttonFinishedGames;
@property (weak, nonatomic) IBOutlet UIButton *buttonEditDictionary;


@end

@implementation PWGFirstScreenViewController


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)newGameButtonPressed:(UIButton *)sender
{
    [self performSegueWithIdentifier:kSegueIDFirstToGameSetup sender:self];
}

- (IBAction)continueButtonPressed:(UIButton *)sender
{
    
}

- (IBAction)finishedGamesButtonPressed:(UIButton *)sender
{
    
}

- (IBAction)editDictionaryButtonPressed:(UIButton *)sender
{
    [self performSegueWithIdentifier:kSegueIDFirstToEditDict sender:self];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSegueIDFirstToGameSetup]) {
        
    }
}

@end
