//
//  NLTQuickCheck - NLTQTestRunnerSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQTestRunner.h"
#import "NLTQGen.h"

SPEC_BEGIN(NLTQTestRunnerSpec)

describe(@"Test Runner", ^{
    context(@"all successful test case", ^{
        __block NLTQTestRunner *testRunner;
        __block int runCounter;
        beforeAll(^{
            runCounter = 0;
            NLTQTestCase *testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments0:^BOOL{
                runCounter++;
                return YES;
            }];
            testRunner = [NLTQTestRunner testRunnerWithTestCase:testCase];
        });
        context(@"and run 100 cases", ^{
            __block NSArray *reports;
            beforeAll(^{
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
    
    context(@"failure at 3rd , 4th and 5th test case", ^{
        __block NLTQTestRunner *testRunner;
        __block int runCounter;
        __block NSMutableArray *failureArgsArray;
        beforeAll(^{
            runCounter = 0;
            failureArgsArray = [NSMutableArray arrayWithCapacity:3];
            NLTQTestCase *testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments2:^BOOL(id argA, id argB) {
                runCounter++;
                if(runCounter == 3 || runCounter == 4 || runCounter == 5){
                    [failureArgsArray addObject:[NSArray arrayWithObjects:argA, argB, nil]];
                    return NO;
                }
                return YES;
            } arbitraries:[NSArray arrayWithObjects:[NLTQGen chooseGenWithLow:0 high:10], [NLTQGen chooseGenWithLow:0 high:10], nil]];
            testRunner = [NLTQTestRunner testRunnerWithTestCase:testCase];
        });
        
        context(@"and run 6 cases ", ^{
            __block NSArray *reports;
            beforeAll(^{
                [testRunner setTestLength:6];
                [testRunner runWithVerbose:NO reports:&reports];
            });
            
            it(@"when should 6 executed", ^{
                [[theValue(runCounter) should] equal:theValue(6)];
            });
            
            it(@"when should has 6 reports", ^{
                [[theValue([reports count]) should] equal:theValue(6)];
            });
            
            it(@"when should 1st report and 2nd report are success", ^{
                [[theValue([[reports objectAtIndex:0] success]) should] beYes];
                [[theValue([[reports objectAtIndex:1] success]) should] beYes];
            });
            
            it(@"when should 3rd report is failure (needsRetry=YES,retryCount=0,isException=NO)", ^{
                [[theValue([[reports objectAtIndex:2] success]) should] beNo];
                [[theValue([[reports objectAtIndex:2] isException]) should] beNo];
                [[theValue([[reports objectAtIndex:2] needsRetry]) should] beYes];
            });
            
            it(@"when should 4th report is failure (needsRetry=YES,retryCount=1,isException=NO)", ^{
                [[theValue([[reports objectAtIndex:3] success]) should] beNo];
                [[theValue([[reports objectAtIndex:3] isException]) should] beNo];
                [[theValue([[reports objectAtIndex:3] needsRetry]) should] beYes];
                [[theValue([[reports objectAtIndex:3] retryCounter]) should] equal:theValue(1)];
            });

            it(@"when should 5th report is failure (needsRetry=NO,retryCount=2,isException=NO)", ^{
                [[theValue([[reports objectAtIndex:4] success]) should] beNo];
                [[theValue([[reports objectAtIndex:4] isException]) should] beNo];
                [[theValue([[reports objectAtIndex:4] needsRetry]) should] beNo];
                [[theValue([[reports objectAtIndex:4] retryCounter]) should] equal:theValue(2)];
            });
                
            it(@"when equals 3rd, 4th and 5th arguments", ^{
                [[theValue([failureArgsArray count]) should] equal:theValue(3)];
                NSNumber *argA_3 = [[failureArgsArray objectAtIndex:0] objectAtIndex:0];
                NSNumber *argB_3 = [[failureArgsArray objectAtIndex:0] objectAtIndex:1];
                NSNumber *argA_4 = [[failureArgsArray objectAtIndex:1] objectAtIndex:0];
                NSNumber *argB_4 = [[failureArgsArray objectAtIndex:1] objectAtIndex:1];
                NSNumber *argA_5 = [[failureArgsArray objectAtIndex:2] objectAtIndex:0];
                NSNumber *argB_5 = [[failureArgsArray objectAtIndex:2] objectAtIndex:1];
                [[theValue([argA_3 intValue]) should] equal:theValue([argA_4 intValue])];
                [[theValue([argA_3 intValue]) should] equal:theValue([argA_5 intValue])];
                [[theValue([argB_3 intValue]) should] equal:theValue([argB_4 intValue])];
                [[theValue([argB_3 intValue]) should] equal:theValue([argB_5 intValue])];
            });
            
            it(@"when should 6th report is success", ^{
                [[theValue([[reports objectAtIndex:5] success]) should] beYes];
            });
        });
    });
    
    context(@"throws exception at 3rd test case", ^{
        __block NLTQTestRunner *testRunner;
        __block int runCounter;
        beforeAll(^{
            runCounter = 0;
            NLTQTestCase *testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments0:^BOOL{
                runCounter++;
                if(runCounter == 3) {
                    @throw [NSException exceptionWithName:@"dummy exception" reason:@"test" userInfo:nil];
                }
                return YES;
            }];
            testRunner = [NLTQTestRunner testRunnerWithTestCase:testCase];
        });
        
        context(@"and run 4 cases (retry case)", ^{
            __block NSArray *reports;
            beforeAll(^{
                [testRunner setTestLength:4];
                [testRunner runWithVerbose:NO reports:&reports];
            });
            
            it(@"when should 4 executed", ^{
                [[theValue(runCounter) should] equal:theValue(4)];
            });
            
            it(@"when should has 4 reports", ^{
                [[theValue([reports count]) should] equal:theValue(4)];
            });
            
            it(@"when should 1st report and 2nd report are success", ^{
                [[theValue([[reports objectAtIndex:0] success]) should] beYes];
                [[theValue([[reports objectAtIndex:1] success]) should] beYes];
            });
            
            it(@"when should 3rd report is failure (isException=YES, needsRetry=NO)", ^{
                [[theValue([[reports objectAtIndex:2] success]) should] beNo];
                [[theValue([[reports objectAtIndex:2] isException]) should] beYes];
                [[theValue([[reports objectAtIndex:2] needsRetry]) should] beNo];
            });
            
            it(@"when should 4th report is success", ^{
                [[theValue([[reports objectAtIndex:3] success]) should] beYes];
            });
        });
    });
    
});

SPEC_END
