//
//  XLApplication.m
//  HookAction
//
//  Created by sharon on 2023/01/07.
//

#import "XLApplication.h"
#import "RecordManager.h"
#import <FakeTouch/FakeTouch.h>

@implementation XLApplication

- (void)sendEvent:(UIEvent *)event {
    
    if ([RecordManager share].recordState == RecordState_Recording) {
        [[RecordManager share] addEvent:event inWindow:[XLHelper getWindow]];
    }
    
    [super sendEvent:event];
}

@end
