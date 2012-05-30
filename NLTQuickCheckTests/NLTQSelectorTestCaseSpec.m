//
//  NLTQuickCheck - NLTQSelectorTestCaseSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQTestCase.h"

@interface SelectorTestCase : NSObject
- (BOOL)propReturnYES;
@end

@implementation SelectorTestCase
- (BOOL)propReturnYES {
    return YES;
}
@end

SPEC_BEGIN(NLTQSelectorTestCaseSpec)

describe(@"selector test case", ^{
    __block NLTQTestCase *testCase;
    context(@"with prop return fixed YES and none arbitraries", ^{
        
        beforeEach(^{
            testCase = [NLTQTestCase selectorTestCaseWithSelector:@selector(propReturnYES) arbitraries:nil];
        });

        it(@"when NLTQTestCase object", ^{
            [[testCase should] beKindOfClass:[NLTQTestCase class]];
        });
        
        it(@"when check fully success", ^{
            for(int i = 0; i < 100; i ++) {
                NLTQReport *report = [testCase checkWithTestCount:i testLength:100];
                [[theValue([report successs]) should] beYes];
                [[theValue([report needsRetry]) should] beNo];
                [[theValue([report retryCounter]) should] beZero];
                [[theValue([report isException]) should] beNo];
            }
        });
       
    });
    
});

SPEC_END
