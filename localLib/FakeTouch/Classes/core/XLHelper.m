//
//  XLHelper.m
//  FakeTouch
//
//  Created by sharon on 2023/2/1.
//

#import "XLHelper.h"
#import "FakeTouch.h"
#import <mach/mach_time.h>

@implementation XLHelper

+ (UITouch *)makeupUITouch:(XLTouch *)touch
{
    RecordManager *m = [RecordManager share];
    UITouch *touchObject = m.touchObjects[touch.tid];
    if (touchObject) {
        [touchObject setLocation:touch.location];
        [touchObject setPhase:touch.phase];
        [touchObject updateTimestamp];
        if (touch.phase == UITouchPhaseEnded) {
            m.touchObjects[touch.tid] = nil;
        }
        return touchObject;
    } else {
        // Creating new UITouch
        UIWindow *window = [self getWindow];
        UITouch *touchObject = [[UITouch alloc] initWith:touch.location in:window];
        m.touchObjects[touch.tid] = touchObject; //加入复用池
        return touchObject;
    }
}

+ (UIWindow *)getWindow
{
    if (@available(iOS 15, *)) {
        __block UIScene * _Nonnull tmpSc;
        [[[UIApplication sharedApplication] connectedScenes] enumerateObjectsUsingBlock:^(UIScene * _Nonnull obj, BOOL * _Nonnull stop) {
            if (obj.activationState == UISceneActivationStateForegroundActive) {
                tmpSc = obj;
                *stop = YES;
            }
        }];
        UIWindowScene *curWinSc = (UIWindowScene *)tmpSc;
        return curWinSc.keyWindow;
    } else {
        return [[[UIApplication sharedApplication] windows] firstObject];
    }
}

+ (void)send:(NSArray <UITouch*> *)touches
{
    UIEvent *event = [UIApplication sharedApplication]._touchesEvent;
    if (!event) return;
    
    [event _clearTouches];
    [touches enumerateObjectsUsingBlock:^(UITouch * _Nonnull touch, NSUInteger idx, BOOL * _Nonnull stop) {
        [event _addTouch:touch forDelayedDelivery:NO];
    }];

    [[UIApplication sharedApplication] sendEvent:event];
    [touches enumerateObjectsUsingBlock:^(UITouch * _Nonnull touch, NSUInteger idx, BOOL * _Nonnull stop) {
        if (touch.phase == UITouchPhaseBegan
            || touch.phase == UITouchPhaseMoved
            ) {
            [touch setPhase:UITouchPhaseStationary];
            [touch updateTimestamp];
        }
    }];
}

+ (double)machAbsTimeIntoSeconds:(uint64_t) mach_time
{
    mach_timebase_info_data_t _clock_timebase;
    mach_timebase_info(&_clock_timebase); // Initialize timebase_info
    double nanos = (mach_time * _clock_timebase.numer) / _clock_timebase.denom;
    return nanos / 1e9;
}

@end
