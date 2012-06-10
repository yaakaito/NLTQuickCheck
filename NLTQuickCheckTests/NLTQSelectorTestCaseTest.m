//
//  NLTQSelectorTestCaseTest.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NLTQTestCase.h"
#import "NLTQGen.h"
@interface NLTQSelectorTestCaseTest : SenTestCase

@end


@implementation NLTQSelectorTestCaseTest

- (BOOL)propReturnYES {
    return YES;
}

- (BOOL)propReturnNo:(NSNumber*)arg1 {
    STAssertTrue([arg1 boolValue], @"arg1 is not YES");
    return NO;
}

- (BOOL)propThrowException {
    @throw [NSException exceptionWithName:@"dummy" reason:@"test" userInfo:nil];
    return NO;
}

- (void)testTestCaseObject {
    NLTQTestCase *testCase = [NLTQTestCase selectorTestCaseWithSelector:@selector(propReturnYES) target:self arbitraries:[NSArray array]];
    STAssertTrue([testCase isKindOfClass:[NLTQTestCase class]], @"testCase is `NLTQTestCase object`.");
}

- (void)testRetrunNOCheckWtihNoneArbitrary {
    NLTQTestCase *testCase = [NLTQTestCase selectorTestCaseWithSelector:@selector(propReturnNo:) target:self arbitraries:[NSArray arrayWithObject:[NLTQGen elementsGenWithObjects:[NSNumber numberWithBool:YES], nil]]];
    for (int i = 0; i < 100; i++) {
        NLTQReport *report = [testCase checkWithTestCount:i testLength:100];
        STAssertTrue([report isKindOfClass:[NLTQReport class]], @"return `NLTQReport object`.");
        STAssertFalse([report success], @"fixed failure");
        STAssertTrue([report needsRetry], @"fixed needs retry");
        STAssertEquals(0, [report retryCounter], @"fixed retry count 0");
        STAssertFalse([report isException], @"fixed none exception");
    }
}

- (void)testRetrunNOCheckWtihOneArbitrary {
    NLTQTestCase *testCase = [NLTQTestCase selectorTestCaseWithSelector:@selector(propReturnNo:) target:self arbitraries:[NSArray arrayWithObject:[NLTQGen elementsGenWithObjects:[NSNumber numberWithBool:YES], nil]]];
    for (int i = 0; i < 100; i++) {
        NLTQReport *report = [testCase checkWithTestCount:i testLength:100];
        STAssertTrue([report isKindOfClass:[NLTQReport class]], @"return `NLTQReport object`.");
        STAssertFalse([report success], @"fixed failure");
        STAssertTrue([report needsRetry], @"fixed needs retry");
        STAssertEquals(0, [report retryCounter], @"fixed retry count 0");
        STAssertFalse([report isException], @"fixed none exception");
    }
}

- (void)testThrowExceptionCheckWtihNoneArbitrary {
    NLTQTestCase *testCase = [NLTQTestCase selectorTestCaseWithSelector:@selector(propThrowException) target:self arbitraries:[NSArray array]];
    for (int i = 0; i < 100; i++) {
        NLTQReport *report = [testCase checkWithTestCount:i testLength:100];
        STAssertTrue([report isKindOfClass:[NLTQReport class]], @"return `NLTQReport object`.");
        STAssertFalse([report success], @"fixed exception");
        STAssertFalse([report needsRetry], @"fixed not needs retry");
        STAssertEquals(0, [report retryCounter], @"fixed retry count 0");
        STAssertTrue([report isException], @"fixed raise exception");
    }
}
@end
