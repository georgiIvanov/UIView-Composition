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

@implementation ComponentFactory

+(void)AddBouncyComponent:(UIButton*)button withTouchScale:(CGFloat)scale
{
    BouncyButtonComponent* component = [BouncyButtonComponent bouncyButtonWithTouchScale:scale];
    
    [button addComponent:component];
}

@end
