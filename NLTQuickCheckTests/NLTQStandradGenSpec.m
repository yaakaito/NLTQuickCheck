//
//  NLTQuickCheck - NLTQStandradGenSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQStandardGen.h"

SPEC_BEGIN(NLTQStandradGenSpec)

describe(@"Standard Gen(erator)", ^{
    __block NLTQStandardGen *gen;
    
    context(@"with minimum = 10 and maximum = 20", ^{
        
        beforeEach(^{
            gen = [NLTQStandardGen standardGenWithMinimumSeed:10 maximumSeed:20];
        });
        
        it(@"when minimum is 10", ^{
            [[theValue(gen.minimumSeed) should] equal:theValue(10)];
        });
        
        it(@"when maximum is 20", ^{
            [[theValue(gen.maximumSeed) should] equal:theValue(20)];
        });
        
        it(@"when wcurrent generated value in 10~20", ^{
            [[theValue(gen.currentGeneratedValue) should] beBetween:theValue(10) and:theValue(20)];
        });
    });
    
    context(@"with minimum = 20 and maximum = 30", ^{
        
        beforeEach(^{
            gen = [NLTQStandardGen standardGenWithMinimumSeed:20 maximumSeed:30];
        });
        
        it(@"minimum is 20", ^{
            [[theValue(gen.minimumSeed) should] equal:theValue(20)];
        });
        
        it(@"maximum is 30", ^{
            [[theValue(gen.maximumSeed) should] equal:theValue(30)];
        });
        
        it(@"current generated value in 20~30", ^{
            [[theValue(gen.currentGeneratedValue) should] beBetween:theValue(20) and:theValue(30)];
        });
    });
});

SPEC_END
