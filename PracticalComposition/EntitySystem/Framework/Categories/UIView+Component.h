//
//  UIView+Component.h
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewComponent.h"

@interface UIView (Component)

-(void)addComponent:(ViewComponent*)component;

@end
