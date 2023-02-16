//
//  XLTouchEvent.m
//  FakeTouch
//
//  Created by sharon on 2023/1/31.
//

#import "XLTouchEvent.h"

@implementation XLTouchEvent

- (instancetype)initWithTouches:(NSArray*)touches
                               :(NSTimeInterval)timeInterval
{
    self = [super init];
    self.touches = touches;
    self.timeInterval = timeInterval;
    return self;
}

@end
