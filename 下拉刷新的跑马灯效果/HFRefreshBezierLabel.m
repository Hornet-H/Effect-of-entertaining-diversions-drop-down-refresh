//
//  HFRefreshBezierLabel.m
//  下拉刷新的跑马灯效果
//
//  Created by 黄来峰 on 2017/3/31.
//  Copyright © 2017年 com.gmw.love. All rights reserved.
//

#import "HFRefreshBezierLabel.h"
#import <CoreText/CoreText.h>

@interface HFRefreshBezierLabel()
@property(strong,nonatomic )CABasicAnimation *gradientAnimation;
@end

@implementation HFRefreshBezierLabel
@synthesize textColor = _textColor;

- (void)setText:(NSString *)text{
    _text = text;
    [self settingLayerForText:text];
}
- (void)setOffset:(CGFloat)offset{
    _offset = offset;
    if (offset < 1) {
        self.showAnimation = NO;
        self.shapeLayer.strokeEnd = offset;
    }
}
- (UIColor *)textColor{
    if (!_textColor) {
        _textColor = [UIColor orangeColor];
    }
    return _textColor;
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor =textColor;
    [self updateGradientLayerColors];

}
- (UIFont *)textFont{
    if (!_textFont) {
        _textFont = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:17];
    }
    return _textFont;
}
- (void)updateGradientLayerColors{
    self.grandientLayer.backgroundColor = self.textColor.CGColor;
    self.grandientLayer.colors = @[
                                   (__bridge id)[self.textColor colorWithAlphaComponent:0.3].CGColor,
                                   (__bridge id)[self.textColor colorWithAlphaComponent:1].CGColor,
                                   (__bridge id)[self.textColor colorWithAlphaComponent:0.3].CGColor];
}

- (CAShapeLayer *)shapeLayer{
    if (_shapeLayer == nil) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = CGRectMake(0, 0, self.textSize.width, self.textSize.height);
        _shapeLayer.geometryFlipped = YES;
        _shapeLayer.strokeColor = self.textColor.CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.lineWidth = 1.0f;
        _shapeLayer.lineJoin = kCALineJoinRound;
        _shapeLayer.strokeEnd = 0;
        
    }
    return  _shapeLayer;
}

- (CAGradientLayer *)grandientLayer{
    if (!_grandientLayer) {
        _grandientLayer = [CAGradientLayer layer];
        _grandientLayer.frame = CGRectMake(0, 0, self.textSize.width + 5, self.textSize.height +5);
        _grandientLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 10);
        _grandientLayer.startPoint = CGPointMake(0, 0.6);
        _grandientLayer.endPoint = CGPointMake(1, 0.4);
        _grandientLayer.locations = @[@0, @0, @1, @1];
        [self updateGradientLayerColors];
        [self.layer addSublayer:_grandientLayer];
        
    }
    return _grandientLayer;
}
- (CGSize)textSize{
    CGSize size = [_text sizeWithAttributes:@{NSFontAttributeName: self.textFont}];
    size.width += _text.length * 2;
    return size;

}
- (CABasicAnimation *)gradientAnimation{
    if (!_gradientAnimation) {
        NSArray *fromArray = @[@-0.1,@0.0,@0.3,@0.4];
        NSArray *toArray = @[@1, @01.1, @1.4, @1.5];
        self.grandientLayer.backgroundColor = [UIColor clearColor].CGColor;
        _gradientAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
        [_gradientAnimation setFromValue:fromArray];
        [_gradientAnimation setToValue:toArray];
        [_gradientAnimation setDuration:0.8];
        [_gradientAnimation setRemovedOnCompletion:YES];
        [_gradientAnimation setFillMode:kCAFillModeForwards];
        [_gradientAnimation setRepeatCount:MAXFLOAT];
        [_grandientLayer addAnimation:_gradientAnimation forKey:@"animateGradient"];
        
    }
    return _gradientAnimation;
}
- (void)setShowAnimation:(BOOL)showAnimation{
    if (_showAnimation == showAnimation) {
        return;
    }
    if (showAnimation) {
        self.shapeLayer.strokeEnd = 1;
        _grandientLayer.backgroundColor = [UIColor redColor].CGColor;
        
    }else{
        _grandientLayer.backgroundColor = self.textColor.CGColor;
    }
    self.gradientAnimation.speed = showAnimation ? 1 : 0;
}
- (void)settingLayerForText:(NSString *)text{
    NSAttributedString *attrStrs = [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:self.textFont}];
    CGMutablePathRef paths = CGPathCreateMutable();
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrStrs);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex ++) {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex ++) {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            {
                CGPathRef path = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x + 2 * runGlyphIndex, position.y);
                CGPathAddPath(paths, &t,path);
                CGPathRelease(path);
            }
        }
        
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:paths]];
    
    //    [path applyTransform:CGAffineTransformMakeTranslation(0.0, self.height)];
    
    CGPathRelease(paths);
    
    self.shapeLayer.path = path.CGPath;
    self.grandientLayer.mask = self.shapeLayer;
}




@end
