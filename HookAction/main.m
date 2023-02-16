//
//  main.m
//  HookAction
//
//  Created by sharon on 2023/01/07.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "XLApplication.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, @"XLApplication", appDelegateClassName);
}
