//
//  K_CardsUITests.m
//  K_CardsUITests
//
//  Created by Ru Cindrea on 7/21/15.
//  Copyright © 2015 altom. All rights reserved.
//

#import <XCTest/XCTest.h>

#define moreInfoURL @"http://testingthoughts.com/blog/26"

@interface K_CardsUITests : XCTestCase

@end

@implementation K_CardsUITests

- (void)setUp {
    [super setUp];
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//=========== ADD/CHANGE NAME TESTS ================


-(void)testAddOrChangeName {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *addnamebuttonButton = app.buttons[@"addNameButton"];
    NSString *name = @"ANNA";
    [addnamebuttonButton tap];
    
    XCUIElementQuery *collectionViewsQuery = app.alerts[@"Add/Change Name"].collectionViews;
    XCUIElement *nameTextfield = collectionViewsQuery.textFields.element;
    
    [nameTextfield typeText:name];
    
    [collectionViewsQuery.buttons[@"OK"] tap];
    NSString *currentName = app.staticTexts[@"nameLabel"].value;
    
    XCTAssertTrue([currentName isEqualToString:name]);
    
}

-(void)testCancelChangeName {

    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *addnamebuttonButton = app.buttons[@"addNameButton"];
    NSString *initialName = app.staticTexts[@"nameLabel"].value;
    [addnamebuttonButton tap];
    
    XCUIElementQuery *collectionViewsQuery = app.alerts[@"Add/Change Name"].collectionViews;
    [collectionViewsQuery.buttons[@"Cancel"] tap];
    NSString *currentName = app.staticTexts[@"nameLabel"].value;
    
    XCTAssertTrue([currentName isEqualToString:initialName]);
}

-(void)testClearName {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *addnamebuttonButton = app.buttons[@"addNameButton"];

    [addnamebuttonButton tap];
    
    XCUIElementQuery *collectionViewsQuery = app.alerts[@"Add/Change Name"].collectionViews;
    [collectionViewsQuery.buttons[@"OK"] tap];
    NSString *currentName = app.staticTexts[@"nameLabel"].value;
    
    XCTAssertTrue([currentName isEqualToString:@""]);
}

@end
