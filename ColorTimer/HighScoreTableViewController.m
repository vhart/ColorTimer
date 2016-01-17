//
//  SettingsTableViewController.m
//  ColorTimer
//
//  Created by Varindra Hart on 8/16/15.
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

#import "HighScoreTableViewController.h"
#import "HighScoresModel.h"
#import "HSHeaderView.h"


@interface HighScoreTableViewController ()
@property (nonatomic) NSMutableArray *highStreaksArray;
@property (nonatomic) NSMutableArray *highScoresArray;
@end

@implementation HighScoreTableViewController{
    UIColor * _gold;
    UIColor * _silver;
    UIColor * _bronze;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.highStreaksArray = [NSMutableArray new];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"high streaks"] == nil){
        NSMutableArray *temp = [[NSMutableArray alloc] initWithObjects:
                            @{@"400":@"April"},
                            @{@"350":@"Kelly"},
                            @{@"300":@"V"},
                            @{@"250":@"Mesfin"},
                            @{@"200":@"Nav"},
                            @{@"175":@"Kash"},
                            @{@"150":@"Vic"},
                            @{@"130":@"Mike"},
                            @{@"100":@"Derek"},
                            @{@"50" :@"Max"},
                              nil];
    
        [defaults setObject:temp forKey:@"high streaks"];
    }
    
    self.highScoresArray = [NSMutableArray new];
    
    if([defaults objectForKey:@"high scores"] == nil){
        NSMutableArray *temp = [[NSMutableArray alloc] initWithObjects:
                                @{@"2500":@"April"},
                                @{@"2000":@"Kelly"},
                                @{@"1800":@"V"},
                                @{@"1500":@"Mesfin"},
                                @{@"1000":@"Nav"},
                                @{@"800" :@"Kash"},
                                @{@"600" :@"Vic"},
                                @{@"500" :@"Mike"},
                                @{@"200" :@"Derek"},
                                @{@"100" :@"Max"},
                                  nil];
        
        [defaults setObject:temp forKey:@"high scores"];
    
    }
    
    _gold   = UIColorFromRGB(0xD9C132);
    _silver = UIColorFromRGB(0xB8B8C7);
    _bronze = UIColorFromRGB(0xEF530A);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HSHeaderViewNib" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HSHeaderIdentifier"];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self pullAndReloadData];
}

#pragma mark - Header methods

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HSHeaderView *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HSHeaderIdentifier"];
    switch (section) {
        case 0:
            header.leaderBoardTitle.text = @"HIGH STREAKS";
            break;
        case 1:
            header.leaderBoardTitle.text = @"HIGH SCORES";
            break;
        default:
            break;
    }
    
    return header;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40.0f;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return self.highStreaksArray.count;
    }
    else{
        return self.highScoresArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HighScoresCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
    NSDictionary *cellDictionary = [[NSDictionary alloc] initWithDictionary:[[HighScoresModel sharedModel].highStreakData objectAtIndex:indexPath.row]];
    
    NSString *score = [[cellDictionary allKeys]objectAtIndex:0];
    cell.textLabel.text = score;
    cell.detailTextLabel.text = [cellDictionary objectForKey:score];
        
    }
    
    if (indexPath.section == 1) {
        
        NSDictionary *cellDictionary = [[NSDictionary alloc] initWithDictionary:[[HighScoresModel sharedModel].highScoreData objectAtIndex:indexPath.row]];
        
        NSString *score = [[cellDictionary allKeys]objectAtIndex:0];
        cell.textLabel.text = score;
        cell.detailTextLabel.text = [cellDictionary objectForKey:score];
        
    }

    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.textColor = _gold;
            break;
        case 1:
            cell.detailTextLabel.textColor = _silver;
            break;
        case 2:
            cell.detailTextLabel.textColor = _bronze;
            break;
        default:
            cell.detailTextLabel.textColor = [UIColor blackColor];
            break;
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return @"HIGHEST STREAKS";
            break;
        case 1:
            return @"HIGH SCORES";
            break;
        default:
            break;
    }

    return nil;
}

- (void)pullAndReloadData{

    self.highStreaksArray = [HighScoresModel sharedModel].highStreakData;
    self.highScoresArray = [HighScoresModel sharedModel].highScoreData;
    [self.tableView reloadData];

}

@end