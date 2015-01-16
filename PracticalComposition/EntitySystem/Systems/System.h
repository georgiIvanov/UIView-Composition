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

@interface System : NSObject

@property(nonatomic, weak) EntityManager* entityManager;

-(instancetype)initWithEntityManager:(EntityManager*)entityManager;
- (void)setupEntity:(UIView*)entity forComponent:(ViewComponent*)component;

@end
