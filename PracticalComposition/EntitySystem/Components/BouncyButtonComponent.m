//
//  BouncyButtonComponent.m
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "BouncyButtonComponent.h"

@interface BouncyButtonComponent()

@property(nonatomic, readwrite) CGFloat touchDownXScale;
@property(nonatomic, readwrite) CGFloat touchDownYScale;

@end

@implementation BouncyButtonComponent

+(instancetype)bouncyButtonWithTouchScale:(CGFloat)pressScale
{
    BouncyButtonComponent* component = [[BouncyButtonComponent alloc] init];
    [component setScalingTouchDown:pressScale];
    return component;
}

-(void)setScalingTouchDown:(CGFloat)down
{
    _touchDownXScale = down;
    _touchDownYScale = down;
}


@end
