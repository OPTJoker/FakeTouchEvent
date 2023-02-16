//
//  XLApplication.h
//  HookAction
//
//  Created by sharon on 2023/01/07.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLApplication : UIApplication

- (void)sendEvent:(UIEvent *)event;

@end

NS_ASSUME_NONNULL_END
