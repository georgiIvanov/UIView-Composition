//
//  BouncyButtonComponent.h
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "ViewComponent.h"

@interface BouncyButtonComponent : ViewComponent

@property(nonatomic, readonly) CGFloat touchDownXScale;
@property(nonatomic, readonly) CGFloat touchDownYScale;

+(instancetype)bouncyButtonWithTouchScale:(CGFloat)pressScale;
-(void)setScalingTouchDown:(CGFloat)down;

@end
