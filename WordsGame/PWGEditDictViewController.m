//
//  PWGEditDictViewController.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGEditDictViewController.h"
#import "PWGWordsManager.h"
#import "PWGLanguageManager.h"
#import "PWGAlphabets.h"
#import "Word.h"
#import "PWGLanguagePickerView.h"

static NSString *const kCellIDStandardWord = @"standardWordCell";
static NSString *const kCellIDUserWord = @"userWordCell";

static NSString *const kSegueIDEditDictToAddWord = @"EditDict Screen to AddWord";

typedef NS_ENUM(NSInteger, ViewMode) {
    kViewModeEditable = 0,
    kViewModeAllWords
};


@interface PWGEditDictViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *viewFadingBackground;
@property (weak, nonatomic) IBOutlet PWGLanguagePickerView *pickerLanguage;
@property (weak, nonatomic) IBOutlet UIButton *buttonLanguageSelectionDone;
@property (weak, nonatomic) IBOutlet UIButton *buttonLanguageSelectionCancel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segCtrlViewModeSelection;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonSelectLanguage;


@property (strong, nonatomic) NSDictionary *words;
@property (strong, nonatomic) NSArray *letters;
@property (strong, nonatomic) NSString *selectedLanguageCode;
@property (nonatomic) ViewMode viewMode;

@end


@implementation PWGEditDictViewController


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    /////TEMP/////
    [self.pickerLanguage selectDefaultLanguageRow:NO];
    self.navigationItem.title = [LANGUAGE_MANAGER localizedLanguageNameForLanguageCode:self.selectedLanguageCode];
    self.selectedLanguageCode = kLanguageRussian;
    
    
    self.viewMode = self.segCtrlViewModeSelection.selectedSegmentIndex;
    
    if (self.viewMode == kViewModeEditable) {
        self.words = [WORDS_MANAGER wordsSectionedByFirstLetterForLanguage:self.selectedLanguageCode addedByUser:YES];
    } else {
        self.words = [WORDS_MANAGER wordsSectionedByFirstLetterForLanguage:self.selectedLanguageCode];
    }
    
    self.letters = [self.words allKeys];
    //////////////
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)hideLanguagePickerGetureRecognized:(UITapGestureRecognizer *)sender
{
    [self hideLanguageSelectionView];
}

- (IBAction)doneLanguageSelectionButtonPressed:(UIButton *)sender
{
    NSString *selectedLanguage = [self.pickerLanguage languageCodeForSelectedPickerRow];
    
    if (! [selectedLanguage isEqualToString:self.selectedLanguageCode]) {
        self.selectedLanguageCode = selectedLanguage;
        /////TEMP/////
        if (self.viewMode == kViewModeEditable) {
            self.words = [WORDS_MANAGER wordsSectionedByFirstLetterForLanguage:self.selectedLanguageCode addedByUser:YES];
        } else {
            self.words = [WORDS_MANAGER wordsSectionedByFirstLetterForLanguage:self.selectedLanguageCode];
        }
        self.letters = [self.words allKeys];
        [self.tableView reloadData];
        self.navigationItem.title = [LANGUAGE_MANAGER localizedLanguageNameForLanguageCode:self.selectedLanguageCode];
        //////////////
    }
    
    [self hideLanguageSelectionView];
}

- (IBAction)cancelLanguageSelectionButtonPressed:(UIButton *)sender
{
    [self hideLanguageSelectionView];
}

- (IBAction)viewModeSelectionControlValueChanged:(UISegmentedControl *)sender
{
    self.viewMode = sender.selectedSegmentIndex;
    
    /////TEMP/////
    if (self.viewMode == kViewModeEditable) {
        self.words = [WORDS_MANAGER wordsSectionedByFirstLetterForLanguage:self.selectedLanguageCode addedByUser:YES];
    } else {
        self.words = [WORDS_MANAGER wordsSectionedByFirstLetterForLanguage:self.selectedLanguageCode];
    }
    self.letters = [self.words allKeys];
    [self.tableView reloadData];
    self.navigationItem.title = [LANGUAGE_MANAGER localizedLanguageNameForLanguageCode:self.selectedLanguageCode];
    //////////////
}

- (IBAction)selectLanguageButtonPressed:(UIBarButtonItem *)sender
{
    [self showLanguageSelectionView];
}

- (IBAction)adWordButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:kSegueIDEditDictToAddWord sender:self];
}


#pragma mark -

- (void)showLanguageSelectionView
{
    if (self.viewFadingBackground.isHidden) {
        self.viewFadingBackground.alpha = 0.0;
        self.viewFadingBackground.hidden = NO;
        
        [UIView animateWithDuration:0.25 animations:^ {
            self.viewFadingBackground.alpha = 1.0;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)hideLanguageSelectionView
{
    if (! self.viewFadingBackground.isHidden) {
        [UIView animateWithDuration:0.25 animations:^ {
            self.viewFadingBackground.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.viewFadingBackground.hidden = YES;
        }];
    }
}


#pragma mark - Data methods

- (Word *)wordForIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionLetter = [self.letters objectAtIndex:indexPath.section];
    NSArray *sectionWords = [self.words objectForKey:sectionLetter];
    return [sectionWords objectAtIndex:indexPath.row];
}


#pragma mark - UITableViewDelegate/UITableViewDataSource

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
    
    Word *word = [self wordForIndexPath:indexPath];
    
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
    Word *word = [self wordForIndexPath:indexPath];
    
    if ([word.addedByUser boolValue] == YES) {
        [self performSegueWithIdentifier:kSegueIDEditDictToAddWord sender:self];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.letters objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [PWGAlphabets alphabetForLanguageWithCode:self.selectedLanguageCode];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [self.letters indexOfObject:title];
}


@end
