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
    
    [ComponentFactory AddBouncyComponent:self.secondButton withTouchScale:1.5];
    [ComponentFactory AddBouncyComponent:self.button withTouchScale:2.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
