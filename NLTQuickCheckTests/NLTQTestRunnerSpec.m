//
//  NLTQuickCheck - NLTQTestRunnerSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQTestRunner.h"

SPEC_BEGIN(NLTQTestRunnerSpec)

describe(@"Test Runner", ^{
    context(@"all successful test case", ^{
        __block NLTQTestRunner *testRunner;
        __block int runCounter;
        beforeEach(^{
            runCounter = 0;
            NLTQTestCase *testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments0:^BOOL{
                runCounter++;
                return YES;
            }];
            testRunner = [NLTQTestRunner testRunnerWithTestCase:testCase];
        });
        context(@"and run 100 cases", ^{
            __block NSArray *reports;
            beforeEach(^{
                [testRunner setTestLength:100];
                [testRunner runWithVerbose:NO reports:&reports];
            });
            
            it(@"when should 100 executed", ^{
                [[theValue(runCounter) should] equal:theValue(100)];
            });
            
            it(@"when should has 100 success reports", ^{
                [[theValue([reports count]) should] equal:theValue(100)];
                for(NLTQReport *report in reports) {
                    [[theValue(report.success) should] beYes];
                }
            });
        });
        
        context(@"and run 10 cases", ^{
            __block NSArray *reports;
            beforeEach(^{
                [testRunner setTestLength:10];
                [testRunner runWithVerbose:NO reports:&reports];
            });
            
            it(@"when should 10 executed", ^{
                [[theValue(runCounter) should] equal:theValue(10)];
            });
            
            it(@"when should has 10 success reports", ^{
                [[theValue([reports count]) should] equal:theValue(10)];
                for(NLTQReport *report in reports) {
                    [[theValue(report.success) should] beYes];
                }
            });
        });
        
    });
    

});

SPEC_END
