//
//  Hooking.h
//  PracticalComposition
//
//  Created by Georgi Ivanov on 2/4/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "System.h"
#import "ViewComponent.h"

// Systems implement this protocol to declare at which stage of
// the rendering process the component has to be initialized
@protocol Hooking <NSObject>

-(void)removeFromEntitySystem:(UIView*)view;

@optional

-(void)setupAfterLayoutSubviews:(UIView*)button forComponent:(ViewComponent*)shinyComponent;

@end
