//
//  Hooker.h
//  PracticalComposition
//
//  Created by Georgi Ivanov on 2/4/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "System.h"
#import "Hooking.h"
#import "ViewComponent.h"

@interface Hook : NSObject

+(void)hookDeclaredMethodsFrom:(id<Hooking>)system to:(UIView*)view usingComponent:(ViewComponent*)component;

@end
