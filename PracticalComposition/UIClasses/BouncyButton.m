//
//  RoundedButton.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/5/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "BouncyButton.h"

@interface BouncyButton()

@property(nonatomic, assign) CGFloat touchDownXScale;
@property(nonatomic, assign) CGFloat touchDownYScale;

@end

@implementation BouncyButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setScalingTouchDown:(CGFloat)down
{
    _touchDownXScale = down;
    _touchDownYScale = down;
}

- (void)setup
{
    [self setScalingTouchDown:1.5];
    
    [self addTarget:self action:@selector(scaleOnTouch)
   forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(scaleOnTouchUp)
   forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(scaleToDefault)
   forControlEvents:UIControlEventTouchDragExit | UIControlEventTouchCancel];
}

- (void)scaleOnTouch
{
    [UIView animateWithDuration:0.1f animations:^{
        self.transform = CGAffineTransformMakeScale(_touchDownXScale, _touchDownYScale);
    }];
}

- (void)scaleOnTouchUp
{
    [self scaleToDefault];
}

- (void)scaleToDefault
{
    [UIView animateWithDuration:0.1f animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

@end
