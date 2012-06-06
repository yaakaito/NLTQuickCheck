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
        
        it(@"should minimum is 10", ^{
            [[theValue(gen.minimumSeed) should] equal:theValue(10)];
        });
        
        it(@"should maximum is 20", ^{
            [[theValue(gen.maximumSeed) should] equal:theValue(20)];
        });
        
        it(@"should wcurrent generated value between 10 ~ 20", ^{
            [[theValue(gen.currentGeneratedValue) should] beBetween:theValue(10) and:theValue(20)];
        });
    });
    
    context(@"with minimum = 20 and maximum = 30", ^{
        
        beforeEach(^{
            gen = [NLTQStandardGen standardGenWithMinimumSeed:20 maximumSeed:30];
        });
        
        it(@"should minimum is 20", ^{
            [[theValue(gen.minimumSeed) should] equal:theValue(20)];
        });
        
        it(@"should maximum is 30", ^{
            [[theValue(gen.maximumSeed) should] equal:theValue(30)];
        });
        
        it(@"should current generated value between 20 ~ 30", ^{
            [[theValue(gen.currentGeneratedValue) should] beBetween:theValue(20) and:theValue(30)];
        });
    });
});

SPEC_END
