//
//  ViewController.h
//  K-Cards
//
//  Created by Ru Cindrea on 4/30/15.
//  Copyright (c) 2015 altom. All rights reserved.
//

#import <UIKit/UIKit.h>

#define myGreenColor [UIColor colorWithRed:56.0/255.0 green:146.0/255.0 blue:9.0/255.0 alpha:1.0]
#define myBlueColor [UIColor colorWithRed:0.0/255.0 green:95.0/255.0 blue:200.0/255.0 alpha:1.0]
#define myYellowColor [UIColor colorWithRed:237.0/255.0 green:227.0/255.0 blue:12.0/255.0 alpha:1.0]
#define myRedColor [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]

#define myGreenColorText @"Green - New Thread"
#define myBlueColorText @"Blue - Rat hole/going nowhere"
#define myYellowColorText @"Yellow - Same Thread"
#define myRedColorText @"Red - I MUST SPEAK RIGHT NOW!"

#define alertViewMessage @"Add your name or your assigned number.\n\nIf your name is long and shows up too small, try to hold the device in landscape mode when you show it to your facilitator."
#define alertViewTitle @"Add Name"

#define addNameButtonText @"Add Name/Number"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIButton *addNameButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

- (IBAction)addName:(id)sender;
- (IBAction)changeColor:(id)sender;

@end

