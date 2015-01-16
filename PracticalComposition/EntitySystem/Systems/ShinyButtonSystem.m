//
//  ShinyButtonSystem.m
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/16/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "ShinyButtonSystem.h"
#import "ShinyButtonComponent.h"
#import <UIKit/UIButton.h>
#import <UIKit/UILabel.h>
#import <UIKit/UIGraphics.h>
#import <UIKit/UIImage.h>
#import <UIKit/NSStringDrawing.h>
#import <BILib.h>

@implementation ShinyButtonSystem

-(instancetype)initWithEntityManager:(EntityManager*)entityManager
{
    self = [super initWithEntityManager:entityManager];
    if(self)
    {
        
    }
    return self;
}
- (void)setupEntity:(UIView*)entity forComponent:(ViewComponent*)component
{
    UIButton* button = (UIButton*)entity;
    ShinyButtonComponent* shinyComponent = (ShinyButtonComponent*)component;
    shinyComponent.text = button.titleLabel.text;
    [button setTitle:@"" forState:UIControlStateNormal];
    button.clipsToBounds = NO;
    
    shinyComponent.gradientLayer = [[CAGradientLayer alloc] init];
    
    [button addTarget:self action:@selector(tapDown:) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [button addTarget:self action:@selector(tapUp:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(tapUp:) forControlEvents:UIControlEventTouchDragExit | UIControlEventTouchCancel];
    
    [self createGradientWithSize:button.bounds.size button:button withComponent:shinyComponent];
    UIImage* image = [self drawImageFromTextButton:button withComponent:shinyComponent];
    [self createMaskLayerButton:button withComponent:shinyComponent andImage:image];
    [self applyAnimationForButton:button withComponent:shinyComponent];
}

-(void)createGradientWithSize:(CGSize)size button:(UIButton*)button withComponent:(ShinyButtonComponent*)component
{
    component.gradientLayer.frame = CGRectMake(0, 0, size.width, size.height * 1.68);
    component.gradientLayer.startPoint = CGPointMake(0, 1);
    component.gradientLayer.endPoint = CGPointMake(0, 0);
    
    NSArray* colors = @[
                        (id)button.titleLabel.textColor.CGColor,
                        (id)component.shineColor.CGColor,
                        (id)button.titleLabel.textColor.CGColor
                        ];
    
    component.gradientLayer.colors = colors;
    
    NSArray* locations = @[
                           @(0.00),
                           @(0.250),
                           @(0.500)
                           ];
    
    component.gradientLayer.locations = locations;
    
    [button.layer addSublayer:component.gradientLayer];
}

-(void)applyAnimationForButton:(UIButton*)button withComponent:(ShinyButtonComponent*)component
{
    if(component.gradientAnimation)
    {
        [component.gradientLayer addAnimation:component.gradientAnimation forKey:@"shining"];
        return;
    }
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"locations"];
    animation.duration = 4;
    animation.repeatCount = 1000000;
    
    animation.additive = YES;
    animation.values = @[
                         @[@(0.0), @(0.0), @(0.0)],
                         @[@(0.85), @(0.85), @(0.85)],
                         @[@(1), @(1), @(1)]
                         ];
    animation.keyTimes = @[@(0.6), @(0.78), @(1)];
    CAMediaTimingFunction* timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.timingFunctions = @[
                                  timingFunction,
                                  timingFunction,
                                  timingFunction,
                                  ];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [component.gradientLayer addAnimation:animation forKey:@"shining"];
}

-(UIImage*)drawImageFromTextButton:(UIButton*)button withComponent:(ShinyButtonComponent*)component
{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    
    UIGraphicsBeginImageContextWithOptions(button.bounds.size, NO, 0.0f);
    
    NSDictionary* attributes = [self createTextAttributesButton:button];
    
    CGRect bounds = [self centerTextInButton:button withComponent:component andAttributes:attributes];
    
    [component.text drawInRect:bounds
           withAttributes:attributes];
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(CGRect)centerTextInButton:(UIButton*)button withComponent:(ShinyButtonComponent*)component andAttributes:(NSDictionary*)attributes
{
    NSStringDrawingContext *context = [NSStringDrawingContext new];
    CGRect boundingRect = [component.text boundingRectWithSize:button.bounds.size options:NSStringDrawingUsesFontLeading attributes:attributes context:context];
    
    CGFloat xInset = ((button.bounds.size.width - boundingRect.size.width) / 2);
    CGFloat yInset = ((button.bounds.size.height - (fabsf(boundingRect.origin.y) + boundingRect.size.height)) / 2) + 1;
    return CGRectMake(xInset, yInset, boundingRect.size.width, boundingRect.size.height);
}


-(void)createMaskLayerButton:(UIButton*)button withComponent:(ShinyButtonComponent*)component andImage:(UIImage*)image
{
    CALayer* maskLayer = [[CALayer alloc] init];
    maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    maskLayer.frame = button.bounds;
    maskLayer.contents = (__bridge id)(image.CGImage);
    
    component.touchLayer = [[CALayer alloc] init];
    component.touchLayer.backgroundColor = [UIColor clearColor].CGColor;
    component.touchLayer.frame = maskLayer.frame;
    
    [component.gradientLayer addSublayer:component.touchLayer];
    
    component.gradientLayer.mask = maskLayer;
}

-(NSDictionary*)createTextAttributesButton:(UIButton*)button
{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    
    return @{
             NSFontAttributeName: button.titleLabel.font,
             NSParagraphStyleAttributeName: style
             };
}

#pragma mark - Touch Events

-(void)tapDown:(UIButton*)sender
{
    ShinyButtonComponent* shinyComponent = (ShinyButtonComponent*) [self.entityManager getComponentOfClass:[ShinyButtonComponent class] forEntity:sender];
    shinyComponent.touchLayer.backgroundColor = [UIColor colorWithRed:0.455 green:0.455 blue:0.471 alpha:0.8].CGColor;;
}

-(void)tapUp:(UIButton*)sender
{
    ShinyButtonComponent* shinyComponent = (ShinyButtonComponent*) [self.entityManager getComponentOfClass:[ShinyButtonComponent class] forEntity:sender];
    shinyComponent.touchLayer.backgroundColor = [UIColor clearColor].CGColor;
}
@end
