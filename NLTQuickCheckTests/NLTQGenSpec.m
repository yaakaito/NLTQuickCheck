//
//  NLTQuickCheck - NLTQGenSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQGen.h"

SPEC_BEGIN(NLTQGenSpec)

describe(@"Gen(erator)", ^{
    __block NLTQGen *gen;
    context(@"create with fixation generater and return 'string'", ^{
        beforeEach(^{
            gen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
                return @"string";
            }];
        });
        
        it(@"at progress 0.1 , the value is 'string'(fixed)", ^{
            [[[gen valueWithProgress:0.1] should] equal:@"string"];
        });
        
        it(@"at progress 0.2 , the value is 'string'(fixed)", ^{
            [[[gen valueWithProgress:0.2] should] equal:@"string"];
        });
    });
    
    context(@"create with rebound generater and return progress", ^{
        beforeEach(^{
            gen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
                return [NSNumber numberWithDouble:progress];
            }];
        });
        
        it(@"at progress 0.0 , the value is 0.0 NSNumber object", ^{
            [[theValue([[gen valueWithProgress:0.0] doubleValue]) should] equal:theValue(0.0)];
        });
        
        it(@"at progress 0.5 , the value is 0.5 NSNumber object", ^{
            [[theValue([[gen valueWithProgress:0.5] doubleValue]) should] equal:theValue(0.5)];
        });
    });
});

SPEC_END
