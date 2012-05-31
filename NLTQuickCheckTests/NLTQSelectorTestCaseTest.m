//
//  NLTQSelectorTestCaseTest.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NLTQTestCase.h"

@interface NLTQSelectorTestCaseTest : SenTestCase

@end


@implementation NLTQSelectorTestCaseTest

- (BOOL)propReturnYES {
    return YES;
}

- (void)testTestCaseObject {
    NLTQTestCase *testCase = [NLTQTestCase selectorTestCaseWithSelector:@selector(propReturnYES) arbitraries:[NSArray array]];
    STAssertTrue([testCase isKindOfClass:[NLTQTestCase class]], @"testCase is `NLTQTestCase object`.");
}

- (void)testRetrunYESCheckWtihNoneArbitrary {
    NLTQTestCase *testCase = [NLTQTestCase selectorTestCaseWithSelector:@selector(propReturnYES) arbitraries:[NSArray array]];
    for (int i = 0; i < 100; i++) {
        NLTQReport *report = [testCase checkWithTestCount:i testLength:100];
        STAssertTrue([report isKindOfClass:[NLTQReport class]], @"return `NLTQReport object`.");
        STAssertTrue([report successs], @"fixed success");
        STAssertFalse([report needsRetry], @"fixed not needs retry");
        STAssertEquals(0, [report retryCounter], @"fixed retry count 0");
        STAssertFalse([report isException], @"fixed none exception");
    }
}
@end
