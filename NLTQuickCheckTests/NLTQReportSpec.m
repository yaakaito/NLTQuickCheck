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
            report = [NLTQReport reportWithSuccess:YES needsRetry:YES retryCounter:10 isException:YES];
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
    });
});

SPEC_END
