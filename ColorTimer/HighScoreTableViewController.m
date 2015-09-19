//
//  SettingsTableViewController.m
//  ColorTimer
//
//  Created by Varindra Hart on 8/16/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "HighScoreTableViewController.h"
#import "HighScoresModel.h"

@interface HighScoreTableViewController ()

@property (nonatomic) NSMutableArray *highScoresArray;
@end

@implementation HighScoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.highScoresArray = [NSMutableArray new];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"high streak"] == nil){
        NSMutableArray *temp = [[NSMutableArray alloc] initWithObjects:@{@"200":@"April"},
                          @{@"175":@"Derrick"},
                          @{@"160":@"Kelly"},
                          @{@"150":@"Mesfin"},
                          @{@"140":@"Nav"},
                          @{@"130":@"Kash"},
                          @{@"120":@"Vic"},
                          @{@"110":@"Mike"},
                          @{@"100":@"Max"},
                          @{@"90" :@"V"},
                             nil];
    
        [defaults setObject:temp forKey:@"high streak"];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.highScoresArray = [HighScoresModel sharedModel].highStreakData;
    [self.tableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.highScoresArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HighScoresCell" forIndexPath:indexPath];
    NSDictionary *cellDictionary = [[NSDictionary alloc] initWithDictionary:[[HighScoresModel sharedModel].highStreakData objectAtIndex:indexPath.row]];
    
    NSString *score = [[cellDictionary allKeys]objectAtIndex:0];
    cell.textLabel.text = score;
    cell.detailTextLabel.text = [cellDictionary objectForKey:score];
    // Configure the cell...
    
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"HIGHEST STREAKS";
    }
    
    return nil;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
