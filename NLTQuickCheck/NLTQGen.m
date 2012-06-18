//
//  NLTQGen.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NLTQGen.h"
#import "NLTQStandardGen.h"

@interface NLTQGen()
@property(nonatomic,strong) NLTQStandardGen *standardGen;
@property(nonatomic,strong) __generateBlock generateBlock;
@property(nonatomic,strong) NLTQGen *bindingGen;
@property(nonatomic,strong) __skipCaseBlock skipCaseBlock;
@end

@implementation NLTQGen

@synthesize standardGen = _standardGen;
@synthesize generateBlock = _generateBlock;
@synthesize bindingGen = _bindingGen;
@synthesize skipCaseBlock = _skipCaseBlock;

- (id)initWithGenerateBlock:(__generateBlock)block {
    
    self = [super init];
    if(self) {
        self.generateBlock = block;
        self.standardGen = [NLTQStandardGen standardGenWithMinimumSeed:kNLTQGenDefaultMiniumSeed
                                                       maximumSeed:kNLTQGenDefaultMaxiumSeed];
    }
    return self;
}

- (id)initWithGenerateBlock:(__generateBlock)block miniumSeed:(int)minimumSeed maximumSeed:(int)maximumSeed {

    self = [super init];
    if(self) {
        self.generateBlock = block;
        self.standardGen = [NLTQStandardGen standardGenWithMinimumSeed:minimumSeed
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
    
    int random = self.standardGen.currentGeneratedValue;
    self.standardGen = [_standardGen generateNext];
    if(self.bindingGen) {
        random = [[self.bindingGen valueWithProgress:progress] intValue];
    }
    
    id value = self.generateBlock(progress, random);

    if(!self.skipCaseBlock) {
        return value;
    }
    
    BOOL skip = self.skipCaseBlock(value);
    
    return skip ? nil : value;
}

- (void)resizeWithMinimumSeed:(int)minimumSeed maximumSeed:(int)maximumSeed {
    
    self.standardGen = [NLTQStandardGen standardGenWithMinimumSeed:minimumSeed
                                                   maximumSeed:maximumSeed];
}

- (void)bindingGen:(NLTQGen *)gen {
    
    NSAssert([[gen valueWithProgress:0] isKindOfClass:[NSNumber class]], @"this bind gen not return NSNumber object");
    self.bindingGen = gen;
}

- (id)andSkipCaseBlock:(__skipCaseBlock)block {
    
    self.skipCaseBlock = block;
    return self;
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
