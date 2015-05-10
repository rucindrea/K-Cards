//
//  ViewController.m
//  K-Cards
//
//  Created by Ru Cindrea on 4/30/15.
//  Copyright (c) 2015 altom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currentName = [defaults objectForKey:@"name"];
 
    if ([currentName isEqualToString:@""]) {
        [self.nameLabel setText:@""];
    }
    else {
        [self.nameLabel setText:currentName];
    }
    [self.view setBackgroundColor:myGreenColor];
    [self.colorLabel setText:myGreenColorText];
}

- (IBAction)changeColor:(id)sender {
    if ([self.view.backgroundColor isEqual:myGreenColor]) {
        [self.view setBackgroundColor:myYellowColor];
        [self.nameLabel setTextColor:[UIColor blackColor]];
        [self.colorLabel setTextColor:[UIColor blackColor]];
        [self.addNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.infoButton setTintColor:[UIColor blackColor]];
        [self.colorLabel setText:myYellowColorText];
    }
    else if ([self.view.backgroundColor isEqual:myYellowColor]) {
        [self.view setBackgroundColor:myRedColor];
        [self.nameLabel setTextColor:[UIColor whiteColor]];
        [self.colorLabel setTextColor:[UIColor whiteColor]];
        [self.addNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.infoButton setTintColor:[UIColor whiteColor]];
        [self.colorLabel setText:myRedColorText];

    }
    else if ([self.view.backgroundColor isEqual:myRedColor]) {
        [self.view setBackgroundColor:myBlueColor];
        [self.colorLabel setText:myBlueColorText];

    }
    else if ([self.view.backgroundColor isEqual:myBlueColor]) {
        [self.view setBackgroundColor:myGreenColor];
        [self.colorLabel setText:myGreenColorText];
    }
    else {
        [self.view setBackgroundColor:myYellowColor];
        [self.colorLabel setText:myYellowColorText];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *currentName = [self.nameLabel text];
    
    if (buttonIndex == 0) {
        //Clicked cancel
        [self.nameLabel setText:currentName];
    }
    else {
        UITextField * alertTextField = [alertView textFieldAtIndex:0];
        NSString *name = [alertTextField.text uppercaseString];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:name forKey:@"name"];
        [defaults synchronize];
        [self.nameLabel setText:name];
    }
}

- (IBAction)addName:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertViewTitle message:alertViewMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] ;
    alertView.tag = 2;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
