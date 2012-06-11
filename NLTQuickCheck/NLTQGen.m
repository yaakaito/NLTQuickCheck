//
//  NLTQGen.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NLTQGen.h"
#import "NLTQStandardGen.h"

@implementation NLTQGen {
    
    NLTQStandardGen *_standardGen;
    __generateBlock _block;
    NLTQGen *_bindingGen;
    
}

- (id)initWithGenerateBlock:(__generateBlock)block {
    
    self = [super init];
    if(self) {
        _block = block;
        _standardGen = [NLTQStandardGen standardGenWithMinimumSeed:kNLTQGenDefaultMiniumSeed
                                                       maximumSeed:kNLTQGenDefaultMaxiumSeed];
    }
    return self;
}

- (id)initWithGenerateBlock:(__generateBlock)block miniumSeed:(int)minimumSeed maximumSeed:(int)maximumSeed {

    self = [super init];
    if(self) {
        _block = block;
        _standardGen = [NLTQStandardGen standardGenWithMinimumSeed:minimumSeed
                                                       maximumSeed:maximumSeed];
    }
    return self;
}

+ (id)genWithGenerateBlock:(__generateBlock)block {
    
    return [[self alloc] initWithGenerateBlock:block];
}

+ (id)genWithGenerateBlock:(__generateBlock)block miniumSeed:(int)minimumSeed maximumSeed:(int)maxiumSeed {
    
    return [[self alloc] initWithGenerateBlock:block miniumSeed:minimumSeed maximumSeed:maxiumSeed];
}

- (id)valueWithProgress:(double)progress {
    
    int random = _standardGen.currentGeneratedValue; _standardGen = [_standardGen generateNext];
    if(_bindingGen) {
        random = [[_bindingGen valueWithProgress:progress] intValue];
    }
    return _block(progress, random);
}

- (void)resizeWithMinimumSeed:(int)minimumSeed maximumSeed:(int)maximumSeed {
    
    _standardGen = [NLTQStandardGen standardGenWithMinimumSeed:minimumSeed
                                                   maximumSeed:maximumSeed];
}

- (void)bindingGen:(NLTQGen *)gen {
    
    NSAssert([[gen valueWithProgress:0] isKindOfClass:[NSNumber class]], @"this bind gen not return NSNumber object");
    _bindingGen = gen;
}

+ (NSArray*)numbersArrayWithLow:(int)low high:(int)high {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = low; i < high + 1; i++) {
        [array addObject:[NSNumber numberWithInt:i]];
    }
    return (NSArray*)array;
}

+ (id)chooseGenWithLow:(int)low high:(int)high {

    return [self elementsGenWithArray:[self numbersArrayWithLow:low
                                                           high:high]];
}

+ (id)elementsGenWithArray:(NSArray *)array {
    
    return [self genWithGenerateBlock:^id(double progress, int random) {
        return [array objectAtIndex:random];
    } 
                           miniumSeed:0
                          maximumSeed:[array count] - 1];
}

+ (id)elementsGenWithObjects:(id)objects, ... {
    
    NSMutableArray *objects_ = [NSMutableArray array];
    va_list arguments;
    va_start(arguments, objects);
    id value = objects;
    while (value) {
        [objects_ addObject:value];
        value = va_arg(arguments, typeof(id));
    }
    va_end(arguments);
    
    return [self elementsGenWithArray:objects_];
}

+ (id)randomGen {
    
    return [self genWithGenerateBlock:^id(double progress, int random) {
        return [NSNumber numberWithInt:random];
    }];
    
}

+ (id)oneOfGenWithGens:(id)firstGen, ... {
    NSMutableArray *objects_ = [NSMutableArray array];
    va_list arguments;
    va_start(arguments, firstGen);
    id value = firstGen;
    while (value) {
        [objects_ addObject:value];
        value = va_arg(arguments, typeof(id));
    }
    va_end(arguments);
    
    NLTQGen *choose = [NLTQGen chooseGenWithLow:0 high:[objects_ count]-1];
    NLTQGen *oneof = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
        return [objects_ objectAtIndex:(NSUInteger)random];
    }];
    [oneof bindingGen:choose];
    return oneof;
}

+ (id)quadraticGenWithA :(int)a b:(int)b c:(int)c {
    return [self genWithGenerateBlock:^id(double progress, int random) {
        return [NSNumber numberWithInt:(a * (progress * progress)) + (b * progress) + c];
    }];
}
@end
