//
//  XLTouch.m
//  FakeTouch
//
//  Created by sharon on 2023/1/31.
//

#import "XLTouch.h"
#import "UITouch+XLFake.h"
#import "UITouch+Private.h"
#import "RecordManager.h"

@implementation XLTouch

- (instancetype)initWithTid:(NSString*)tid :(CGPoint)location :(UITouchPhase)phase
{
    self = [super init];
    self.tid = tid;
    self.location = location;
    self.phase = phase;
    return self;
}

@end
