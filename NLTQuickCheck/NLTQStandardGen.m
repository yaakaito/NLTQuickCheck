//
//  NLTQStandardGen.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NLTQStandardGen.h"

@implementation NLTQStandardGen {
    
    NSInteger _minimumSeed;
    NSInteger _maximumSeed;
    NSInteger _currentGeneratedValue;
}

@synthesize minimumSeed = _minimumSeed;
@synthesize maximumSeed = _maximumSeed;
@synthesize currentGeneratedValue = _currentGeneratedValue;

+ (id)standardGenWithMinimumSeed:(NSInteger)minimumSeed
                     maximumSeed:(NSInteger)maximumSeed {

    return [[self alloc] initWithMinimumSeed:minimumSeed maximumSeed:maximumSeed];
}

- (NSInteger)randomIntegerWithMinimum:(NSInteger)minimum maximum:(NSInteger)maximum {
    
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        srand(time(NULL));
    });
    return minimum + (NSInteger)(rand()*(maximum-minimum+1.0)/(1.0+RAND_MAX));
    
}

- (id)initWithMinimumSeed:(NSInteger)minimumSeed
              maximumSeed:(NSInteger)maximumSeed {
    
    self = [super init];
    if(self) {
        _minimumSeed = minimumSeed;
        _maximumSeed = maximumSeed;
        _currentGeneratedValue = [self randomIntegerWithMinimum:minimumSeed maximum:maximumSeed];
    }
    return self;
}

- (id)generateNext {
    
    return [NLTQStandardGen standardGenWithMinimumSeed:10 maximumSeed:50];
}

@end
