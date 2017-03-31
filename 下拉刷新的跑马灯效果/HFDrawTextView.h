//
//  HFDrawTextView.h
//  下拉刷新的跑马灯效果
//
//  Created by 黄来峰 on 2017/3/31.
//  Copyright © 2017年 com.gmw.love. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HFRefreshBezierLabel;

typedef NS_ENUM(NSInteger ,HFRefreshstate) {
    HFRefreshstateNormal = 0 ,
    HFRefreshstateRefreshing = 1,
    HFRefreshstateWillRefresh = 2
    
};

@interface HFDrawTextView : UIView
@property(copy,nonatomic)void (^action)();
@property(weak,nonatomic )UIScrollView *scrollView;
@property(assign,nonatomic )HFRefreshstate refreshState;
@property(strong,nonatomic,readonly)HFRefreshBezierLabel *bezierLabel;

@property (nonatomic, weak) NSString *refreshText;
@property (nonatomic, weak) UIColor *textColor;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;
- (void)endHeaderRefresh;
@end
