//
//  XLScrollView.m
//  HookAction
//
//  Created by sharon on 2023/2/2.
//

#import "XLScrollView.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation XLScrollView
- (void)didMoveToWindow {
    [super didMoveToWindow];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    NSLog(@"began");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    NSLog(@"m");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"cancel");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    NSLog(@"end");
}


- (void)_scrollViewDidEndDraggingWithDeceleration:(BOOL)decelerate
{
    NSLog(@"%d", decelerate);
}

- (id)_touchesDelayedGestureRecognizer {
    return nil;
}

@end
