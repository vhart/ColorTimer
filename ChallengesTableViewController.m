//
//  ChallengesTableViewController.m
//  ColorTimer
//
//  Created by Varindra Hart on 10/5/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#import "ChallengesTableViewController.h"
#import "AppDelegate.h"
#import "Challenge.h"
#import "MainViewController.h"
#import "ChallengesCustomHeaderView.h"

@interface ChallengesTableViewController () <NSFetchedResultsControllerDelegate>
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@end

@implementation ChallengesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"Challenges";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ChallengesCustomHeaderViewNib" bundle:nil] forHeaderFooterViewReuseIdentifier:@"ChallengesHeaderIdentifier"];
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Challenge"];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"challengeIDNumber" ascending:YES]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [self.fetchedResultsController performFetch:nil];
    
    if (self.fetchedResultsController.fetchedObjects.count == 0) {
        [self makeAllChallenges:delegate];
    }
    
    
    [delegate.managedObjectContext save:nil];
    
    
}

- (void)makeAllChallenges:(AppDelegate *)delegate{
    Challenge *one = [NSEntityDescription insertNewObjectForEntityForName:@"Challenge" inManagedObjectContext:delegate.managedObjectContext];
    Challenge *two = [NSEntityDescription insertNewObjectForEntityForName:@"Challenge" inManagedObjectContext:delegate.managedObjectContext];
    Challenge *three = [NSEntityDescription insertNewObjectForEntityForName:@"Challenge" inManagedObjectContext:delegate.managedObjectContext];
    Challenge *four = [NSEntityDescription insertNewObjectForEntityForName:@"Challenge" inManagedObjectContext:delegate.managedObjectContext];
    Challenge *five = [NSEntityDescription insertNewObjectForEntityForName:@"Challenge" inManagedObjectContext:delegate.managedObjectContext];
    Challenge *six = [NSEntityDescription insertNewObjectForEntityForName:@"Challenge" inManagedObjectContext:delegate.managedObjectContext];
    Challenge *seven = [NSEntityDescription insertNewObjectForEntityForName:@"Challenge" inManagedObjectContext:delegate.managedObjectContext];
    Challenge *eight = [NSEntityDescription insertNewObjectForEntityForName:@"Challenge" inManagedObjectContext:delegate.managedObjectContext];
    Challenge *nine = [NSEntityDescription insertNewObjectForEntityForName:@"Challenge" inManagedObjectContext:delegate.managedObjectContext];
    Challenge *ten = [NSEntityDescription insertNewObjectForEntityForName:@"Challenge" inManagedObjectContext:delegate.managedObjectContext];
    Challenge *eleven = [NSEntityDescription insertNewObjectForEntityForName:@"Challenge" inManagedObjectContext:delegate.managedObjectContext];
    Challenge *twelve = [NSEntityDescription insertNewObjectForEntityForName:@"Challenge" inManagedObjectContext:delegate.managedObjectContext];
    
    
    [one setValue:@"Get 5 50+ streaks" forKey:@"challengeDescription"];
    [one setValue:[NSNumber numberWithBool:YES] forKey:@"streakChallenge"];
    [one setValue:@50 forKey:@"streakMax"];
    [one setValue:@5 forKey:@"numberOfSuccessesNeeded"];
    [one setValue:@0 forKey:@"currentNumberOfSuccesses"];
    [one setValue:@"Great job! 5/5" forKey:@"challengeCompletedMessage"];
    [one setValue:@0.1 forKey:@"challengeIDNumber"];
    
    [two setValue:@"Get 5 200+ score runs" forKey:@"challengeDescription"];
    [two setValue:[NSNumber numberWithBool:YES] forKey:@"scoreChallenge"];
    [two setValue:@200 forKey:@"scoreMax"];
    [two setValue:@5 forKey:@"numberOfSuccessesNeeded"];
    [two setValue:@0 forKey:@"currentNumberOfSuccesses"];
    [two setValue:@"Great job! 5/5" forKey:@"challengeCompletedMessage"];
    [two setValue:@0.2 forKey:@"challengeIDNumber"];
    
    [three setValue:@"Get 5 100+ streaks" forKey:@"challengeDescription"];
    [three setValue:[NSNumber numberWithBool:YES] forKey:@"streakChallenge"];
    [three setValue:@100 forKey:@"streakMax"];
    [three setValue:@5 forKey:@"numberOfSuccessesNeeded"];
    [three setValue:@0 forKey:@"currentNumberOfSuccesses"];
    [three setValue:@"Great job! 5/5" forKey:@"challengeCompletedMessage"];
    [three setValue:@0.3 forKey:@"challengeIDNumber"];
    
    [four setValue:@"Get 5 consecutive 100+ streaks" forKey:@"challengeDescription"];
    [four setValue:[NSNumber numberWithBool:YES] forKey:@"streakChallenge"];
    [four setValue:@YES forKey:@"consecutiveChallenge"];
    [four setValue:@100 forKey:@"streakMax"];
    [four setValue:@5 forKey:@"numberOfSuccessesNeeded"];
    [four setValue:@0 forKey:@"currentNumberOfSuccesses"];
    [four setValue:@"Great job! 5/5" forKey:@"challengeCompletedMessage"];
    [four setValue:@1.1 forKey:@"challengeIDNumber"];
    
    [five setValue:@"Get 3 consecutive 150+ streaks" forKey:@"challengeDescription"];
    [five setValue:[NSNumber numberWithBool:YES] forKey:@"streakChallenge"];
    [five setValue:@150 forKey:@"streakMax"];
    [five setValue:@3 forKey:@"numberOfSuccessesNeeded"];
    [five setValue:@0 forKey:@"currentNumberOfSuccesses"];
    [five setValue:@"Great job! 3/3" forKey:@"challengeCompletedMessage"];
    [five setValue:@YES forKey:@"consecutiveChallenge"];
    [five setValue:@1.2 forKey:@"challengeIDNumber"];
    
    [six setValue:@"Get 3 consecutive 700+ score runs" forKey:@"challengeDescription"];
    [six setValue:[NSNumber numberWithBool:YES] forKey:@"scoreChallenge"];
    [six setValue:@600 forKey:@"scoreMax"];
    [six setValue:@3 forKey:@"numberOfSuccessesNeeded"];
    [six setValue:@0 forKey:@"currentNumberOfSuccesses"];
    [six setValue:@"Great job! 3/3" forKey:@"challengeCompletedMessage"];
    [six setValue:@1.3 forKey:@"challengeIDNumber"];
    
    [seven setValue:@"Get a 60+ streak in 30 seconds" forKey:@"challengeDescription"];
    [seven setValue:[NSNumber numberWithBool:YES] forKey:@"streakChallenge"];
    [seven setValue:[NSNumber numberWithBool:YES] forKey:@"speedChallenge"];
    [seven setValue:@60 forKey:@"streakMax"];
    [seven setValue:@30 forKey:@"timeMax"];
    [seven setValue:@1 forKey:@"numberOfSuccessesNeeded"];
    [seven setValue:@0 forKey:@"currentNumberOfSuccesses"];
    [seven setValue:@"Great job! 1/1" forKey:@"challengeCompletedMessage"];
    [seven setValue:@2.1 forKey:@"challengeIDNumber"];
    
    [eight setValue:@"Get a 350+ score in 30 seconds" forKey:@"challengeDescription"];
    [eight setValue:[NSNumber numberWithBool:YES] forKey:@"scoreChallenge"];
    [eight setValue:[NSNumber numberWithBool:YES] forKey:@"speedChallenge"];
    [eight setValue:@350 forKey:@"scoreMax"];
    [eight setValue:@30 forKey:@"timeMax"];
    [eight setValue:@1 forKey:@"numberOfSuccessesNeeded"];
    [eight setValue:@0 forKey:@"currentNumberOfSuccesses"];
    [eight setValue:@"Great job! 1/1" forKey:@"challengeCompletedMessage"];
    [eight setValue:@2.2 forKey:@"challengeIDNumber"];
    
    
    [nine setValue:@"Get a 22+ streak in 10 seconds" forKey:@"challengeDescription"];
    [nine setValue:[NSNumber numberWithBool:YES] forKey:@"streakChallenge"];
    [nine setValue:[NSNumber numberWithBool:YES] forKey:@"speedChallenge"];
    [nine setValue:@22 forKey:@"streakMax"];
    [nine setValue:@10 forKey:@"timeMax"];
    [nine setValue:@1 forKey:@"numberOfSuccessesNeeded"];
    [nine setValue:@0 forKey:@"currentNumberOfSuccesses"];
    [nine setValue:@"Great job! 1/1" forKey:@"challengeCompletedMessage"];
    [nine setValue:@2.3 forKey:@"challengeIDNumber"];
    
    [ten setValue:@"Get a 175+ score in 15 seconds" forKey:@"challengeDescription"];
    [ten setValue:[NSNumber numberWithBool:YES] forKey:@"scoreChallenge"];
    [ten setValue:[NSNumber numberWithBool:YES] forKey:@"speedChallenge"];
    [ten setValue:@175 forKey:@"scoreMax"];
    [ten setValue:@15 forKey:@"timeMax"];
    [ten setValue:@1 forKey:@"numberOfSuccessesNeeded"];
    [ten setValue:@0 forKey:@"currentNumberOfSuccesses"];
    [ten setValue:@"Great job! 1/1" forKey:@"challengeCompletedMessage"];
    [ten setValue:@2.4 forKey:@"challengeIDNumber"];
    
    [eleven setValue:@"Get a 70+ streak " forKey:@"challengeDescription"];
    [eleven setValue:[NSNumber numberWithBool:YES] forKey:@"streakChallenge"];
    [eleven setValue:[NSNumber numberWithBool:YES] forKey:@"speedChallenge"];
    [eleven setValue:@70 forKey:@"streakMax"];
    [eleven setValue:@1 forKey:@"timeMax"];
    [eleven setValue:@1 forKey:@"numberOfSuccessesNeeded"];
    [eleven setValue:@0 forKey:@"currentNumberOfSuccesses"];
    [eleven setValue:@"Great job! 1/1" forKey:@"challengeCompletedMessage"];
    [eleven setValue:@3.1 forKey:@"challengeIDNumber"];
    
    [twelve setValue:@"Get a 650+ score" forKey:@"challengeDescription"];
    [twelve setValue:[NSNumber numberWithBool:YES] forKey:@"scoreChallenge"];
    [twelve setValue:[NSNumber numberWithBool:YES] forKey:@"speedChallenge"];
    [twelve setValue:@650 forKey:@"scoreMax"];
    [twelve setValue:@1 forKey:@"timeMax"];
    [twelve setValue:@1 forKey:@"numberOfSuccessesNeeded"];
    [twelve setValue:@0 forKey:@"currentNumberOfSuccesses"];
    [twelve setValue:@"Great job! 1/1" forKey:@"challengeCompletedMessage"];
    [twelve setValue:@3.2 forKey:@"challengeIDNumber"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table View Header view Methods

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ChallengesCustomHeaderView *customHeader = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ChallengesHeaderIdentifier"];
    
    switch (section) {
        case 0:
        {
            customHeader.colorLabel.backgroundColor = UIColorFromRGB(0x12B149);
            customHeader.challengeLabel.text = @"Practice Makes Perfect";
            break;
        }
        case 1:
        {
            customHeader.colorLabel.backgroundColor = UIColorFromRGB(0x00C1D9);
            customHeader.challengeLabel.text = @"Consistency Is Key";
            break;
        }
        case 2:
        {
            customHeader.colorLabel.backgroundColor = UIColorFromRGB(0xD94000);
            customHeader.challengeLabel.text = @"Timing Is Everything";
            break;
        }
        case 3:
        {
            customHeader.colorLabel.backgroundColor = [UIColor blackColor];
            customHeader.challengeLabel.text = @"Panic! Lose .5s per 5 streak";
        }
        default:
            break;
    }
    customHeader.colorLabel.layer.cornerRadius = 15;
    customHeader.colorLabel.layer.masksToBounds = YES;
    
    return customHeader;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40.0f;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 4;
            break;
        case 3:
            return 2;
            break;
        default:
            return 0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChallengeCellIdentifier" forIndexPath:indexPath];
    NSMutableArray *challengesArray = [NSMutableArray arrayWithArray:self.fetchedResultsController.fetchedObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%d<%K AND %K <%d",indexPath.section,@"challengeIDNumber",@"challengeIDNumber",indexPath.section+1];
    NSArray *newArray = [challengesArray filteredArrayUsingPredicate:predicate];
    Challenge *challenge = newArray[indexPath.row];
    cell.textLabel.text = challenge.challengeDescription;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@/%@",challenge.currentNumberOfSuccesses,challenge.numberOfSuccessesNeeded];
    // Configure the cell...
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    switch (section) {
//        case 0:
//            return @"Practice Makes Perfect";
//            break;
//        case 1:
//            return @"Consistency Is Key";
//            break;
//        case 2:
//            return @"Timing Is Everything";
//            break;
//        default:
//            return nil;
//            break;
//    }
//    
//}
#pragma mark - NSFetchedResultsController Delegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    [self.tableView reloadData];
    
}

- (IBAction)menuButtonTapped:(UIBarButtonItem *)sender {
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%d<%K AND %K <%d",indexPath.section,@"challengeIDNumber",@"challengeIDNumber",indexPath.section+1];
    NSArray *newArray = [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:predicate];
    Challenge *chal = newArray[indexPath.row];
//    chal.currentNumberOfSuccesses = @0;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    [self.tableView reloadData];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%d<%K AND %K <%d",indexPath.section,@"challengeIDNumber",@"challengeIDNumber",indexPath.section+1]; 
    NSArray *newArray = [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:predicate];
    Challenge *chal = newArray[indexPath.row];
    MainViewController *mainVC = segue.destinationViewController;
    mainVC.currentChallenge = chal;
    
}


@end
