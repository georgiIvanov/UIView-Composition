//
//  ShinyButtonComponent.h
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/16/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "ViewComponent.h"
#import <QuartzCore/QuartzCore.h>

@interface ShinyButtonComponent : ViewComponent

@property(nonatomic, readonly) CAGradientLayer* gradientLayer;
@property(nonatomic, readonly) CALayer* touchLayer;
@property(nonatomic, readonly) CABasicAnimation* gradientAnimation;
@property(nonatomic, readonly) UIColor* shineColor;
@property(nonatomic, readonly) NSString* text;

@end
