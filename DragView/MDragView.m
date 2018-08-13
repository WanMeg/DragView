//
//  MDragView.m
//  Gold
//
//  Created by fromai on 2017/6/16.
//  Copyright © 2017年 Fromai. All rights reserved.
//

#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight  [[UIScreen mainScreen] bounds].size.height

#import "MDragView.h"

@implementation MDragView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        self.layer.cornerRadius = width / 2;
        self.clipsToBounds = YES;
        
        //透明view1
        UIView *tmView = [[UIView alloc]initWithFrame:CGRectMake(0,0,width,height)];
        tmView.layer.cornerRadius = width / 2;
        tmView.clipsToBounds = YES;
        tmView.alpha = 0.5;
        tmView.backgroundColor = [UIColor colorWithRed:90.0/255.0 green:208.0/255.0 blue:192.0/255.0 alpha:1];
        [self addSubview:tmView];
        
        //透明view2
        UIView *tm2View = [[UIView alloc]initWithFrame:CGRectMake(5,5,width - 10,height - 10)];
        tm2View.layer.cornerRadius = (width - 10) / 2;
        tm2View.clipsToBounds = YES;
        tm2View.alpha = 0.5;
        tm2View.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:188.0/255.0 blue:162.0/255.0 alpha:1];
        [self addSubview:tm2View];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,width,height)];
        button.backgroundColor = [UIColor clearColor];
        button.layer.cornerRadius = width/2;
        button.clipsToBounds = YES;
        [button setImage:[UIImage imageNamed:@"xx1"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"xx1"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(dragBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]  initWithTarget:self action:@selector(dragPanGestureRecognizerAction:)];
        [self addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}

- (void)dragBtnClick {
    self.dragViewButtonAction();
}

- (void)dragPanGestureRecognizerAction:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.fatherView];
    CGFloat centerX = recognizer.view.center.x + translation.x;
    CGFloat viewHeight = recognizer.view.frame.size.height;
    CGFloat viewY = recognizer.view.frame.origin.y;
    
    recognizer.view.center = CGPointMake(centerX, recognizer.view.center.y + translation.y);
    
    [recognizer setTranslation:CGPointZero inView:self.fatherView];
    
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        //吸附下沿判断 (距离下50+40的时候 开始吸附，留50 的距离 tabbar)
        if (viewY > ScreenHeight - 50 - viewHeight - 40) {
            if (centerX >= 45 && centerX < ScreenWidth - 45) {
                [UIView animateWithDuration:0.3 animations:^{
                    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, ScreenHeight - 50 - viewHeight/2);
                }];
            } else {
                if(centerX > ScreenWidth/2) {
                    [self dragViewFrameWith:recognizer withCenterX:ScreenWidth - viewHeight/2 - _startRightWidth];
                } else {
                    [self dragViewFrameWith:recognizer withCenterX:viewHeight/2 + _startRightWidth];
                }
            }
        }
        
        //吸附上沿判断 (距离上50的时候 开始吸附 ，留20的距离 statusbar)
        else if (viewY < 50) {
            if (centerX >= 45 && centerX < ScreenWidth - 45) {
                [UIView animateWithDuration:0.3 animations:^{
                    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, 20 + viewHeight/2);
                }];
            } else {
                if(centerX > ScreenWidth/2) {
                    [self dragViewFrameWith:recognizer withCenterX:ScreenWidth - viewHeight/2 - _startRightWidth];
                } else {
                    [self dragViewFrameWith:recognizer withCenterX:viewHeight/2 + _startRightWidth];
                }
            }
        }
        
        //吸附左右沿判断 (以self.view.center.x判断吸附左右， 留 _startRightWidth 的距离)
        else {
            if(centerX > ScreenWidth/2) {
                [self dragViewFrameWith:recognizer withCenterX:ScreenWidth - viewHeight/2 - _startRightWidth];
            } else {
                [self dragViewFrameWith:recognizer withCenterX:viewHeight/2 + _startRightWidth];
            }
        }
    }
}

- (void)dragViewFrameWith:(UIPanGestureRecognizer *)recognizer withCenterX:(CGFloat)centerX {
    CGPoint translation = [recognizer translationInView:self.fatherView];
    CGFloat viewHeight = recognizer.view.frame.size.height;
    CGFloat viewY = recognizer.view.frame.origin.y;
    
    CGFloat centerY;
    if (viewY >= ScreenHeight - 49 - viewHeight) {
        centerY = ScreenHeight - 49 - viewHeight/2;
    } else if (viewY >= 20 && viewY < ScreenHeight - 49 - viewHeight) {
        centerY = recognizer.view.center.y + translation.y;
    } else {
        centerY = 20 + viewHeight/2;
    }
    [UIView animateWithDuration:0.3 animations:^{
        recognizer.view.center = CGPointMake(centerX, centerY);
    }];
}


@end
