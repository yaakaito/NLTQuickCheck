//
//  NLTQuickCheck - NLTQBlocksTestCaseSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQGen.h"
#import "NLTQTestCase.h"

SPEC_BEGIN(NLTQBlocksTestCaseSpec)

describe(@"blocks test case", ^{
    __block NLTQGen *gen;
    __block NLTQTestCase *testCase;
    __block int counter;
    beforeAll(^{
        gen = [NLTQGen elementsGenWithArray:[NSArray arrayWithObject:[NSNumber numberWithBool:YES]]];
        counter = 0;
    });
    
    context(@"arguments 0 blocks and return YES property", ^{
        beforeEach(^{
            testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments0:^BOOL{
                counter++;
                return YES;
            }];
        });
        
        it(@"when NLTQTestCase object", ^{
            [[testCase should] beKindOfClass:[NLTQTestCase class]];
        });
        
        it(@"when reports must success", ^{
            for(int i = 0; i < 100; i++) {
                NLTQReport *report = [testCase checkWithTestCount:i testLength:100];
                [[report should] beKindOfClass:[NLTQReport class]];
                [[theValue([report success]) should] beYes];
                [[theValue([report needsRetry]) should] beNo];
                [[theValue([report retryCounter]) should] equal:theValue(0)];
                [[theValue([report isException]) should] beNo];
            }
            [[theValue(counter) should] equal:theValue(100)];
        });
        
    });
    
    context(@"arguments 1 blocks and return A property", ^{
        beforeEach(^{
            testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments1:^BOOL(id argA) {
                counter++;
                return [argA boolValue];
            } arbitraries:[NSArray arrayWithObjects:gen, nil]];
        });
        
        it(@"when NLTQTestCase object", ^{
            [[testCase should] beKindOfClass:[NLTQTestCase class]];
        });
        
        it(@"when reports must success", ^{
            for(int i = 0; i < 100; i++) {
                NLTQReport *report = [testCase checkWithTestCount:i testLength:100];
                [[report should] beKindOfClass:[NLTQReport class]];
                [[theValue([report success]) should] beYes];
                [[theValue([report needsRetry]) should] beNo];
                [[theValue([report retryCounter]) should] equal:theValue(0)];
                [[theValue([report isException]) should] beNo];
            }
            [[theValue(counter) should] equal:theValue(100)];
        });
    });
    
    context(@"arguments 2 blocks and return A && B property", ^{
        beforeEach(^{
            testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments2:^BOOL(id argA, id argB) {
                counter++;
                return [argA boolValue] && [argB boolValue];
            } arbitraries:[NSArray arrayWithObjects:gen, gen, nil]];
        });
        
        it(@"when NLTQTestCase object", ^{
            [[testCase should] beKindOfClass:[NLTQTestCase class]];
        });
        
        it(@"when reports must success", ^{
            for(int i = 0; i < 100; i++) {
                NLTQReport *report = [testCase checkWithTestCount:i testLength:100];
                [[report should] beKindOfClass:[NLTQReport class]];
                [[theValue([report success]) should] beYes];
                [[theValue([report needsRetry]) should] beNo];
                [[theValue([report retryCounter]) should] equal:theValue(0)];
                [[theValue([report isException]) should] beNo];
            }
            [[theValue(counter) should] equal:theValue(100)];
        });
    });
    
    context(@"arguments 3 blocks and return A && B && C property", ^{
        beforeEach(^{
            testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments3:^BOOL(id argA, id argB, id argC) {
                counter++;
                return [argA boolValue] && [argB boolValue] && [argC boolValue];
            } arbitraries:[NSArray arrayWithObjects:gen, gen, gen, nil]];
        });
        
        it(@"when NLTQTestCase object", ^{
            [[testCase should] beKindOfClass:[NLTQTestCase class]];
        });
        
        it(@"when reports must success", ^{
            for(int i = 0; i < 100; i++) {
                NLTQReport *report = [testCase checkWithTestCount:i testLength:100];
                [[report should] beKindOfClass:[NLTQReport class]];
                [[theValue([report success]) should] beYes];
                [[theValue([report needsRetry]) should] beNo];
                [[theValue([report retryCounter]) should] equal:theValue(0)];
                [[theValue([report isException]) should] beNo];
            }
            [[theValue(counter) should] equal:theValue(100)];
        });
    });  
    
    context(@"arguments 4 blocks and return A && B && C && D property", ^{
        beforeEach(^{
            testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments4:^BOOL(id argA, id argB, id argC, id argD) {
                counter++;
                return [argA boolValue] && [argB boolValue] && [argC boolValue] && [argD boolValue];
            } arbitraries:[NSArray arrayWithObjects:gen, gen, gen, gen, nil]];
        });
        
        it(@"when NLTQTestCase object", ^{
            [[testCase should] beKindOfClass:[NLTQTestCase class]];
        });
        
        it(@"when reports must success", ^{
            for(int i = 0; i < 100; i++) {
                NLTQReport *report = [testCase checkWithTestCount:i testLength:100];
                [[report should] beKindOfClass:[NLTQReport class]];
                [[theValue([report success]) should] beYes];
                [[theValue([report needsRetry]) should] beNo];
                [[theValue([report retryCounter]) should] equal:theValue(0)];
                [[theValue([report isException]) should] beNo];
            }
            [[theValue(counter) should] equal:theValue(100)];
        });
    });  
    
    context(@"arguments 5 blocks and return A && B && C && D && E property", ^{
        beforeEach(^{
            testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments5:^BOOL(id argA, id argB, id argC, id argD, id argE) {
                counter++;
                return [argA boolValue] && [argB boolValue] && [argC boolValue] && [argD boolValue] && [argE boolValue];
            } arbitraries:[NSArray arrayWithObjects:gen, gen, gen, gen, gen, nil]];
        });
        
        it(@"when NLTQTestCase object", ^{
            [[testCase should] beKindOfClass:[NLTQTestCase class]];
        });
        
        it(@"when reports must success", ^{
            for(int i = 0; i < 100; i++) {
                NLTQReport *report = [testCase checkWithTestCount:i testLength:100];
                [[report should] beKindOfClass:[NLTQReport class]];
                [[theValue([report success]) should] beYes];
                [[theValue([report needsRetry]) should] beNo];
                [[theValue([report retryCounter]) should] equal:theValue(0)];
                [[theValue([report isException]) should] beNo];
            }
            [[theValue(counter) should] equal:theValue(100)];
        });
    });  
    
    context(@"arguments 6 blocks and return A && B && C && D && E && F property", ^{
        beforeEach(^{
            testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments6:^BOOL(id argA, id argB, id argC, id argD, id argE, id argF) {
                counter++;
                return [argA boolValue] && [argB boolValue] && [argC boolValue] && [argD boolValue] && [argE boolValue] && [argF boolValue];
            } arbitraries:[NSArray arrayWithObjects:gen, gen, gen, gen, gen, gen, nil]];
        });
        
        it(@"when NLTQTestCase object", ^{
            [[testCase should] beKindOfClass:[NLTQTestCase class]];
        });
        
        it(@"when reports must success", ^{
            for(int i = 0; i < 100; i++) {
                NLTQReport *report = [testCase checkWithTestCount:i testLength:100];
                [[report should] beKindOfClass:[NLTQReport class]];
                [[theValue([report success]) should] beYes];
                [[theValue([report needsRetry]) should] beNo];
                [[theValue([report retryCounter]) should] equal:theValue(0)];
                [[theValue([report isException]) should] beNo];
            }
            [[theValue(counter) should] equal:theValue(100)];
        });
    });  
    
    context(@"arguments 7 blocks and return A && B && C && D && E && F && G property", ^{
        beforeEach(^{
            testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments7:^BOOL(id argA, id argB, id argC, id argD, id argE, id argF, id argG) {
                counter++;
                return [argA boolValue] && [argB boolValue] && [argC boolValue] && [argD boolValue] && [argE boolValue] && [argF boolValue] && [argG boolValue];
            } arbitraries:[NSArray arrayWithObjects:gen, gen, gen, gen, gen, gen, gen, nil]];
        });
        
        it(@"when NLTQTestCase object", ^{
            [[testCase should] beKindOfClass:[NLTQTestCase class]];
        });
        
        it(@"when reports must success", ^{
            for(int i = 0; i < 100; i++) {
                NLTQReport *report = [testCase checkWithTestCount:i testLength:100];
                [[report should] beKindOfClass:[NLTQReport class]];
                [[theValue([report success]) should] beYes];
                [[theValue([report needsRetry]) should] beNo];
                [[theValue([report retryCounter]) should] equal:theValue(0)];
                [[theValue([report isException]) should] beNo];
            }
            [[theValue(counter) should] equal:theValue(100)];
        });
    });  
    
    context(@"arguments 8 blocks and return A && B && C && D && E && F && G && H property", ^{
        beforeEach(^{
            testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments8:^BOOL(id argA, id argB, id argC, id argD, id argE, id argF, id argG, id argH) {
                counter++;
                return [argA boolValue] && [argB boolValue] && [argC boolValue] && [argD boolValue] && [argE boolValue] && [argF boolValue] && [argG boolValue] && [argH boolValue];
            } arbitraries:[NSArray arrayWithObjects:gen, gen, gen, gen, gen, gen, gen, gen, nil]];
        });
        
        it(@"when NLTQTestCase object", ^{
            [[testCase should] beKindOfClass:[NLTQTestCase class]];
        });
        
        it(@"when reports must success", ^{
            for(int i = 0; i < 100; i++) {
                NLTQReport *report = [testCase checkWithTestCount:i testLength:100];
                [[report should] beKindOfClass:[NLTQReport class]];
                [[theValue([report success]) should] beYes];
                [[theValue([report needsRetry]) should] beNo];
                [[theValue([report retryCounter]) should] equal:theValue(0)];
                [[theValue([report isException]) should] beNo];
            }
            [[theValue(counter) should] equal:theValue(100)];
        });
    });   
});

SPEC_END
