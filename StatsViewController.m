//
//  StatsViewController.m
//  ColorTimer
//
//  Created by Varindra Hart on 10/16/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "StatsViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface StatsViewController ()
@property (nonatomic) IBOutletCollection(UILabel)NSArray *bulletPointArray;

@end

@implementation StatsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"Stats";
    
    
    for (UILabel *label in self.bulletPointArray) {
        label.layer.cornerRadius = .5*label.bounds.size.width;
        label.layer.masksToBounds = YES;
    }
    // Do any additional setup after loading the view.
}


    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)menuButtonTapped:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
