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
    
}

- (id)initWithGenerateBlock:(__generateBlock)block {
    
    self = [super init];
    if(self) {
        _block = block;
        _standardGen = [NLTQStandardGen standardGenWithMinimumSeed:kNLTQGenDefaultMiniumSedd
                                                       maximumSeed:kNLTQGenDefaultMaxiumSeed];
    }
    return self;
}

- (id)initWithGenerateBlock:(__generateBlock)block miniumSeed:(NSInteger)minimumSeed maximumSeed:(NSInteger)maxiumSeed {

    self = [super init];
    if(self) {
        _block = block;
        _standardGen = [NLTQStandardGen standardGenWithMinimumSeed:minimumSeed
                                                       maximumSeed:maxiumSeed];
    }
    return self;
}

+ (id)genWithGenerateBlock:(__generateBlock)block {
    
    return [[self alloc] initWithGenerateBlock:block];
}

+ (id)genWithGenerateBlock:(__generateBlock)block miniumSeed:(NSInteger)minimumSeed maximumSeed:(NSInteger)maxiumSeed {
    
    return [[self alloc] initWithGenerateBlock:block miniumSeed:minimumSeed maximumSeed:maxiumSeed];
}

- (id)valueWithProgress:(double)progress {
    
    return _block(progress, _standardGen.currentGeneratedValue);
}

- (void)resizeWithMinimumSeed:(NSInteger)minimumSeed maximumSeed:(NSInteger)maximumSeed {
    
    _standardGen = [NLTQStandardGen standardGenWithMinimumSeed:minimumSeed
                                                   maximumSeed:maximumSeed];
}

+ (NSArray*)numbersArrayWithLow:(NSInteger)low high:(NSInteger)high {
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = low; i < high + 1; i++) {
        [array addObject:[NSNumber numberWithInt:i]];
    }
    return (NSArray*)array;
}

+ (id)chooseGenWithLow:(NSInteger)low high:(NSInteger)high {

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

+ (id)randomGen {
    
    return [self genWithGenerateBlock:^id(double progress, int random) {
        return [NSNumber numberWithInt:random];
    }];
    
}
@end
