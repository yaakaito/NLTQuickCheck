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
    
        it(@"when should has success", ^{
            [[theValue(report.success) should] beYes];
        });
        
        it(@"when should has needsRetry", ^{
            [[theValue(report.success) should] beYes];
        });
        
        it(@"when should has retryCounter", ^{
            [[theValue(report.retryCounter) should] equal:theValue(10)];
        });
        
        it(@"when should has isException", ^{
            [[theValue(report.isException) should] beYes];
        });
        
        it(@"when should has arguments", ^{
            [[report.arguments should] beKindOfClass:[NSArray class]];
        });
    });
    
    context(@"localizedDescription", ^{
        context(@"success", ^{
            it(@"when none arguments should equal `✓ Success : ()`", ^{
                report = [NLTQReport reportWithSuccess:YES needsRetry:NO retryCounter:0 isException:0 arguments:nil];
                [[[report localizedDescription] should] equal:@"✓ Success : ()"];
            });
        });
        
    });
});

SPEC_END
