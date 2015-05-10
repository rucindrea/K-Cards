//
//  UITests.m
//  K-Cards
//
//  Created by Ru Cindrea on 5/10/15.
//  Copyright (c) 2015 altom. All rights reserved.
//

#import <KIF/KIF.h>
#import "ViewController.h"

#define moreInfoURL @"http://testingthoughts.com/blog/26"

@interface UITests: KIFTestCase

@property KIFSystemTestActor * sysTester;

@end

@implementation UITests

- (void)beforeEach
{
    //setup
    self.sysTester = [[KIFSystemTestActor alloc] init];
    
    [self.sysTester simulateDeviceRotationToOrientation:UIDeviceOrientationPortrait];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:@"name"];
    [defaults synchronize];
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = [window.rootViewController.storyboard instantiateInitialViewController];
}

- (void)afterEach
{
    //teardown
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:@"name"];
    [defaults synchronize];
    [self.sysTester simulateDeviceRotationToOrientation:UIDeviceOrientationPortrait];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = [window.rootViewController.storyboard instantiateInitialViewController];

}


//============ INFO SCREEN TESTS ==============

-(void)testInfoScreenTextIsScrollablePortrait {
    [tester tapViewWithAccessibilityLabel:@"infoButton"];
    UITextView * infoTextView = (UITextView*)[tester waitForViewWithAccessibilityLabel:@"infoTextView"];
    XCTAssert([infoTextView isScrollEnabled], @"Info text view should be scroll enabled");
}

-(void)testInfoScreenTextIsScrollableLandscape {
    [self.sysTester simulateDeviceRotationToOrientation:UIDeviceOrientationLandscapeLeft];
    [tester tapViewWithAccessibilityLabel:@"infoButton"];
    UITextView * infoTextView = (UITextView*)[tester waitForViewWithAccessibilityLabel:@"infoTextView"];
    XCTAssert([infoTextView isScrollEnabled], @"Info text view should be scroll enabled");
}

-(void)testInfoScreenTextIsVisiblePortrait {
    [tester tapViewWithAccessibilityLabel:@"infoButton"];
    UITextView * infoTextView = (UITextView*)[tester waitForViewWithAccessibilityLabel:@"infoTextView"];
    XCTAssert([[infoTextView text] containsString:moreInfoURL], @"Info text should contain URL with more info.");
}

-(void)testInfoScreenTextIsVisibleLandscape {
    [self.sysTester simulateDeviceRotationToOrientation:UIDeviceOrientationLandscapeLeft];
    [tester tapViewWithAccessibilityLabel:@"infoButton"];
    UITextView * infoTextView = (UITextView*)[tester waitForViewWithAccessibilityLabel:@"infoTextView"];
    XCTAssert([[infoTextView text] containsString:moreInfoURL], @"Info text should contain URL with more info.");
}

-(void)testInfoScreenTextIsSelectablePortrait {
    [tester tapViewWithAccessibilityLabel:@"infoButton"];
    UITextView * infoTextView = (UITextView*)[tester waitForViewWithAccessibilityLabel:@"infoTextView"];
    XCTAssert([infoTextView isSelectable], @"Info text view should be selectable");
}

-(void)testInfoScreenTextIsSelectableLandscape {
    [self.sysTester simulateDeviceRotationToOrientation:UIDeviceOrientationLandscapeLeft];
    [tester tapViewWithAccessibilityLabel:@"infoButton"];
    UITextView * infoTextView = (UITextView*)[tester waitForViewWithAccessibilityLabel:@"infoTextView"];
    XCTAssert([infoTextView isSelectable], @"Info text view should be selectable");
}



//============ ADD/CHANGE NAME TESTS ==============

-(void)testAddJamesAsName {
    [self changeNameTo:@"James"];
    UILabel * nameLabel = (UILabel*)[tester waitForViewWithAccessibilityLabel:@"nameLabel"];
    XCTAssert([[nameLabel text] isEqualToString:@"JAMES"], @"Name should be JAMES but was: %@", [nameLabel text]);
}

