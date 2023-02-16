//
//  UITouch+XLFake.h
//  FakeTouch
//
//  Created by sharon on 2023/1/31.
//

#import <UIKit/UIKit.h>

void load_UIEvent_XLFake(void);

NS_ASSUME_NONNULL_BEGIN

@interface UITouch (XLFake)
- (instancetype)initWith:(CGPoint)location in:(UIWindow *)window;
- (NSString *)tid;

// MARK: - Updating values
- (void)setLocation:(CGPoint)location;
- (void)updateTimestamp;

@end

NS_ASSUME_NONNULL_END
