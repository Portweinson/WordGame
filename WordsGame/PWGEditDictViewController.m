//
//  PWGEditDictViewController.m
//  WordsGame
//
//  Created by Vjacheslav Embaturov on 07.08.14.
//  Copyright (c) 2014 Portweinson. All rights reserved.
//

#import "PWGEditDictViewController.h"
#import "PWGAddWordViewController.h"
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


@interface PWGEditDictViewController () <UITableViewDataSource, UITableViewDelegate, PWGAddWordViewControllerDelegate>

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
@property (strong, nonatomic) Word *selectedWord;

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
    self.selectedLanguageCode = kLanguageRussian;
    self.navigationItem.title = [[LANGUAGE_MANAGER localizedLanguageNameForLanguageCode:self.selectedLanguageCode] capitalizedString];
    
    
    self.viewMode = self.segCtrlViewModeSelection.selectedSegmentIndex;
    
    [self refreshDataSourceWithCompletion:^(BOOL success, NSError *error) {}];
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
        [self refreshDataSourceWithCompletion:^(BOOL success, NSError *error) {
            [self.tableView reloadData];
            self.navigationItem.title = [[LANGUAGE_MANAGER localizedLanguageNameForLanguageCode:self.selectedLanguageCode] capitalizedString];
        }];
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
    [self refreshDataSourceWithCompletion:^(BOOL success, NSError *error) {
        [self.tableView reloadData];
        self.navigationItem.title = [[LANGUAGE_MANAGER localizedLanguageNameForLanguageCode:self.selectedLanguageCode] capitalizedString];
    }];
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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSegueIDEditDictToAddWord]) {
        PWGAddWordViewController *controller = (PWGAddWordViewController *)segue.destinationViewController;
        controller.delegate = self;
        controller.word = self.selectedWord;
        controller.language = self.selectedLanguageCode;
        self.selectedWord = nil;
    }
}


#pragma mark - Data methods

- (Word *)wordForIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionLetter = [self.letters objectAtIndex:indexPath.section];
    NSArray *sectionWords = [self.words objectForKey:sectionLetter];
    return [sectionWords objectAtIndex:indexPath.row];
}

- (void)refreshDataSourceWithCompletion:(void(^)(BOOL success, NSError *error))completion
{
    if (self.viewMode == kViewModeEditable) {
        self.words = [WORDS_MANAGER wordsSectionedByFirstLetterForLanguage:self.selectedLanguageCode addedByUser:YES];
    } else {
        self.words = [WORDS_MANAGER wordsSectionedByFirstLetterForLanguage:self.selectedLanguageCode];
    }
    
    self.letters = [[self.words allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSString *)obj1 localizedCaseInsensitiveCompare:(NSString *)obj2];
    }];
    completion(YES, nil);
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
    cell.textLabel.text = word.spelling;
    
    NSUInteger useCount = [word.useCount integerValue];
    cell.detailTextLabel.text = (useCount > 0) ? [NSString stringWithFormat:@"%li", [word.useCount integerValue]] : @"";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Word *word = [self wordForIndexPath:indexPath];
    BOOL wordWithoutDefinition = ![word.definition length] && [word.addedByUser boolValue];
    
    if (wordWithoutDefinition) {
        cell.imageView.image = [UIImage imageNamed:@"question mark icon"];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.imageView.image = nil;
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Word *word = [self wordForIndexPath:indexPath];
    
    if ([word.addedByUser boolValue] == YES) {
        self.selectedWord = word;
        [self performSegueWithIdentifier:kSegueIDEditDictToAddWord sender:self];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.letters objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    Word *word = [self wordForIndexPath:indexPath];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[word.spelling capitalizedString] message:word.definition delegate:nil cancelButtonTitle:NSLocalizedString(@"EDVC ALERT BUTTON CANCEL show word definition", nil) otherButtonTitles:nil];
    [alert show];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [PWGAlphabets alphabetForLanguageWithCode:self.selectedLanguageCode];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [self.letters indexOfObject:title];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    Word *word = [self wordForIndexPath:indexPath];
    return [word.addedByUser boolValue];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Word *word = [self wordForIndexPath:indexPath];
        NSString *sectionLetter = [self.letters objectAtIndex:indexPath.section];
        NSArray *sectionWords = [self.words objectForKey:sectionLetter];
        NSUInteger wordsCountInSection = [sectionWords count];
        
        [WORDS_MANAGER deleteWord:word completion:^(BOOL success, NSError *error) {
            if (success) {
                /////TEMP/////
                [self refreshDataSourceWithCompletion:^(BOOL success, NSError *error) {
                    [tableView beginUpdates];
                    
                    if (wordsCountInSection > 1) {
                        [tableView deleteRowsAtIndexPaths:@[indexPath]
                                         withRowAnimation:UITableViewRowAnimationAutomatic];
                    } else {
                        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                                 withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                    
                    [tableView endUpdates];
                }];
                //////////////
            }
        }];
    }
}


#pragma mark - PWGAddWordViewControllerDelegate

- (void)wordAdded:(Word *)word
{
    [self refreshDataSourceWithCompletion:^(BOOL success, NSError *error) {
        [self.tableView reloadData];
    }];}


@end
