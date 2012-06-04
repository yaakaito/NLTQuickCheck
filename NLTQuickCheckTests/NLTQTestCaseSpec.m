//
//  NLTQuickCheck - NLTQTestCaseSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQGen.h"
#import "NLTQTestCase.h"

@interface NLTQTestCase(Privates)
- (NSArray*)gensRealize:(double)progress;
@end

SPEC_BEGIN(NLTQTestCaseSpec)

describe(@"TestCaseSpec", ^{
    __block NLTQGen *gen;
    beforeAll(^{
        gen = [NLTQGen elementsGenWithArray:[NSArray arrayWithObject:[NSNumber numberWithBool:YES]]];
    });
    
    context(@"checkWithTestCount:testLength: with return YES(fixed) gen", ^{
        __block NLTQTestCase *testCase;
        beforeEach(^{
            testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments1:^BOOL(id argA) {
                return [argA boolValue];
            } arbitraries:[NSArray arrayWithObjects:gen, nil]];
        });
        
        context(@"supper method gensRealize:", ^{
            
            it(@"when return array [YES]", ^{
                NSArray *args = [testCase gensRealize:0.0];
                [[theValue([args count]) should] equal:theValue(1)];
                NSNumber *argA = [args objectAtIndex:0];
                [[theValue([argA boolValue]) should] beYes];
            });
        });
        
        
    });
    
});

SPEC_END
