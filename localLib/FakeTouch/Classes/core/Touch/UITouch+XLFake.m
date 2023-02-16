//
//  UITouch+XLFake.m
//  FakeTouch
//
//  Created by sharon on 2023/1/31.
//

#import "UITouch+XLFake.h"
#import "IOHIDEvent+KIF.h"
#import "UITouch+Private.h"

@implementation UITouch (XLFake)

- (NSString *)tid {
    NSString *fmt = [NSString stringWithFormat:@"%p", self];
    return fmt;
}

- (instancetype)initWith:(CGPoint)location in:(UIWindow *)window {
    self = [super init];
    UIView *view = [window hitTest:location withEvent:nil];
    
    [self setWindow:window];
    [self setView:view];
    
    //[self setTapCount:1];
    [self setPhase:UITouchPhaseBegan];
    [self _setIsFirstTouchForView:YES];
    [self _setIsTapToClick:YES];
    [self _setLocationInWindow:location resetPrevious:YES];
    [self setTimestamp:[NSProcessInfo processInfo].systemUptime];
    if ([self respondsToSelector:@selector(setGestureView:)]) {
        [self setGestureView:view];
    }
    IOHIDEventRef event = kif_IOHIDEventWithTouches(@[self]);
    [self _setHidEvent:event];
    return self;
}

// MARK: - Updating values

- (void)setLocation:(CGPoint)location {
    [self _setLocationInWindow:location resetPrevious:YES];
}

- (void)updateTimestamp {
    [self setTimestamp:[NSProcessInfo processInfo].systemUptime];
}
@end
