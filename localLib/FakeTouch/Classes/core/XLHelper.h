//
//  XLHelper.h
//  FakeTouch
//
//  Created by sharon on 2023/2/1.
//

#import <Foundation/Foundation.h>
#import "XLTouch.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLHelper : NSObject

+ (UIWindow *)getWindow;
+ (UITouch *)makeupUITouch:(XLTouch *)touch;

+ (void)send:(NSArray <UITouch*> *)touches;

+ (double)machAbsTimeIntoSeconds:(uint64_t) mach_time;

@end

NS_ASSUME_NONNULL_END