-(void)testAddJamesAsNameAndCancel {
    [self changeNameAndCancel:@"James"];
    UILabel * nameLabel = (UILabel*)[tester waitForViewWithAccessibilityLabel:@"nameLabel"];
    XCTAssert([[nameLabel text] isEqualToString:@""], @"Name should be empty but was: %@", [nameLabel text]);
}

-(void)testAddEmptyNameShouldClearPreviousName {
    [self changeNameTo:@"Anna"];
    [self changeNameTo:@""];
    UILabel * nameLabel = (UILabel*)[tester waitForViewWithAccessibilityLabel:@"nameLabel"];
    XCTAssert([[nameLabel text] isEqualToString:@""], @"Name should be empty but was: %@", [nameLabel text]);
}

-(void)testAddEmptyNameAndCancelShouldKeepPreviousName {
    //Issue #3
    [self changeNameTo:@"Anna"];
    [self changeNameAndCancel:@""];
    UILabel * nameLabel = (UILabel*)[tester waitForViewWithAccessibilityLabel:@"nameLabel"];
    XCTAssert([[nameLabel text] isEqualToString:@"ANNA"], @"Name should be ANNA but was: %@", [nameLabel text]);
}

-(void)testReturnToConfirmName {
    //Issue #5
    [tester tapViewWithAccessibilityLabel:@"addNameButton"];
    [tester waitForTimeInterval:1];
    [tester waitForViewWithAccessibilityLabel:alertViewMessage];
    [tester enterTextIntoCurrentFirstResponder:@"Daniel\n"];
    [tester waitForAbsenceOfViewWithAccessibilityLabel:alertViewMessage];
    UILabel * nameLabel = (UILabel*)[tester waitForViewWithAccessibilityLabel:@"nameLabel"];
    XCTAssert([[nameLabel text] isEqualToString:@"DANIEL"], @"Name should be DANIEL but was: %@", [nameLabel text]);
}

//============ COLOR LABEL TESTS ==============

- (void)testColorLabelIsInitiallyGreen
{
    UILabel * colorLabel = (UILabel*)[tester waitForViewWithAccessibilityLabel:@"colorLabel"];
    XCTAssert([[colorLabel text] isEqualToString:myGreenColorText], @"Color label should be green initially, but is: %@", [colorLabel text]);
}

-(void)testColorLabelTextWhenColorIsBlue {
    [self changeColorToBlue];
    UILabel * colorLabel = (UILabel*)[tester waitForViewWithAccessibilityLabel:@"colorLabel"];
    XCTAssert([[colorLabel text] isEqualToString:myBlueColorText], @"Color label should be blue initially, but is: %@", [colorLabel text]);
}

-(void)testColorLabelTextWhenColorIsRed {
    [self changeColorToRed];
    UILabel * colorLabel = (UILabel*)[tester waitForViewWithAccessibilityLabel:@"colorLabel"];
    XCTAssert([[colorLabel text] isEqualToString:myRedColorText], @"Color label should be red initially, but is: %@", [colorLabel text]);
}

-(void)testColorLabelTextWhenColorIsYellow {
    [self changeColorToYellow];
    UILabel * colorLabel = (UILabel*)[tester waitForViewWithAccessibilityLabel:@"colorLabel"];
    XCTAssert([[colorLabel text] isEqualToString:myYellowColorText], @"Color label should be yellow initially, but is: %@", [colorLabel text]);
}

//============ BACKGROUND COLOR TESTS ==============


-(void)testBackgroundColorIsInitiallyGreen {
    UIView * mainView = (UIView*) [tester waitForViewWithAccessibilityLabel:@"mainView"];
    //[self changeColorToGreen];
    XCTAssert([mainView.backgroundColor isEqual:myGreenColor], @"Background color should be green initially, but is: %@", [self colorAsHex:mainView.backgroundColor]);
}

-(void)testBackgroundColorChangedToBlue {
    UIView * mainView = (UIView*) [tester waitForViewWithAccessibilityLabel:@"mainView"];
    [self changeColorToBlue];
    XCTAssert([mainView.backgroundColor isEqual:myBlueColor], @"Background color should be blue, but is: %@", [self colorAsHex:mainView.backgroundColor]);
}

