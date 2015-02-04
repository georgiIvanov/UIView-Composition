//
//  EntityManager.h
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewComponent.h"

@interface EntityManager : NSObject

+(instancetype)init UNAVAILABLE_ATTRIBUTE;
+(instancetype)sharedEntityManager;
-(void)addComponent:(ViewComponent*)component toEntity:(UIView*)entity;
-(ViewComponent*)getComponentOfClass:(Class)class forEntity:(UIView*)entity;
-(void)removeEntity:(UIView*)entity;

@end
