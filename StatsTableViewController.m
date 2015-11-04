//
//  StatsTableViewController.m
//  ColorTimer
//
//  Created by Varindra Hart on 10/18/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "StatsTableViewController.h"

@interface StatsTableViewController ()

@property (nonatomic) IBOutletCollection(UILabel) NSArray *labelArray;

@end


@implementation StatsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"Stats";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:217.0/255.0f green:0 blue:0 alpha:1];
    
    NSDictionary *statsDictionary = [[NSUserDefaults standardUserDefaults]objectForKey:@"stats"];
    
    for (UILabel *label in self.labelArray) {
        label.layer.cornerRadius = .5*label.bounds.size.width;
        label.layer.masksToBounds = YES;
        
        switch (label.tag) {
            case 1:
            {
                label.text = [NSString stringWithFormat:@"%@",statsDictionary[@"gamesPlayed"]];
            }
                break;
            case 2:
            {
               label.text = [NSString stringWithFormat:@"%@",statsDictionary[@"longestStreak"]];
            }
                break;
            case 3:
            {
               label.text = [NSString stringWithFormat:@"%@",statsDictionary[@"highestScore"]];
            }
                break;
            case 4:
            {
                label.text = [NSString stringWithFormat:@"%@",statsDictionary[@"streakToDate"]];
            }
                break;
            case 5:
            {
                label.text = [NSString stringWithFormat:@"%@",statsDictionary[@"scoreToDate"]];
            }
                break;
            case 6:
            {
                label.text = [NSString stringWithFormat:@"%.2f s",[statsDictionary[@"fastestReactionTime"] floatValue]];
            }
                break;
            case 7:
            {
                label.text = [NSString stringWithFormat:@"%.2f s",[statsDictionary[@"averageReactionTime"]floatValue]];
            }
                break;
            default:
                break;
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismiss:(UIBarButtonItem *)barButton{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
