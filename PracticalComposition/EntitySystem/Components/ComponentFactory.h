//
//  ComponentFactory.h
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/16/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ComponentFactory : NSObject

+(void)AddBouncyComponent:(UIButton*)button withTouchScale:(CGFloat)scale;

@end
