//
//  ViewController.m
//  VKTurntableView
//
//  Created by Work on 2020/4/18.
//  Copyright © 2020 Work. All rights reserved.
//

#import "ViewController.h"
#import "VKTurntableView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (strong, nonatomic) VKTurntableView *turntable;

@property (strong, nonatomic) NSMutableArray *luckyItemArray;

@property (assign, nonatomic) NSInteger endId;  //  仅代表停止位置，不代表奖品ID。(更改转盘奖品个数，这个ID不准，自行修改旋转角度)

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTurntableView];
    
    [self initStartBtn];
    [self initResultView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lunckyAnimationDidStop) name:@"VKLunckyAnimationDidStopNotication" object:nil];
}

- (void)initStartBtn {
    UIButton *start = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 120) * 0.5, CGRectGetMaxY(_turntable.frame) + 15, 120, 40)];
    start.backgroundColor = [UIColor grayColor];
    [start setTitle:@"Start" forState:(UIControlStateNormal)];
    
    [self.view addSubview:start];
    [start addTarget:self action:@selector(startAction) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)startAction {
    //  0-9
    _endId = arc4random() % 6;
    
    [self turntableRotate:_endId];
}

- (void)initResultView {
    
}

- (void)initTurntableView {
    _turntable = [[VKTurntableView alloc] init];
    
    [self.view addSubview:_turntable];
    _turntable.frame = CGRectMake(20, (SCREEN_HEIGHT - (SCREEN_WIDTH - 20 * 2)) * 0.5, SCREEN_WIDTH - 20 * 2, SCREEN_WIDTH);
    
    _luckyItemArray = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        DWTurntableViewModel *model = [[DWTurntableViewModel alloc] init];
        model.title = [NSString stringWithFormat:@"%d-标题",i];
        model.index = i;
        model.imageName = @"vk_vkooy";
        [_luckyItemArray addObject:model];
    }
    
    _turntable.luckyItemArray = _luckyItemArray;
}


- (void)turntableRotate:(NSInteger)index {
    CGFloat count = _turntable.luckyItemArray.count;
    
    CGFloat move = (360 / count) * 3.5;
    CGFloat angle4Rotate = (360 + move) - (360.0 / count) * index + (360.0 / count) / 2;// 以 π*3/2 为终点, 加多一圈以防反转, 默认顺时针
    if (angle4Rotate > 360){
        angle4Rotate -= 360;
    }
    
    CGFloat radians = D2R(angle4Rotate) + M_PI * 6;
    [_turntable startRotationWithEndValue:radians round:3];
}

- (void)lunckyAnimationDidStop {
    NSLog(@"============🌝🌝🌝🌝🌝🌝🌝🌝============:%ld",_endId);
    
    DWTurntableViewModel *model = _luckyItemArray[_endId];
    
    NSLog(@"============🌝🌝🌝🌝🌝🌝🌝🌝============:%@",model.title);
}





@end
