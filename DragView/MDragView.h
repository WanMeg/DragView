//
//  MDragView.h
//  Gold
//
//  Created by fromai on 2017/6/16.
//  Copyright © 2017年 Fromai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DragViewButtonActionBlock)(void);

@interface MDragView : UIView

@property (nonatomic, strong) UIView *fatherView;
@property (nonatomic, assign) CGFloat startRightWidth;

@property (nonatomic, copy) DragViewButtonActionBlock dragViewButtonAction;

- (instancetype)initWithFrame:(CGRect)frame;

@end
