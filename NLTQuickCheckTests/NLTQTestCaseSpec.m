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
- (BOOL)isSkipCase:(NSArray*)gens;
@end

SPEC_BEGIN(NLTQTestCaseSpec)

describe(@"TestCaseSpec", ^{
    __block NLTQGen *gen;
    __block NLTQGen *skipGen;
    beforeAll(^{
        gen = [NLTQGen elementsGenWithArray:[NSArray arrayWithObject:[NSNumber numberWithBool:YES]]];
        skipGen = [[NLTQGen genWithGenerateBlock:^id(double progress, int random) {
            return nil;
        }] andSkipCaseBlock:^BOOL(id value) {
            return YES;
        }];
    });
    
    context(@"checkWithTestCount:testLength: with return YES(fixed) gen", ^{
        __block NLTQTestCase *testCase;
        beforeEach(^{
            testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments1:^BOOL(id argA) {
                return [argA boolValue];
            } arbitraries:[NSArray arrayWithObjects:gen, nil]];
        });
        
        context(@"support method gensRealize:", ^{
            
            it(@"should return array [YES]", ^{
                NSArray *args = [testCase gensRealize:0.0];
                [[theValue([args count]) should] equal:theValue(1)];
                NSNumber *argA = [args objectAtIndex:0];
                [[theValue([argA boolValue]) should] beYes];
            });
            
            context(@"when contains skip gen", ^{
                beforeEach(^{
                    testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments2:^BOOL(id argA, id argB) {
                        return YES;
                    } arbitraries:[NSArray arrayWithObjects:gen,skipGen, nil]];
                });
                
                it(@"should return nil", ^{
                    NSArray *args = [testCase gensRealize:0.0];
                    [[theValue(args == nil) should] beYes];
                });
            });
        });        
        it(@"should report success flag = YES", ^{
            NLTQReport *report = [testCase checkWithTestCount:0 testLength:100];
            [[theValue(report.success) should] beYes];
        });
        
        it(@"should report needs retry flag = NO", ^{
            NLTQReport *report = [testCase checkWithTestCount:0 testLength:100];
            [[theValue(report.needsRetry) should] beNo];
        });
        
        it(@"should report retry counter = 0", ^{
            NLTQReport *report = [testCase checkWithTestCount:0 testLength:100];
            [[theValue(report.retryCounter) should] equal:theValue(0)];
        });
        
        it(@"should report exception flag = NO", ^{
            NLTQReport *report = [testCase checkWithTestCount:0 testLength:100];
            [[theValue(report.isException) should] beNo];
        });
    });
    
    context(@"checkWithTestcount:testLength: with skip gen", ^{
        __block NLTQTestCase *testCase;
        beforeEach(^{
            testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments1:^BOOL(id argA) {
                return NO;
            } arbitraries:[NSArray arrayWithObjects:skipGen, nil]];
        });
        
        it(@"should report skip flag = YES", ^{
            NLTQReport *report = [testCase checkWithTestCount:0 testLength:100];
            [[theValue(report.skip) should] beYes];
        });
    });
    
    context(@"checkWithTestCount:testLength: with return NO(fixed) gen", ^{
        __block NLTQTestCase *testCase;
        beforeEach(^{
            testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments1:^BOOL(id argA) {
                return NO;
            } arbitraries:[NSArray arrayWithObjects:gen, nil]];
        });
        
        it(@"should report success flag = NO", ^{
            NLTQReport *report = [testCase checkWithTestCount:0 testLength:100];
            [[theValue(report.success) should] beNo];
        });
        
        it(@"should report needs retry flag = YES", ^{
            NLTQReport *report = [testCase checkWithTestCount:0 testLength:100];
            [[theValue(report.needsRetry) should] beYes];
        });
        
        it(@"should report retry counter = 0", ^{
            NLTQReport *report = [testCase checkWithTestCount:0 testLength:100];
            [[theValue(report.retryCounter) should] equal:theValue(0)];
        });
        
        it(@"should report exception flag = NO", ^{
            NLTQReport *report = [testCase checkWithTestCount:0 testLength:100];
            [[theValue(report.isException) should] beNo];
        });
    });
    
    context(@"checkWithTestCount:testLenght: with throw exception generator", ^{
        __block NLTQTestCase *testCase;
        beforeEach(^{
            testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments0:^BOOL{
                @throw [NSException exceptionWithName:@"dummy exception" reason:@"test" userInfo:nil];
            }];
        });
        
        it(@"should report success flag = NO", ^{
            NLTQReport *report = [testCase checkWithTestCount:0 testLength:100];
            [[theValue(report.success) should] beNo];
        });
        
        it(@"should report needs retry flag = NO", ^{
            NLTQReport *report = [testCase checkWithTestCount:0 testLength:100];
            [[theValue(report.needsRetry) should] beNo];
        });
        
        it(@"should report retry counter = 0", ^{
            NLTQReport *report = [testCase checkWithTestCount:0 testLength:100];
            [[theValue(report.retryCounter) should] equal:theValue(0)];
        });
        
        it(@"should reports exception flag = YES", ^{
            NLTQReport *report = [testCase checkWithTestCount:0 testLength:100];
            [[theValue(report.isException) should] beYes];
        });
    });
    
});

SPEC_END
