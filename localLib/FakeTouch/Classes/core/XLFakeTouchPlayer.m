//
//  XLFakeTouchPlayer.m
//  FakeTouch
//
//  Created by sharon on 2023/2/1.
//

#import "XLFakeTouchPlayer.h"
#import "FakeTouch.h"

@implementation XLFakeTouchPlayer

+ (void)onPlay {
    RecordManager *m = [RecordManager share];
    m.recordState = RecordState_Playing;
    
    dispatch_group_t group = dispatch_group_create();
    for (XLTouchEvent *xlEvent in m.eventsArr) {
        dispatch_group_enter(group);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, xlEvent.timeInterval*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self onCall:xlEvent];
            dispatch_group_leave(group);
        });
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [[RecordManager share] stopRecord];
        });
    }
}


+ (void)onCall:(XLTouchEvent *)xlEvent {
    NSMutableArray *touches = @[].mutableCopy;
    [xlEvent.touches enumerateObjectsUsingBlock:^(XLTouch * _Nonnull touch, NSUInteger idx, BOOL * _Nonnull stop) {
        UITouch *uiTouch = [XLHelper makeupUITouch:touch];
        NSLog(@"xllog (%ld)fakeTime:%f", (long)uiTouch.phase, uiTouch.timestamp);
        [touches addObject:uiTouch];
    }];
    
    [XLHelper send:touches];
}

@end
