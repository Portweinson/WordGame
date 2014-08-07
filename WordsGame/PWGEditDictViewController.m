//
//  PWGEditDictViewController.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGEditDictViewController.h"
#import "PWGWordsManager.h"
#import "Word.h"

static NSString *const kCellIDStandardWord = @"standardWordCell";
static NSString *const kCellIDUserWord = @"userWordCell";


@interface PWGEditDictViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSDictionary *words;
@property (strong, nonatomic) NSArray *letters;

@end


@implementation PWGEditDictViewController


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    /////TEMP/////
    self.words = [WORDS_MANAGER wordsSectionedByFirstLetterForLanguage:kLanguageRussian];
    self.letters = [self.words allKeys];
    //////////////
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate/UITableViewDataSource

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.letters count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionLetter = [self.letters objectAtIndex:section];
    NSArray *sectionAnimals = [self.words objectForKey:sectionLetter];
    return [sectionAnimals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    NSString *sectionLetter = [self.letters objectAtIndex:indexPath.section];
    NSArray *sectionWords = [self.words objectForKey:sectionLetter];
    Word *word = [sectionWords objectAtIndex:indexPath.row];
    
    if ([word.addedByUser boolValue] == YES) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIDUserWord];
    } else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIDStandardWord];
    }
    cell.textLabel.text = word.word;
    
    NSUInteger useCount = [word.useCount integerValue];
    cell.detailTextLabel.text = (useCount > 0) ? [NSString stringWithFormat:@"%li", [word.useCount integerValue]] : @"";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.letters objectAtIndex:section];
}


@end