-(void)testBackgroundColorChangedToRed {
    UIView * mainView = (UIView*) [tester waitForViewWithAccessibilityLabel:@"mainView"];
    [self changeColorToRed];
    XCTAssert([mainView.backgroundColor isEqual:myRedColor], @"Background color should be red, but is: %@", [self colorAsHex:mainView.backgroundColor]);
}

-(void)testBackgroundColorChangedToYellow {
    UIView * mainView = (UIView*) [tester waitForViewWithAccessibilityLabel:@"mainView"];
    [self changeColorToYellow];
    XCTAssert([mainView.backgroundColor isEqual:myYellowColor], @"Background color should be blue, but is: %@", [self colorAsHex:mainView.backgroundColor]);
}

//============ HELPERS ==============


-(void)changeNameTo:(NSString *)name {
    [tester tapViewWithAccessibilityLabel:@"addNameButton"];
    [tester waitForTimeInterval:1];
    [tester waitForViewWithAccessibilityLabel:alertViewMessage];
    [tester enterTextIntoCurrentFirstResponder:name];
    [tester waitForTimeInterval:1];
    [tester tapViewWithAccessibilityLabel:@"OK"];
}

-(void)changeNameAndCancel:(NSString *)name {
    [tester tapViewWithAccessibilityLabel:@"addNameButton"];
    [tester waitForTimeInterval:1];
    [tester waitForViewWithAccessibilityLabel:alertViewMessage];
    [tester enterTextIntoCurrentFirstResponder:name];
    [tester waitForTimeInterval:1];
    [tester tapViewWithAccessibilityLabel:@"Cancel"];
}

-(void)changeColorToBlue {
    int taps = 1;
    UIView * mainView = (UIView*) [tester waitForViewWithAccessibilityLabel:@"mainView"];
    
    if ([mainView.backgroundColor isEqual:myGreenColor])
        taps = 3;
    else if ([mainView.backgroundColor isEqual:myYellowColor])
        taps = 2;
    else if ([mainView.backgroundColor isEqual:myRedColor])
        taps = 1;
    else if ([mainView.backgroundColor isEqual:myBlueColor])
        taps = 4; //or 0?
    
    for (int i=0; i<taps; i++) {
        [tester tapViewWithAccessibilityLabel:@"changeColorButton"];
    }
}


-(void)changeColorToGreen {
    int taps = 1;
    UIView * mainView = (UIView*) [tester waitForViewWithAccessibilityLabel:@"mainView"];
    
    if ([mainView.backgroundColor isEqual:myGreenColor])
        taps = 4;
    else if ([mainView.backgroundColor isEqual:myYellowColor])
        taps = 3;
    else if ([mainView.backgroundColor isEqual:myRedColor])
        taps = 2;
    else if ([mainView.backgroundColor isEqual:myBlueColor])
        taps = 1;
    
    for (int i=0; i<taps; i++) {
        [tester tapViewWithAccessibilityLabel:@"changeColorButton"];
    }
}

-(void)changeColorToRed {
    int taps = 1;
    UIView * mainView = (UIView*) [tester waitForViewWithAccessibilityLabel:@"mainView"];
    
    if ([mainView.backgroundColor isEqual:myGreenColor])
        taps = 2;
    else if ([mainView.backgroundColor isEqual:myYellowColor])
        taps = 1;
    else if ([mainView.backgroundColor isEqual:myRedColor])
        taps = 4;
    else if ([mainView.backgroundColor isEqual:myBlueColor])
        taps = 3;
    
    for (int i=0; i<taps; i++) {
        [tester tapViewWithAccessibilityLabel:@"changeColorButton"];
    }
}

-(void)changeColorToYellow {
    int taps = 1;
    UIView * mainView = (UIView*) [tester waitForViewWithAccessibilityLabel:@"mainView"];
    
    if ([mainView.backgroundColor isEqual:myGreenColor])
        taps = 1;
    else if ([mainView.backgroundColor isEqual:myYellowColor])
        taps = 4;
    else if ([mainView.backgroundColor isEqual:myRedColor])
        taps = 3;
    else if ([mainView.backgroundColor isEqual:myBlueColor])
        taps = 2;
    
    for (int i=0; i<taps; i++) {
        [tester tapViewWithAccessibilityLabel:@"changeColorButton"];
    }
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
