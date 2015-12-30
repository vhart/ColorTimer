//
//  SettingsViewController.m
//  ColorTimer
//
//  Created by Varindra Hart on 8/16/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "SettingsViewController.h"
#import "NSUserDefaults+Updates.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UIView *settingOptionsView;
@property (weak, nonatomic) IBOutlet UISwitch *vibrationSwitch;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.settingOptionsView.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideSettingsView) name:@"HideSettingsView" object:nil];

    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"Vibrations"]) {
        [[NSUserDefaults standardUserDefaults]setObject:@YES forKey:@"Vibrations"];
    }

    self.vibrationSwitch.on = [NSUserDefaults vibrationStatus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)menuButtonTapped:(UIButton *)sender {
    
    NSLog(@"tapped");
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DismissMainViewControllerNotification" object:nil];
    
}
- (IBAction)settingsButtonTapped:(id)sender {

    self.settingOptionsView.hidden = self.settingOptionsView.hidden? NO : YES;
}

- (IBAction)vibrationSwitchToggled:(UISwitch *)sender {

    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:sender.on] forKey:@"Vibrations"];

}

- (void)hideSettingsView{

    self.settingOptionsView.hidden = YES;
}

@end
