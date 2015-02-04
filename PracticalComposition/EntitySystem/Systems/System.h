//
//  System.h
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/16/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewComponent.h"
#import "EntityManager.h"
#import "Hooking.h"

@interface System : NSObject <Hooking>

@property(nonatomic, weak) EntityManager* entityManager;

-(instancetype)init UNAVAILABLE_ATTRIBUTE;
-(instancetype)initWithEntityManager:(EntityManager*)entityManager;
- (void)setupEntity:(UIView*)entity forComponent:(ViewComponent*)component;

@end
