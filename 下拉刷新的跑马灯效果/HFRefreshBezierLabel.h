//
//  HFRefreshBezierLabel.h
//  下拉刷新的跑马灯效果
//
//  Created by 黄来峰 on 2017/3/31.
//  Copyright © 2017年 com.gmw.love. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFRefreshBezierLabel : UIView

@property(copy,nonatomic)NSString *text;
@property(strong,nonatomic )UIFont *textFont;
@property(strong,nonatomic )UIColor *textColor;
@property(strong,nonatomic )CAShapeLayer *shapeLayer;
@property(strong,nonatomic )CAGradientLayer *grandientLayer;

@property(assign,nonatomic )CGSize textSize;
@property(assign,nonatomic )CGFloat offset;
@property(assign,nonatomic )BOOL showAnimation;

@end
