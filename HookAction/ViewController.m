//
//  ViewController.m
//  HookAction
//
//  Created by sharon on 2023/01/07.
//

#import "ViewController.h"
#import "XLScrollView.h"

#import "AppDelegate.h"
#import <FakeTouch/FakeTouch.h>

#define KSCRWIDTH [UIScreen mainScreen].bounds.size.width
#define KSCRHEIGHT [UIScreen mainScreen].bounds.size.height

#define kRedColor [[UIColor redColor] colorWithAlphaComponent:0.8]
#define kGreenColor [[UIColor greenColor] colorWithAlphaComponent:0.8]
#define kBlueColor [[UIColor blueColor] colorWithAlphaComponent:0.8]

@interface ViewController ()
<UIScrollViewDelegate,
UIGestureRecognizerDelegate
>
@property (nonatomic, strong) XLScrollView *scrollV;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UITextField *textView;
@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.scrollV];
    [self.view addSubview:self.textView];
    
    for (short i=0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(100+20*i, 200+100*i, 160, 60);
        btn.backgroundColor = [UIColor brownColor];
        [btn addTarget:self action:@selector(onPress:) forControlEvents:UIControlEventTouchDown];
        [self.scrollV addSubview:btn];
    }
    
    [self.view addSubview:self.playBtn];
    
    [self addObserver];
}

- (void)addObserver {
    [[RecordManager share] addObserver:self forKeyPath:@"recordState" options:NSKeyValueObservingOptionNew context:@"record-state-changed"];
}

- (void)onPress:(UIButton *)b {
    NSLog(@"xllog 【onPress】！！");
    [self onTouchDown:b];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"recordState"]) {
        RecordState state = [[change valueForKey:@"new"] unsignedIntValue];
        NSString *t = @"Ready";
        UIColor *bgColor = kBlueColor;
        //NSLog(@"s: %d", state);
        //NSLog(@"change: %@", change);
        switch (state) {
            case RecordState_Recording:
                t = @"录制中，摇一摇停止 ⏹";
                bgColor = kRedColor;
                break;
            case RecordState_Playing:
                t = @"播放中···";
                bgColor = kGreenColor;
                break;
                
            default:
                break;
        }
        [self.playBtn setTitle:t forState:UIControlStateNormal];
        [self.playBtn setBackgroundColor:bgColor];
    }
}

- (void)onTouchDown:(UIView *)b {
    __block UIColor *oriCol = b.backgroundColor;
    b.backgroundColor = [UIColor purpleColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        b.backgroundColor = oriCol;
    });
}

//ViewController 加入以下两方法
- (BOOL)canBecomeFirstResponder
{
    //让当前controller可以成为firstResponder，这很重要
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype==UIEventSubtypeMotionShake) {
        //做你想做的事
        RecordManager *m = [RecordManager share];
        if (m.recordState != RecordState_Recording) {
            [m startRecord];
        } else {
            [m stopRecord];
        }
    }
}


#pragma mark
#pragma mark - UI
- (void)viewWillLayoutSubviews {
    if (self.scrollV.frame.size.width != self.view.bounds.size.width ||
        self.scrollV.frame.size.height != self.view.bounds.size.height
        ) {
        self.scrollV.frame = self.view.bounds;
        self.scrollV.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*3);
    }
}

- (XLScrollView *)scrollV {
    if (!_scrollV) {
        _scrollV = [[XLScrollView alloc] initWithFrame:self.view.bounds];
        _scrollV.backgroundColor = [[UIColor colorWithPatternImage:[UIImage imageNamed:@"scroll_bg"]] colorWithAlphaComponent:0.4];
        _scrollV.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*3);
        UISwipeGestureRecognizer *tap = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onScrollTap)];
        tap.direction = UISwipeGestureRecognizerDirectionRight;
        [_scrollV addGestureRecognizer:tap];
        _scrollV.delegate = self;
    }
    return _scrollV;
}


#pragma mark 事件
- (void)onScrollTap
{
    self.scrollV.backgroundColor = kBlueColor;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.scrollV.backgroundColor = [[UIColor colorWithPatternImage:[UIImage imageNamed:@"scroll_bg"]] colorWithAlphaComponent:0.4];
    });
}

- (UITextField *)textView {
    if (!_textView) {
        _textView = [[UITextField alloc] initWithFrame:CGRectMake(0, 44, KSCRWIDTH, 44)];
        _textView.layer.borderWidth = 1/(KSCRWIDTH/375.);
        _textView.layer.cornerRadius = 4;
        _textView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    }
    return _textView;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setTitle:@"摇一摇开始录制 ⏺" forState:UIControlStateNormal];
        [_playBtn setBackgroundColor: kBlueColor];
        _playBtn.frame = CGRectMake(0, KSCRHEIGHT-60, KSCRWIDTH, 60);
        [_playBtn addTarget:self action:@selector(onPlay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (void)onPlay {
    RecordManager *m = [RecordManager share];
    if (m.recordState == RecordState_Ready) {
        [XLFakeTouchPlayer onPlay];
    }
}


#pragma mark 代理


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"\nxllog velocity:%@\n\n", NSStringFromCGPoint(velocity));
    NSLog(@"\nxllog offset:%@", NSStringFromCGPoint(*targetContentOffset));
    NSLog(@"\nxllog gests:%@", scrollView.gestureRecognizers);
}

@end
