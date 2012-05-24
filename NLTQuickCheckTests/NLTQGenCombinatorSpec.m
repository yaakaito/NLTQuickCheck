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
    context(@"class method ``chooseWithLow:high:`` ", ^{
        
        it(@"low 10 and high 20, value in 10 ~ 20", ^{
            NSInteger r = [NLTQGen chooseWithLow:10 High:20];
            [[theValue(r) should] beGreaterThanOrEqualTo:theValue(10)];
            [[theValue(r) should] beLessThanOrEqualTo:theValue(20)];
        });
    });
    
    context(@"class method ``objectAtRandomIndexFromArray:`` ", ^{
        
        it(@"array with 1 objects, value array[0]", ^{
            id object = [NLTQGen objectAtRandomIndexFromArray:[NSArray arrayWithObject:[NSNumber numberWithInt:1]]];
            [[theValue([object intValue]) should] equal:theValue(1)];
        });
        
        it(@"array with 3 objects, value array index of 0~2", ^{
            id object = [NLTQGen objectAtRandomIndexFromArray:[NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3], nil]];
            [[theValue([object intValue]) should] beGreaterThanOrEqualTo:theValue(1)];
            [[theValue([object intValue]) should] beLessThanOrEqualTo:theValue(3)];
        });
    });
});

SPEC_END
