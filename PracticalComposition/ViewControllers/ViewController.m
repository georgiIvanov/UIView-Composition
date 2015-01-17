//
//  ViewController.m
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/14/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "ViewController.h"
#import "ComponentFactory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ComponentFactory addBouncyComponent:self.button withTouchScale:2.5];
    [ComponentFactory addShinyComponent:self.secondButton withShineColor:[UIColor whiteColor]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
