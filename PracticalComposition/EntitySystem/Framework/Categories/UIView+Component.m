//
//  UIView+Component.m
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "UIView+Component.h"
#import "EntityManager.h"

@implementation UIView (Component)

-(void)addComponent:(ViewComponent*)component
{
    [[EntityManager sharedEntityManager] addComponent:component toEntity:self];
}

@end
