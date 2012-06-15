//
//  NLTQuickCheck - NLTQStringArbitrarySpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQGen.h"
#import "NSString+Arbitrary.h"

SPEC_BEGIN(NLTQStringArbitrarySpec)

describe(@"string arbitrary", ^{
    __block NLTQGen *gen;
    beforeEach(^{
        gen = [NSString arbitrary];
    });
    
    it(@"should be NLTQGen object", ^{
        [[gen should] beKindOfClass:[NLTQGen class]];
    });
    
    it(@"should be value is NSString object", ^{
        [[[gen valueWithProgress:0] should] beKindOfClass:[NSString class]];
    });
    
    context(@"when run with double 0 ~ 1 progress", ^{
        it(@"should values string", ^{
            for(double p = 0.0; p < 1.0; p += 0.01) {
                __block NSString *v;
                [[theBlock(^{
                    v = [gen valueWithProgress:p];
                }) shouldNot] raise];
                [[v should] beKindOfClass:[NSString class]];
            }
        });
    });
});

describe(@"alphabet string arbitrary", ^{
    __block NLTQGen *gen;
    beforeEach(^{
        gen = [NSString alphabetStringArbitrary];
    });
    
    it(@"should be NLTQGen object", ^{
        [[gen should] beKindOfClass:[NLTQGen class]];
    });
    
    it(@"should be value is NSString object", ^{
        [[[gen valueWithProgress:0] should] beKindOfClass:[NSString class]];
    });
    
    context(@"when run with double 0 ~ 1 progress", ^{
        it(@"should values alphabet string", ^{
            for(double p = 0.0; p < 1.0; p += 0.01) {
                __block NSString *v;
                [[theBlock(^{
                    v = [gen valueWithProgress:p];
                }) shouldNot] raise];
                [[v should] beKindOfClass:[NSString class]];
                for(NSInteger i = 0; i < [v length]; i++) {
                    int asciiCode = [v characterAtIndex:i];
                    if(asciiCode >= 97) {
                        [[theValue(asciiCode) should] beBetween:theValue(97) and:theValue(122)];
                    }
                    else {
                        [[theValue(asciiCode) should] beBetween:theValue(65) and:theValue(90)];
                    }
                }
            }
        });
    });
});

SPEC_END
