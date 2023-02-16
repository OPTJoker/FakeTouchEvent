//
//  XLFakeTouchPlayer.h
//  FakeTouch
//
//  Created by sharon on 2023/2/1.
//

#import <Foundation/Foundation.h>
#import "XLTouchEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLFakeTouchPlayer : NSObject
+ (void)onPlay;
+ (void)onCall:(XLTouchEvent *)xlEvent;
@end

NS_ASSUME_NONNULL_END
