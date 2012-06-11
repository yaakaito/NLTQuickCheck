//
//  NLTQStandardGen.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NLTQStandardGen.h"

@implementation NLTQStandardGen {
    
    int _minimumSeed;
    int _maximumSeed;
    int _currentGeneratedValue;
}

@synthesize minimumSeed = _minimumSeed;
@synthesize maximumSeed = _maximumSeed;
@synthesize currentGeneratedValue = _currentGeneratedValue;

- (id)initWithMinimumSeed:(int)minimumSeed
              maximumSeed:(int)maximumSeed {
    
    self = [super init];
    if(self) {
        _minimumSeed = minimumSeed;
        _maximumSeed = maximumSeed;
        _currentGeneratedValue = [self randomIntWithMinimum:minimumSeed maximum:maximumSeed];
    }
    return self;
}

+ (id)standardGenWithMinimumSeed:(int)minimumSeed
                     maximumSeed:(int)maximumSeed {

    return [[self alloc] initWithMinimumSeed:minimumSeed maximumSeed:maximumSeed];
}

- (int)randomIntWithMinimum:(int)minimum maximum:(int)maximum {
    
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        srand(time(NULL));
    });
    return minimum + (int)(rand()*(maximum-minimum+1.0)/(1.0+RAND_MAX));
    
}

- (id)generateNext {
    
    return [NLTQStandardGen standardGenWithMinimumSeed:_minimumSeed maximumSeed:_maximumSeed];
}

@end
