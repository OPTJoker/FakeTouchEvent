//
//  XLTouch.h
//  FakeTouch
//
//  Created by sharon on 2023/1/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLTouch : NSObject
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, assign) UITouchPhase phase;

- (instancetype)initWithTid:(NSString*)tid :(CGPoint)location :(UITouchPhase)phase;

@end

NS_ASSUME_NONNULL_END
