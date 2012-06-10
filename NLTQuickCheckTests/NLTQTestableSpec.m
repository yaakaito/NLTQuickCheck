//
//  NLTQuickCheck - NLTQTestable.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQuickCheck.h"

@interface NLTQTestable()
@property(nonatomic, strong) NLTQTestRunner *runner;
@property(nonatomic, strong) NLTQReportManager *reportManager;
@end

SPEC_BEGIN(NLTQTestableSpec)

describe(@"Testable", ^{
    __block NLTQTestable *testable;
    context(@"when use bool arbitries and YES fixed property", ^{
        beforeAll(^{
            testable = [NLTQTestable testableWithPropertyBlockArguments2:^BOOL(id argA, id argB) {
                return YES;
            } arbitraries:[NSNumber boolArbitrary], [NSNumber boolArbitrary], nil];
            [testable check];
        });
        
        it(@"should has 100 success reports", ^{
            [[theValue([testable.reportManager.successReports count]) should] equal:theValue(100)];
        });
        
        it(@"should failureReports be empty ", ^{
            [[testable.reportManager.successReports should] beEmpty];
        });
        
        it(@"should exceptionReports be empty", ^{
            [[testable.reportManager.exceptionReports should] beEmpty];
        });
    });
});

SPEC_END
