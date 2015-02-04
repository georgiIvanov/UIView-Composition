//
//  SecondViewController.m
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/16/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "SecondViewController.h"
#import "ComponentFactory.h"

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ComponentFactory addBouncyComponent:self.firstButton withTouchScale:2.5];
    [ComponentFactory addShinyComponent:self.secondButton withShineColor:[UIColor whiteColor]];
    [ComponentFactory addBouncyComponent:self.thirdButton withTouchScale:1.5];
    [ComponentFactory addShinyComponent:self.thirdButton withShineColor:[UIColor greenColor]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


@end
