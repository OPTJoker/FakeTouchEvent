//
//  RecoderManager.m
//  HookAction
//
//  Created by sharon on 2023/01/07.
//

#import "RecordManager.h"
#import "UITouch+XLFake.h"
#import <CoreMotion/CoreMotion.h>


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
    [self.eventsArr removeAllObjects];
    
    self.recordState = RecordState_Recording;
}


- (void)stopRecord {
    logger(@"【record - stop】");
    self.recordState = RecordState_Ready;
}

- (void)addEvent:(UIEvent *)uiEvent inWindow:(UIWindow *)window
{
    if ([RecordManager share].recordState != RecordState_Recording)
        return;
    
    NSSet<UITouch*>* uiTouches = uiEvent.allTouches;
    if (!uiTouches || uiTouches.count <= 0)
        return;
    
    logger(@"【record - addAction");
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.startDate];
    
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
                          :timeInterval];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.eventsArr addObject:event];
    });
}


void logger(NSString *msg) {
    NSLog(@"xllog：%@", msg);
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
