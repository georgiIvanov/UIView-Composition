//
//  Hooker.m
//  PracticalComposition
//
//  Created by Georgi Ivanov on 2/4/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "Hook.h"
#import <Aspects.h>

@implementation Hook

+(instancetype)sharedHook
{
    static Hook *_sharedHooker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHooker = [[Hook alloc] initSharedHook];
    });
    
    return _sharedHooker;
}

-(instancetype)initSharedHook
{
    self = [super init];
    if(self)
    {
        
    }
    
    return self;
}

-(void)hookDeclaredMethodsFrom:(id<Hooking>)system to:(UIView*)view usingComponent:(ViewComponent*)component
{
    NSError* error;
    id<AspectToken> token;
    __weak id<Hooking> weakSystem = system;
    __weak UIView* weakView = view;
    __weak ViewComponent* weakComponent = component;
    
    if([weakSystem respondsToSelector:@selector(setupAfterLayoutSubviews:forComponent:)])
    {
        token = [weakView aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^{
            [weakSystem setupAfterLayoutSubviews:weakView forComponent:weakComponent];
        }error:&error];
    }
    
    NSAssert(error == nil, @"Method must be hooked without errors");
    
    [weakView aspect_hookSelector:@selector(removeFromSuperview) withOptions:AspectPositionBefore usingBlock:^{
        [weakSystem removeFromEntitySystem:weakView];
    }error:&error];
    
    NSAssert(error == nil, @"Method must be hooked without errors");
}

@end
