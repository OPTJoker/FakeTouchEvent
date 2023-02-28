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
    UITouch *uiTouch = [event.allTouches anyObject];
    NSLog(@"xllog (%ld)oriTime:%f", (long)uiTouch.phase, uiTouch.timestamp);
    
    if ([RecordManager share].recordState == RecordState_Recording) {
        [[RecordManager share] handleEvent:event onWindow:[XLHelper getWindow]];
    }
    
    [super sendEvent:event];
}

@end
