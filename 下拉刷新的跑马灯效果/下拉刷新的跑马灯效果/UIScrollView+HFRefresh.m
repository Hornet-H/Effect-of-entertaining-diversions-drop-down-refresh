//
//  UIScrollView+HFRefresh.m
//  下拉刷新的跑马灯效果
//
//  Created by 黄来峰 on 2017/3/31.
//  Copyright © 2017年 com.gmw.love. All rights reserved.
//

#import "UIScrollView+HFRefresh.h"
#import <objc/runtime.h>

NSString *const _drawTextView = @"frameTextView";
@implementation UIScrollView (HFRefresh)
@dynamic drawTextView;

- (void)addHeaderWithAction:(void (^)())action{
    HFDrawTextView *drawTextView = [[HFDrawTextView alloc]initWithScrollView:self];
    drawTextView.action = action;
    self.drawTextView = drawTextView;

}
- (void)addHeaderWithAction:(void (^)())action customControl:(void (^)(HFDrawTextView *))opration{
    [self addHeaderWithAction:action];
    opration(self.drawTextView);
}

- (HFDrawTextView *)drawTextView{
    
    return (HFDrawTextView *)objc_getAssociatedObject(self, &_drawTextView);
}
- (void)setDrawTextView:(HFDrawTextView *)drawTextView{

    objc_setAssociatedObject(self, &_drawTextView, drawTextView, OBJC_ASSOCIATION_ASSIGN);
}
- (void)endHeaderRefresh{

    [self.drawTextView endHeaderRefresh];
}
@end
