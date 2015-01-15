//
//  ShinyButton.m
//  Task Focus
//
//  Created by Georgi Ivanov on 10/28/14.
//  Copyright (c) 2014 GeorgiIvanov. All rights reserved.
//

#import "ShinyButton.h"

@interface ShinyButton()

@property(nonatomic) CAGradientLayer* gradientLayer;
@property(nonatomic) CALayer* touchLayer;
@property(nonatomic) CABasicAnimation* gradientAnimation;
@property(nonatomic) UIColor* shineColor;
@property(nonatomic) NSString* text;

@end

@implementation ShinyButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSString* IBTitle = self.titleLabel.text;
        self.text = IBTitle;
    }
    return self;
}

-(void)setupButton
{
    [self setTitle:@"" forState:UIControlStateNormal];
    self.shineColor = [UIColor whiteColor];
    self.gradientLayer = [[CAGradientLayer alloc] init];
    
    [self addTarget:self action:@selector(tapDown:) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(tapUp:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(tapUp:) forControlEvents:UIControlEventTouchDragExit | UIControlEventTouchCancel];
    
    [self createGradientWithSize:self.bounds.size];
    UIImage* image = [self drawImageFromTextWithBounds:self.bounds];
    [self createMaskLayerWithBounds:self.bounds andImage:image];
    [self applyAnimation:self.bounds.size];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.gradientLayer == nil)
    {
        [self setupButton];
    }
}

-(void)createGradientWithSize:(CGSize)size
{
    self.clipsToBounds = NO;
    
    self.gradientLayer.frame = CGRectMake(0, 0, size.width, size.height * 1.68);
    self.gradientLayer.startPoint = CGPointMake(0, 1);
    self.gradientLayer.endPoint = CGPointMake(0, 0);
    
    NSArray* colors = @[
                        (id)self.titleLabel.textColor.CGColor,
                        (id)self.shineColor.CGColor,
                        (id)self.titleLabel.textColor.CGColor
                        ];
    
    self.gradientLayer.colors = colors;
    
    NSArray* locations = @[
                           @(0.00),
                           @(0.250),
                           @(0.500)
                           ];
    
    self.gradientLayer.locations = locations;
    
    [self.layer addSublayer:self.gradientLayer];
}

-(void)applyAnimation:(CGSize)size
{
    if(_gradientAnimation)
    {
        [self.gradientLayer addAnimation:_gradientAnimation forKey:@"shining"];
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

    [self.gradientLayer addAnimation:animation forKey:@"shining"];
}

-(UIImage*)drawImageFromTextWithBounds:(CGRect)bounds
{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, 0.0f);
    
    NSDictionary* attributes = [self createTextAttributes];
    
    bounds = [self centerTextInBounds:bounds attributes:attributes];
    
    [self.text drawInRect:bounds
           withAttributes:attributes];
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(CGRect)centerTextInBounds:(CGRect)bounds attributes:(NSDictionary*)attributes
{
    NSStringDrawingContext *context = [NSStringDrawingContext new];
    CGRect boundingRect = [self.text boundingRectWithSize:bounds.size options:NSStringDrawingUsesFontLeading attributes:attributes context:context];
    
    CGFloat xInset = ((bounds.size.width - boundingRect.size.width) / 2);
    CGFloat yInset = ((bounds.size.height - (fabsf(boundingRect.origin.y) + boundingRect.size.height)) / 2) + 1;
    return CGRectMake(xInset, yInset, boundingRect.size.width, boundingRect.size.height);
}


-(void)createMaskLayerWithBounds:(CGRect)bounds andImage:(UIImage*)image
{
    CALayer* maskLayer = [[CALayer alloc] init];
    maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    maskLayer.frame = bounds;
    maskLayer.contents = (__bridge id)(image.CGImage);
    
    self.touchLayer = [[CALayer alloc] init];
    self.touchLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.touchLayer.frame = maskLayer.frame;
    
    [self.gradientLayer addSublayer:self.touchLayer];
    
    self.gradientLayer.mask = maskLayer;
}

-(NSDictionary*)createTextAttributes
{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    
    return @{
             NSFontAttributeName: self.titleLabel.font,
             NSParagraphStyleAttributeName: style
             };
}

#pragma mark - Touch Events

-(void)tapDown:(UIButton*)sender
{
    self.touchLayer.backgroundColor = [UIColor colorWithRed:0.455 green:0.455 blue:0.471 alpha:0.8].CGColor;;
}

-(void)tapUp:(UIButton*)sender
{
    self.touchLayer.backgroundColor = [UIColor clearColor].CGColor;
}

@end
