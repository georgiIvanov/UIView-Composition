//
//  Hooker.m
//  PracticalComposition
//
//  Created by Georgi Ivanov on 2/4/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "Hook.h"
#import <Aspects.h>

@interface Hook()

@property(nonatomic) SEL deallocSelector;

@end

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
        self.deallocSelector = NSSelectorFromString(@"dealloc");
    }
    
    return self;
}

-(void)hookDeclaredMethodsFrom:(id<Hooking>)system to:(UIView*)view usingComponent:(ViewComponent*)component
{
    NSError* error;
    
    if([system respondsToSelector:@selector(setupAfterLayoutSubviews:forComponent:)])
    {
        [view aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^{
            [system setupAfterLayoutSubviews:view forComponent:component];
        }error:&error];
    }
    
    [view aspect_hookSelector:self.deallocSelector withOptions:AspectPositionBefore usingBlock:^{
        [system removeFromEntitySystem:view];
    }error:&error];
    
    NSAssert(error == nil, @"Method must be hooked without errors");
}

@end
