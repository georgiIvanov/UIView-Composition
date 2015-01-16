//
//  EntityManager.m
//  PracticalComposition
//
//  Created by Georgi Ivanov on 1/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "EntityManager.h"
#import "BouncyButtonSystem.h"

@interface EntityManager()

@property(nonatomic) NSMutableDictionary* componentsByClass;
@property(nonatomic) NSMutableArray* entities;
@property(nonatomic) NSMutableDictionary* systems;

@end

@implementation EntityManager

+(instancetype)sharedEntityManager
{
    static EntityManager* _sharedEntityManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedEntityManager = [[EntityManager alloc] init];
    });
    
    return _sharedEntityManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.componentsByClass = [@{} mutableCopy];
        self.systems = [@{} mutableCopy];
        [self registerSystems];
    }
    return self;
}

-(void)registerSystems
{
    NSString* systemName;
    BouncyButtonSystem* bouncyButtonSystem = [[BouncyButtonSystem alloc] initWithEntityManager:self];
    systemName = [self extractSystemName:bouncyButtonSystem];
    [self.systems setObject:bouncyButtonSystem forKey:systemName];
}

-(NSString*)extractSystemName:(System*)system
{
    static NSString* separator = @"System";
    NSString* name = NSStringFromClass([system class]);
    NSArray* stringComponents = [name componentsSeparatedByString: separator];
    name = [stringComponents firstObject];
    return name;
}

-(NSString*)extractComponentName:(NSString*)className
{
    static NSString* separator = @"Component";
    NSArray* stringComponents = [className componentsSeparatedByString: separator];
    NSString* name = [stringComponents firstObject];
    return name;
}

-(void)addComponent:(ViewComponent*)component toEntity:(UIView*)entity
{
    NSString* componentClassName = NSStringFromClass([component class]);
    NSMutableDictionary* components = _componentsByClass[componentClassName];
    
    if(!components)
    {
        components = [NSMutableDictionary dictionary];
        _componentsByClass[componentClassName] = components;
    }
    
    components[[NSValue valueWithNonretainedObject:entity]] = component;
    
    NSString* componentName = [self extractComponentName:componentClassName];
    System* system = [self.systems objectForKey:componentName];
    [system setupEntity:entity forComponent:component];
}

-(ViewComponent*)getComponentOfClass:(Class)class forEntity:(UIView*)entity
{
    NSValue* key = [NSValue valueWithNonretainedObject:entity];
    return self.componentsByClass[NSStringFromClass(class)][key];
}

-(void)removeEntity:(UIView*)entity
{
    NSValue* key = [NSValue valueWithNonretainedObject:entity];
    for (NSMutableDictionary* components in self.componentsByClass.allValues)
    {
        if(components[key])
        {
            [components removeObjectForKey:key];
        }
    }
    
    [_entities removeObject:key];
}

@end
