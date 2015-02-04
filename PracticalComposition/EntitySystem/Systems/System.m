//
//  System.m
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/16/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "System.h"
#import "Hook.h"

@interface System()

@property(nonatomic, weak) Hook* hook;

@end

@implementation System

-(instancetype)initWithEntityManager:(EntityManager*)entityManager
{
    self = [super init];
    if(self)
    {
        self.entityManager = entityManager;
        self.hook = [Hook sharedHook];
    }
    
    return self;
}

- (void)setupEntity:(UIView*)entity forComponent:(ViewComponent*)component
{
//    NSLog(@"%@", entity);
    [self.hook hookDeclaredMethodsFrom:self to:entity usingComponent:component];
}

-(void)removeFromEntitySystem:(UIView *)view
{
    [self.entityManager removeEntity:view];
}

@end
