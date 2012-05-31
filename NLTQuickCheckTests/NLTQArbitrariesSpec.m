//
//  NLTQuickCheck - NLTQArbitrariesSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQArbitrary.h"
#import "NLTQGen.h"

SPEC_BEGIN(NLTQArbitrariesSpec)

describe(@"bool arbitrary", ^{
    __block NLTQGen *gen;
    beforeEach(^{
        gen = [NSNumber boolArbitrary];
    });
    
    it(@"when NLTQGen object", ^{
        [[gen should] beKindOfClass:[NLTQGen class]];
    });
    
    it(@"when value NSNumber object", ^{
        [[[gen valueWithProgress:0] should] beKindOfClass:[NSNumber class]];
    });

    it(@"when value YES or NO", ^{
        for(double p = 0.0; p < 1.0; p += 0.01) {
            __block BOOL v, r;
            theBlock(^{
                NSNumber *n = [gen valueWithProgress:p];
                v = [n intValue];
                r = v == YES || v == NO;
            });
            [[theValue(r) should] beTrue];
        }
    });
});

SPEC_END
