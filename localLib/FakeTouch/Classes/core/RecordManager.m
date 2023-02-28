//
//  RecoderManager.m
//  HookAction
//
//  Created by sharon on 2023/01/07.
//

#import "RecordManager.h"
#import "UITouch+XLFake.h"
#import "XLHelper.h"
#import <CoreMotion/CoreMotion.h>
#import <mach/mach_time.h>


@implementation RecordManager
- (void)setRecordState:(RecordState)recordState {
    [self willChangeValueForKey:@"recordState"];
    _recordState = recordState;
    [self didChangeValueForKey:@"recordState"];
}

+ (instancetype)share
{
    static RecordManager *_instance = nil;
    static dispatch_once_t onceT;
    if (!_instance) {
        dispatch_once(&onceT, ^{
            _instance = [RecordManager new];
        });
    }
    return _instance;
}


- (void)startRecord {
    logger(@"【record - start】");
    
    self.startDate = [NSDate date];
    self.startTime = [XLHelper machAbsTimeIntoSeconds:mach_absolute_time()];
    [self.eventsArr removeAllObjects];
    
    self.recordState = RecordState_Recording;
}


- (void)stopRecord {
    logger(@"【record - stop】");
    self.recordState = RecordState_Ready;
}

- (void)handleEvent:(UIEvent *)uiEvent onWindow:(UIWindow *)window
{
    if ([RecordManager share].recordState != RecordState_Recording)
        return;
    
    NSSet<UITouch*>* uiTouches = uiEvent.allTouches;
    if (!uiTouches || uiTouches.count <= 0)
        return;
    
    logger(@"【record - addAction");
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.startDate];
    NSTimeInterval curTime = [XLHelper machAbsTimeIntoSeconds:mach_absolute_time()];
    NSTimeInterval timeInterval2 = curTime - self.startTime;
    NSLog(@"\ntlog1:%f\ntlog2:%f\n", timeInterval, timeInterval2);
    
    NSMutableArray *touches = @[].mutableCopy;
    [uiTouches enumerateObjectsUsingBlock:^(UITouch * _Nonnull uiTouch, BOOL * _Nonnull stop) {
        CGPoint loc = [uiTouch locationInView:window];
        XLTouch *touch = [[XLTouch alloc] initWithTid
                          :[uiTouch tid]
                          :loc
                          :uiTouch.phase];
        [touches addObject:touch];
    }];
    
    XLTouchEvent *event = [[XLTouchEvent alloc]
                          initWithTouches:touches
                          :timeInterval2];
    
    [self.eventsArr addObject:event];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//    });
}


void logger(NSString *msg) {
//    NSLog(@"xllog：%@", msg);
}

#pragma mark
#pragma mark - lazy
- (NSMutableArray *)eventsArr {
    if (!_eventsArr) {
        _eventsArr = [NSMutableArray new];
    }
    return _eventsArr;
}


- (NSMutableDictionary<NSString *,UITouch *> *)touchObjects {
    if (!_touchObjects) {
        _touchObjects = [NSMutableDictionary new];
    }
    return _touchObjects;
}

@end
