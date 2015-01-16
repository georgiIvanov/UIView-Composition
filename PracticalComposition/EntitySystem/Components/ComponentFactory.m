//
//  ComponentFactory.m
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/16/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "ComponentFactory.h"
#import "UIView+Component.h"
#import "BouncyButtonComponent.h"
#import "ShinyButtonComponent.h"

@implementation ComponentFactory

+(void)addBouncyComponent:(UIButton*)button withTouchScale:(CGFloat)scale
{
    BouncyButtonComponent* component = [BouncyButtonComponent bouncyButtonWithTouchScale:scale];
    
    [button addComponent:component];
}

+(void)addShinyComponent:(UIButton*)button withShineColor:(UIColor*)color
{
    ShinyButtonComponent* component = [[ShinyButtonComponent alloc] init];
    component.shineColor = color;
    [button addComponent:component];
}

@end
