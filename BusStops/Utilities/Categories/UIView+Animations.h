//
//  UIView+Animations.h
//  AlphaApps
//
//  Created by Arslan Raza on 12/06/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kANIM_TIME                                              0.3f

@interface UIView (Animations)

- (void)setOrigin:(CGPoint)point ;
- (void)setSize:(CGSize)size;
- (void)setFrameX:(CGFloat)newX;
- (void)setFrameY:(CGFloat)newY;
- (void)setFrameWidth:(CGFloat)width;
- (void)setFrameHeight:(CGFloat)height;

- (void)setScaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY;
- (void)setScale:(CGFloat)scale;
- (void)setScaleX:(CGFloat)scaleX;

- (void)setScaleY:(CGFloat)scaleY;

- (void)setCornersRadius:(float)radius;
- (void)setCornerRadiusAsCircle;
- (void)addShadow;
- (void)fadeInWithDelay:(CGFloat)delay completion:(void (^)(BOOL finished))completion;

@end
