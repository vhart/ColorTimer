//
//  MenuViewController.m
//  ColorTimer
//
//  Created by Varindra Hart on 9/28/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "MenuViewController.h"
#import "pop/POP.h"
//#import <UIColor+uiGradients/UIColor+uiGradients.h>

float const orbitRadius = 40.0;

@interface MenuViewController ()

@property (nonatomic) IBOutlet UIView *gradientView;
@property (weak, nonatomic) IBOutlet UIView *orbitView;

@property (weak, nonatomic) IBOutlet UIView *classicView;
@property (weak, nonatomic) IBOutlet UIView *challengeView;
@property (weak, nonatomic) IBOutlet UIView *leaderBoardView;
@property (weak, nonatomic) IBOutlet UIView *accoladesView;

@property (nonatomic) CALayer *orbit1;
@property (nonatomic) NSInteger spinCounter;
@end

@implementation MenuViewController

#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setGradient];
    [self addCircularAnimation];
    
    // Do any additional setup after loading the view.
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim1.fromValue = @0;
    anim1.toValue = @(360*M_PI/180);
    anim1.repeatCount = HUGE_VAL;
    anim1.duration = 4.0;
    [self.orbit1 addAnimation:anim1 forKey:@"transform"];
}

- (void) viewDidAppear:(BOOL)animated
{
    self.spinCounter = 0;
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:.3f target:self selector:@selector(shake:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    
}


//- (void)setGradient{
//
//    UIColor *startColor = [UIColor uig_horizonEndColor];
//    UIColor *endColor = [UIColor uig_horizonStartColor];
//
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = self.gradientView.bounds;
//    gradient.position = self.gradientView.center;
//    gradient.startPoint = CGPointMake(0, 0);
//    gradient.endPoint = CGPointMake(1,1);
//    gradient.colors = @[(id)[startColor CGColor], (id)[endColor CGColor]];
//
//    [self.gradientView.layer insertSublayer:gradient atIndex:0];
//
//}

#pragma mark - Circular Animation For Menu
- (void)addCircularAnimation{
    
    self.orbit1 = [CALayer layer];
    self.orbit1.frame = self.orbitView.layer.bounds;
    self.orbit1.position = CGPointMake(self.orbitView.frame.size.width/2, self.orbitView.frame.size.height/2);
    self.orbit1.cornerRadius = orbitRadius;
    self.orbit1.borderColor = [UIColor clearColor].CGColor;
    self.orbit1.borderWidth = 1.5;
    [self.orbitView.layer addSublayer:self.orbit1];
    
    
    CALayer *planet1 = [CALayer layer];
    planet1.bounds = CGRectMake(0,0,30, 30);
    planet1.position = [self coordinateForTheta:90 radius:orbitRadius];
    planet1.cornerRadius = 15;
    planet1.backgroundColor = [UIColor redColor].CGColor;
    
    [self.orbit1 addSublayer:planet1];
    
    CALayer *planet2 = [CALayer layer];
    planet2.bounds = CGRectMake(0,0,30, 30);
    planet2.position = [self coordinateForTheta:(210)radius:(orbitRadius)];
    planet2.cornerRadius = 15;
    planet2.backgroundColor = [UIColor blueColor].CGColor;

    
    [self.orbit1 addSublayer:planet2];
    
    CALayer *planet3 = [CALayer layer];
    planet3.bounds = CGRectMake(0,0,30, 30);
    planet3.position = [self coordinateForTheta:(330)radius:(orbitRadius)];
    planet3.cornerRadius = 15;
    planet3.backgroundColor = [UIColor greenColor].CGColor;
    
    [self.orbit1 addSublayer:planet3];
  
}

- (CGPoint)coordinateForTheta:(float)theta radius:(float)radius{
    
    theta = theta*M_PI / 180;
    float x = radius *cos(theta) + radius;
    x = x>=0 ? x : -x;
    
    float y = radius *sin(theta) - radius;
    y = y>=0 ? y : -y;
    
    CGPoint coordinate = CGPointMake(x, y);
    return coordinate;
}
    
#pragma mark - FBPOP Animations

- (void)shake:(NSTimer *)timer{
    
    POPSpringAnimation *spin = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    spin.fromValue = @(.027);
    spin.toValue = @(0);
    spin.springBounciness = 30;
    spin.velocity = @(5);
    spin.dynamicsTension = 120;
    
    switch (self.spinCounter) {
        case 0:
        {  [self.classicView.layer pop_addAnimation:spin forKey:@"wobble"];
            self.spinCounter++;
            break;
        }
        case 1:
        {  [self.challengeView.layer pop_addAnimation:spin forKey:@"wobble"];
            self.spinCounter++;
            break;
        }
        case 2:
        {  [self.leaderBoardView.layer pop_addAnimation:spin forKey:@"wobble"];
            self.spinCounter++;
            break;
        }
        case 3:
        {  [self.accoladesView.layer pop_addAnimation:spin forKey:@"wobble"];
            self.spinCounter++;
            break;
        }
        
        default:
        {
            [timer invalidate];
            timer = nil;
            self.spinCounter = 0;
        }
            break;
    }
    
}

#pragma mark - Navigation


- (void)viewDidDisappear:(BOOL)animated{
    
}

@end
