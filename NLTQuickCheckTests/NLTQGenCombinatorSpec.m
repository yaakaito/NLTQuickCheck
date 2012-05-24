//
//  NLTQuickCheck - NLTQGenCombinatorSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQGen.h"

SPEC_BEGIN(NLTQGenCombinatorSpec)

describe(@"Gen(erator)", ^{
    context(@"class method ``chooseGenWithLow:High`` ", ^{
        
        context(@"call with low 10 and high 20", ^{
            __block NLTQGen *gen;
            
            beforeEach(^{
                gen = [NLTQGen chooseGenWithLow:10 high:20];
            });
            
            it(@"at progress 0.1, value in 10 - 20", ^{
                NSNumber *v = [gen valueWithProgress:0.1];
                [[theValue([v intValue]) should] beGreaterThanOrEqualTo:theValue(10)];
                [[theValue([v intValue]) should] beLessThanOrEqualTo:theValue(20)];
            });
        });
    });
    
    context(@"class method ``elementsGenWithArray:`` ", ^{
        
        context(@"call with [1,2,3]", ^{
            __block NLTQGen *gen;
            
            beforeEach(^{
                gen = [NLTQGen elementsGenWithArray:[NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2], nil]];
            });

            it(@"at progress 0.1 value in 1 ~ 3", ^{
                NSNumber *v = [gen valueWithProgress:0.1];
                [[theValue([v intValue]) should] beGreaterThanOrEqualTo:theValue(1)];
                [[theValue([v intValue]) should] beLessThanOrEqualTo:theValue(3)];
            });
        });
    });
});

SPEC_END
