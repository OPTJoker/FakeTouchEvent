//
//  XLTouchEvent.h
//  FakeTouch
//
//  Created by sharon on 2023/1/31.
//

#import <Foundation/Foundation.h>
#import "XLTouch.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLTouchEvent : NSObject

@property (nonatomic, copy) NSArray<XLTouch*> *touches;
@property (nonatomic, assign) NSTimeInterval timeInterval;

- (instancetype)initWithTouches:(NSArray*)touches
                               :(NSTimeInterval)timeInterval;

@end

NS_ASSUME_NONNULL_END
