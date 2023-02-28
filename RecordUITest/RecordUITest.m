//
//  RecordUITest.m
//  RecordUITest
//
//  Created by sharon on 2023/2/24.
//

#import <XCTest/XCTest.h>

@interface RecordUITest : XCTestCase

@end

@implementation RecordUITest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


- (void)testExample {
    // UI tests must launch the application that they test.
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    
    
    XCUIElement *verticalScrollBar4PagesScrollView = /*@START_MENU_TOKEN@*/[[[XCUIApplication alloc] init].scrollViews containingType:XCUIElementTypeOther identifier:@"Vertical scroll bar, 4 pages"].element/*[["[[XCUIApplication alloc] init]","[",".scrollViews containingType:XCUIElementTypeOther identifier:@\"Horizontal scroll bar, 1 page\"].element",".scrollViews containingType:XCUIElementTypeOther identifier:@\"Vertical scroll bar, 4 pages\"].element"],[[[-1,0,1]],[[1,3],[1,2]]],[0,0]]@END_MENU_TOKEN@*/;
    /*@START_MENU_TOKEN@*/[verticalScrollBar4PagesScrollView swipeLeft];/*[["verticalScrollBar4PagesScrollView","["," swipeUp];"," swipeLeft];"],[[[-1,0,1]],[[1,3],[1,2]]],[0,0]]@END_MENU_TOKEN@*/
    [verticalScrollBar4PagesScrollView tap];
    
    
   
    
    sleep(5);
    
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testLaunchPerformance {
    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)) {
        // This measures how long it takes to launch your application.
        [self measureWithMetrics:@[[[XCTApplicationLaunchMetric alloc] init]] block:^{
            [[[XCUIApplication alloc] init] launch];
        }];
    }
}

@end
