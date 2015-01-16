//
//  BouncyButtonSystem.m
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/16/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "BouncyButtonSystem.h"
#import "BouncyButtonComponent.h"
#import <UIKit/UIButton.h>

@interface BouncyButtonSystem()

@end

@implementation BouncyButtonSystem

- (void)setupEntity:(UIView*)entity forComponent:(ViewComponent*)component
{
    UIButton* button = (UIButton*)entity;
    
    [button addTarget:self action:@selector(scaleOnTouch:)
   forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [button addTarget:self action:@selector(scaleOnTouchUp:)
   forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(scaleToDefault:)
   forControlEvents:UIControlEventTouchDragExit | UIControlEventTouchCancel];
}

- (void)scaleOnTouch:(id)sender
{
    BouncyButtonComponent* bouncyComponent = (BouncyButtonComponent*) [self.entityManager getComponentOfClass:[BouncyButtonComponent class] forEntity:sender];

    [UIView animateWithDuration:0.1f animations:^{
        UIView* view = sender;
        view.transform = CGAffineTransformMakeScale(bouncyComponent.touchDownXScale, bouncyComponent.touchDownYScale);
    }];
}

- (void)scaleOnTouchUp:(id)sender
{
    [self scaleToDefault:sender];
}

- (void)scaleToDefault:(id)sender
{
    [UIView animateWithDuration:0.1f animations:^{
        UIView* view = sender;
        view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

@end
