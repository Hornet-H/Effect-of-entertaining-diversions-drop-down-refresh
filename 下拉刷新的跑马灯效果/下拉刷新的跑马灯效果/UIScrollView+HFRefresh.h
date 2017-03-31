//
//  UIScrollView+HFRefresh.h
//  下拉刷新的跑马灯效果
//
//  Created by 黄来峰 on 2017/3/31.
//  Copyright © 2017年 com.gmw.love. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFDrawTextView.h"

@interface UIScrollView (HFRefresh)
@property(strong,nonatomic )HFDrawTextView *drawTextView;
- (void)addHeaderWithAction:(void(^)())action;
- (void)addHeaderWithAction:(void (^)())action customControl:(void (^)(HFDrawTextView *drawView)) opration;
- (void)endHeaderRefresh;

@end
