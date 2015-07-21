//
//  K_CardsTests.m
//  K-CardsTests
//
//  Created by Ru Cindrea on 4/30/15.
//  Copyright (c) 2015 altom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController.h"



@interface K_CardsUnitTests : XCTestCase


@property (strong, nonatomic) UIApplication * app;
@property (strong, nonatomic) ViewController * mainViewController;
@property (strong, nonatomic) ViewController *infoViewController;
@property (strong, nonatomic) UIView * mainView;

@end

@implementation K_CardsUnitTests

- (void)setUp {
    [super setUp];
    self.app = [UIApplication sharedApplication];
    self.mainViewController = (ViewController*)[[ViewController alloc] init];
    self.mainView = self.mainViewController.view;
    [self.mainViewController viewDidLoad];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitialColorIsGreen {
    UIColor *initialColor = [self.mainView backgroundColor];
    XCTAssert([initialColor isEqual:myGreenColor], @"Initial color is: %@", initialColor);
}

- (void)testOtherColorAsBackgroundShouldTurnToGreen {
    //change to white, then press to change color:
    [self.mainView setBackgroundColor:[UIColor whiteColor]];
    [self.mainViewController changeColor:[self.mainViewController changeButton]];
    
    UIColor *colorAfterIncorrectBackground = [self.mainView backgroundColor];
    XCTAssert([colorAfterIncorrectBackground isEqual:myYellowColor], @"Color after an incorrect background should be yellow, but is is: %@", colorAfterIncorrectBackground);
}

-(void)testChangeColorToYellow {
    [self.mainViewController changeColor:[self.mainViewController changeButton]];
    UIColor * colorAfterOneChange = [self.mainView backgroundColor];
    XCTAssert([colorAfterOneChange isEqual:myYellowColor], "@Color after one change should be yellow, but is: %@", [self colorAsHex:colorAfterOneChange]);
}


-(void)testChangeColorToRed {
    [self.mainViewController changeColor:[self.mainViewController changeButton]];
    [self.mainViewController changeColor:[self.mainViewController changeButton]];
    
    UIColor * colorAfterTwoChanges = [self.mainView backgroundColor];
    XCTAssert([colorAfterTwoChanges isEqual:myRedColor], "@Color after one change should be red, but is: %@", [self colorAsHex:colorAfterTwoChanges]);
}

-(void)testChangeColorToBlue {
    [self.mainViewController changeColor:[self.mainViewController changeButton]];
    [self.mainViewController changeColor:[self.mainViewController changeButton]];
    [self.mainViewController changeColor:[self.mainViewController changeButton]];
    
    UIColor * colorAfterThreeChanges = [self.mainView backgroundColor];
    XCTAssert([colorAfterThreeChanges isEqual:myBlueColor], "@Color after one change should be blue, but is: %@", [self colorAsHex:colorAfterThreeChanges]);
}

-(void)testChangeColorToGreen {
    [self.mainViewController changeColor:[self.mainViewController changeButton]];
    [self.mainViewController changeColor:[self.mainViewController changeButton]];
    [self.mainViewController changeColor:[self.mainViewController changeButton]];
    [self.mainViewController changeColor:[self.mainViewController changeButton]];
    
    UIColor * colorAfterFourChanges = [self.mainView backgroundColor];
    XCTAssert([colorAfterFourChanges isEqual:myGreenColor], "@Color after one change should be green, but is: %@", [self colorAsHex:colorAfterFourChanges]);
}

-(NSString*)colorAsHex:(UIColor*)color {
    CGFloat rFloat,gFloat,bFloat,aFloat;
    [color getRed:&rFloat green:&gFloat blue: &bFloat alpha: &aFloat];
    int r,g,b,a;
    
    r = (int)(255.0 * rFloat);
    g = (int)(255.0 * gFloat);
    b = (int)(255.0 * bFloat);
    a = (int)(255.0 * aFloat);
    return [NSString stringWithFormat:@"R:%i G:%i B:%i", r, g, b];
}


@end