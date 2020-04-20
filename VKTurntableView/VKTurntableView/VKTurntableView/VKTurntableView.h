//
//  VKTurntableView.h
//  VKOOY
//
//  Created by vkooy on 2018/5/21.
//  Copyright © 2017年. All rights reserved.
//

#import <UIKit/UIKit.h>

#define D2R(degrees) ((M_PI * degrees) / 180)
//   - 1.25
@interface DWTurntableViewModel : NSObject

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageName;

@end

@interface VKTurntableView : UIView

@property (nonatomic, strong) NSArray<DWTurntableViewModel *> *luckyItemArray;

// random prize 随机
- (void)startRotationWithEndValue:(CGFloat)endValue;

// specific prize 指定中奖
- (void)startRotationWithEndValue:(CGFloat)endValue round:(NSInteger)round;

@end
