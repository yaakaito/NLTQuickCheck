//
//  NLTQuickCheck - NLTQReportSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQReport.h"

SPEC_BEGIN(NLTQReportSpec)

describe(@"Report", ^{
    __block NLTQReport *report;
    context(@"properties", ^{
        beforeEach(^{
            report = [NLTQReport reportWithSuccess:YES needsRetry:YES retryCounter:10 isException:YES arguments:[NSArray array]];
        });
    
        it(@"should has success", ^{
            [[theValue(report.success) should] beYes];
        });
        
        it(@"should has needsRetry", ^{
            [[theValue(report.success) should] beYes];
        });
        
        it(@"should has retryCounter", ^{
            [[theValue(report.retryCounter) should] equal:theValue(10)];
        });
        
        it(@"should has isException", ^{
            [[theValue(report.isException) should] beYes];
        });
        
        it(@"should has arguments", ^{
            [[report.arguments should] beKindOfClass:[NSArray class]];
        });
    });
    
    context(@"localizedDescription", ^{
        context(@"success", ^{
            it(@"when none arguments should equal '✓ Success : ()'", ^{
                report = [NLTQReport reportWithSuccess:YES
                                            needsRetry:NO
                                          retryCounter:0
                                           isException:NO
                                             arguments:nil];
                [[[report localizedDescription] should] equal:@"✓ Success : ( )"];
            });
            
            it(@"when 1 non number object, should equal '✓ Success : ( object.description )'", ^{
                report = [NLTQReport reportWithSuccess:YES
                                            needsRetry:NO
                                          retryCounter:0
                                           isException:NO
                                             arguments:[NSArray arrayWithObjects:[NSString stringWithFormat:@"string"], nil]];
                [[[report localizedDescription] should] equal:@"✓ Success : ( string )"];
            });

            it(@"when 2 bool arguments, should equal '✓ Success : ( BOOL , BOOL )'", ^{
                report = [NLTQReport reportWithSuccess:YES
                                            needsRetry:NO
                                          retryCounter:0
                                           isException:NO
                                             arguments:[NSArray arrayWithObjects:[NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO], nil]];
                [[[report localizedDescription] should] equal:@"✓ Success : ( YES , NO )"];
            });

            it(@"when 3 int arguments, should equal '✓ Success : ( int , int , int )'", ^{
                report = [NLTQReport reportWithSuccess:YES
                                            needsRetry:NO 
                                          retryCounter:0 
                                           isException:NO
                                             arguments:[NSArray arrayWithObjects:[NSNumber numberWithInt:10], [NSNumber numberWithInt:20], [NSNumber numberWithInt:30], nil]];
                [[[report localizedDescription] should] equal:@"✓ Success : ( 10 , 20 , 30 )"];
            });
            
            
            it(@"when 4 number arguments, should equal '✓ Success : ( number , number , number , number )'", ^{
                report = [NLTQReport reportWithSuccess:YES
                                            needsRetry:NO 
                                          retryCounter:0
                                           isException:NO
                                             arguments:[NSArray arrayWithObjects:[NSNumber numberWithDouble:1.1],[NSNumber numberWithDouble:2.2],[NSNumber numberWithDouble:3.3],[NSNumber numberWithDouble:4.4], nil]];
                [[[report localizedDescription] should] equal:@"✓ Success : ( 1.1 , 2.2 , 3.3 , 4.4 )"];
            });
        
            // Bug !!!!
            it(@"when 2 equal number arugments, should equal '✓ Success : ( number , number )'", ^{
                report = [NLTQReport reportWithSuccess:YES
                                            needsRetry:NO
                                          retryCounter:0
                                           isException:NO
                                             arguments:[NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]];
                [[[report localizedDescription] should] equal:@"✓ Success : ( 0 , 0 )"];
            });
            
            // Bug !!!!
            it(@"when 2 equal number arugments, should equal '✓ Success : ( number , number , number )'", ^{
                report = [NLTQReport reportWithSuccess:YES
                                            needsRetry:NO
                                          retryCounter:0
                                           isException:NO
                                             arguments:[NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1], nil]];
                [[[report localizedDescription] should] equal:@"✓ Success : ( 1 , 1, 1 )"];
            });

        });
        
        context(@"failure", ^{
            it(@"when 1 non number object, should equal '✗ Failure : ( object.description )'", ^{
                report = [NLTQReport reportWithSuccess:NO
                                            needsRetry:YES
                                          retryCounter:0
                                           isException:NO
                                             arguments:[NSArray arrayWithObjects:[NSString stringWithFormat:@"string"], nil]];
                [[[report localizedDescription] should] equal:@"✗ Failure : ( string )"];
            });
            
        });
        
        context(@"exception", ^{
            it(@"when 1 non number object, should equal '✷ Exceptions : ( object.description )'", ^{
                report = [NLTQReport reportWithSuccess:NO
                                            needsRetry:NO
                                          retryCounter:0
                                           isException:YES
                                             arguments:[NSArray arrayWithObjects:[NSString stringWithFormat:@"string"], nil]];
                [[[report localizedDescription] should] equal:@"✷ Exceptions : ( string )"];
            });
            
        });

    });
});

SPEC_END
