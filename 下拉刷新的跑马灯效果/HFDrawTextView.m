//
//  HFDrawTextView.m
//  下拉刷新的跑马灯效果
//
//  Created by 黄来峰 on 2017/3/31.
//  Copyright © 2017年 com.gmw.love. All rights reserved.
//

#import "HFDrawTextView.h"
#import "HFRefreshBezierLabel.h"

@interface HFDrawTextView()
{
    CGFloat _start_Y;
}

@property(assign,nonatomic )UIEdgeInsets edgeInsets;
@end

@implementation HFDrawTextView
@synthesize bezierLabel = _bezierLabel;

-(instancetype)initWithScrollView:(UIScrollView *)scrollView{
    self = [super init];
    if (self) {
        _start_Y = 30;
        self.scrollView = scrollView;
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews{
    self.frame = CGRectMake(0, -64, self.scrollView.frame.size.width, 64);
    //    self.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:self];
}

- (void)setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    //记录scroView的上边距
    _edgeInsets = scrollView.contentInset;
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self updateLabelForOffset];
}
- (void)updateLabelForOffset{
     NSLog(@"self.edgeInsets.top:%f",self.edgeInsets.top);
    CGFloat offset = self.scrollView.contentOffset.y + self.edgeInsets.top;
    if (offset < -64) {
        NSLog(@"self.scrollView.contentOffset.y:%f",self.scrollView.contentOffset.y);
        if (self.refreshState != HFRefreshstateRefreshing && !self.scrollView.isDragging) {
            self.refreshState = HFRefreshstateWillRefresh;
        }
        self.bezierLabel.offset = 1;
        return;
    }else if(offset > 0){
        self.bezierLabel.offset = 0;
        return;
    }
    if (self.refreshState == HFRefreshstateNormal) {
        self.bezierLabel.offset = MAX((-offset - _start_Y)/ (64.0 - _start_Y), 0);
    }
}

-(void)setRefreshState:(HFRefreshstate)refreshState{
    if (_refreshState == refreshState) return;
    _refreshState = refreshState;
    switch (refreshState) {
        case HFRefreshstateNormal:
        {
            [UIView animateWithDuration:0.25 animations:^{
                self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, -_edgeInsets.top);
            } completion:^(BOOL finished) {
                self.scrollView.contentInset = _edgeInsets;
            }];
            self.bezierLabel.showAnimation = NO;
        }
            break;
        case HFRefreshstateRefreshing:
            self.bezierLabel.showAnimation = YES;
            break;
        case HFRefreshstateWillRefresh:
            [self oprationForWillRefresh];
            break;
        default:
            break;
    }
}
- (void)oprationForWillRefresh{
    self.action();
    self.refreshState = HFRefreshstateRefreshing;
    UIEdgeInsets edgeInsets = _edgeInsets;
    edgeInsets.top += 64;
    self.scrollView.contentInset = edgeInsets;
}

- (void)endHeaderRefresh{
    self.refreshState = HFRefreshstateNormal;
}
-(HFRefreshBezierLabel *)bezierLabel{
    if (!_bezierLabel) {
        _bezierLabel = [[HFRefreshBezierLabel alloc]initWithFrame:self.bounds];
                _bezierLabel.backgroundColor =[UIColor redColor];
        _bezierLabel.text = @"Jiang-Fallen";
        [self addSubview:_bezierLabel];
    }
    return _bezierLabel;
}
- (void)setRefreshText:(NSString *)refreshText{
    self.bezierLabel.text = refreshText;

}
- (void)setTextColor:(UIColor *)textColor{
    self.bezierLabel.textColor = textColor;
}
@end
