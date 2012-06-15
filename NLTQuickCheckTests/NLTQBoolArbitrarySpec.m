//
//  NLTQuickCheck - NLTQArbitrariesSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQArbitrary.h"
#import "NLTQGen.h"

SPEC_BEGIN(NLTQBoolArbitrarySpec)

describe(@"bool arbitrary", ^{
    __block NLTQGen *gen;
    beforeEach(^{
        gen = [NSNumber boolArbitrary];
    });
    
    it(@"should be NLTGen object", ^{
        [[gen should] beKindOfClass:[NLTQGen class]];
    });
    
    it(@"should be value is NSNumber object", ^{
        [[[gen valueWithProgress:0] should] beKindOfClass:[NSNumber class]];
    });

    context(@"when run with double 0 ~ 1 progress", ^{
        it(@"should values YES or NO", ^{
            for(double p = 0.0; p < 1.0; p += 0.01) {
                __block BOOL v, r;
                theBlock(^{
                    NSNumber *n = [gen valueWithProgress:p];
                    v = [n intValue];
                    r = v == YES || v == NO;
                });
                [[theValue(r) should] beYes];
            }
        });
    });
});

describe(@"int arbitrary", ^{
    __block NLTQGen *gen;
    beforeEach(^{
        gen = [NSNumber intArbitrary];
    });
    
    it(@"should be NLTQGen object", ^{
        [[gen should] beKindOfClass:[NLTQGen class]];
    });
    
    it(@"should be value is NSNumber object", ^{
        [[[gen valueWithProgress:0] should] beKindOfClass:[NSNumber class]];
    });
    
    context(@"when run with double 0 ~ 1 progress", ^{
        it(@"should values integer", ^{
            for(double p = 0.0; p < 1.0; p += 0.01) {
                __block NSNumber *v;
                [[theBlock(^{
                    v = [gen valueWithProgress:p];
                }) shouldNot] raise];
                [[theValue(strcmp([v objCType], @encode(int))==0) should] beYes];
            }
        });
    });
});

describe(@"non zero int arbitrary", ^{
    __block NLTQGen *gen;
    beforeEach(^{
        gen = [NSNumber nonZeroIntArbitrary];
    });
    
    it(@"should be NLTQGen object", ^{
        [[gen should] beKindOfClass:[NLTQGen class]];
    });
    
    it(@"should be value is NSNumber object", ^{
        [[[gen valueWithProgress:0] should] beKindOfClass:[NSNumber class]];
    });
    
    context(@"when run with double 0 ~ 1 progress", ^{
        it(@"should values nonZero integer", ^{
            for(double p = 0.0; p < 1.0; p += 0.01) {
                __block NSNumber *v;
                [[theBlock(^{
                    v = [gen valueWithProgress:p];
                }) shouldNot] raise];
                [[theValue(strcmp([v objCType], @encode(int))==0) should] beYes];
                [[theValue([v intValue]) shouldNot] beZero]; 
            }
        });
    });
});

describe(@"double arbitrary", ^{
    __block NLTQGen *gen;
    beforeEach(^{
        gen = [NSNumber doubleArbitrary];
    });
    
    it(@"should be NLTQGen object", ^{
        [[gen should] beKindOfClass:[NLTQGen class]];
    });
    
    it(@"should be value is NSNumber object", ^{
        [[[gen valueWithProgress:0] should] beKindOfClass:[NSNumber class]];
    });
    
    context(@"when run with double 0 ~ 1 progress", ^{
        it(@"should values double", ^{
            for(double p = 0.0; p < 1.0; p += 0.01) {
                __block NSNumber *v;
                [[theBlock(^{
                    v = [gen valueWithProgress:p];
                }) shouldNot] raise];
                [[theValue(strcmp([v objCType], @encode(double))==0) should] beYes];
            }
        });
    });
});

SPEC_END
