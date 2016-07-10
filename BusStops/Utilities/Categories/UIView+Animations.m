//
//  UIView+Animations.m
//  AlphaApps
//
//  Created by Arslan Raza on 12/06/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import "UIView+Animations.h"



@implementation UIView (Animations)

#pragma mark - Private Methods

#pragma mark - Life Cycle Methods

#pragma mark - Public Methods

#pragma mark - UIVIEW FRAME SETTERS

- (void)setOrigin:(CGPoint)point {
    [self setFrame:CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height)];
}
- (void)setSize:(CGSize)size {
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height)];
}

- (void)setFrameX:(CGFloat)newX {
    [self setOrigin:CGPointMake(newX, self.frame.origin.y)];
}
- (void)setFrameY:(CGFloat)newY {
    [self setOrigin:CGPointMake(self.frame.origin.x, newY)];
}
- (void)setFrameWidth:(CGFloat)width {
    [self setSize:CGSizeMake(width, self.frame.size.height)];
}
- (void)setFrameHeight:(CGFloat)height {
    [self setSize:CGSizeMake(self.frame.size.width, height)];
}

#pragma mark - UIVIEW SCALE SETTERS

- (void)setScaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY {
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY);
}

- (void)setScale:(CGFloat)scale {
    [self setScaleX:scale scaleY:scale];
}

- (void)setScaleX:(CGFloat)scaleX {
    [self setScaleX:scaleX scaleY:1.0f];
}

- (void)setScaleY:(CGFloat)scaleY {
    [self setScaleX:1.0f scaleY:scaleY];
}

- (void)setCornersRadius:(float)radius {
    [self.layer setCornerRadius:radius];
}

- (void)setCornerRadiusAsCircle {
    float minValue = MIN(self.frame.size.width, self.frame.size.height);
    [self.layer setCornerRadius:minValue/2];
}

- (void)addShadow {
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOffset:CGSizeMake(2, 4)];
    [self.layer setShadowOpacity:0.1];
}

- (void)fadeInWithDelay:(CGFloat)delay completion:(void (^)(BOOL finished))completion {
    
    [UIView animateWithDuration:kANIM_TIME delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 1.0f;
    } completion:completion];
    
}

@end
