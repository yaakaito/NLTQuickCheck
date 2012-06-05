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
    
    context(@"failure at 3rd , 4th and 5th test case", ^{
        __block NLTQTestRunner *testRunner;
        __block int runCounter;
        beforeEach(^{
            runCounter = 0;
            NLTQTestCase *testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments0:^BOOL{
                runCounter++;
                if(runCounter == 3 || runCounter == 4 || runCounter == 5) {
                    return NO;
                }
                return YES;
            }];
            testRunner = [NLTQTestRunner testRunnerWithTestCase:testCase];
        });
        
        context(@"and run 6 cases ", ^{
            __block NSArray *reports;
            beforeEach(^{
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
            
            it(@"when should 6th report is success", ^{
                [[theValue([[reports objectAtIndex:5] success]) should] beYes];
            });
        });
    });
    
    context(@"throws exception at 3rd test case", ^{
        __block NLTQTestRunner *testRunner;
        __block int runCounter;
        beforeEach(^{
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
            beforeEach(^{
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
