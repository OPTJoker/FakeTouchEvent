//
//  RecoderManager.h
//  HookAction
//
//  Created by sharon on 2023/01/07.
//

#import <Foundation/Foundation.h>
#import "XLTouchEvent.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    RecordState_Init, //初始化
    RecordState_Recording, //记录中
    RecordState_Playing, //播放中
    RecordState_Ready, //播完或者录完
} RecordState;


@interface RecordManager : NSObject
+ (instancetype)share;

@property (nonatomic, assign) RecordState recordState;

@property (nonatomic, strong) NSDate *startDate;

@property (nonatomic, strong) NSMutableArray <XLTouchEvent*>*eventsArr;

- (void)addEvent:(UIEvent *)uiEvent inWindow:(UIWindow *)window;

- (void)startRecord;

- (void)stopRecord;
//private var touchObjects = [String: UITouch]()
@property (nonatomic, strong) NSMutableDictionary<NSString*, UITouch*> *touchObjects;

@end

NS_ASSUME_NONNULL_END
