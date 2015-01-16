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

@property(nonatomic) CAGradientLayer* gradientLayer;
@property(nonatomic) CALayer* touchLayer;
@property(nonatomic) CABasicAnimation* gradientAnimation;
@property(nonatomic) UIColor* shineColor;
@property(nonatomic) NSString* text;

@end
