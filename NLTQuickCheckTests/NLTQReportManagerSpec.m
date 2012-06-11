//
//  NLTQuickCheck - NLTQReportManagerSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQReportManager.h"

SPEC_BEGIN(NLTQReportManagerSpec)

describe(@"Report Manager", ^{
    __block NLTQReportManager *reportManager;
    beforeEach(^{
        reportManager = [NLTQReportManager reportManager];
    });
    
    it(@"should has successReports", ^{
        [[reportManager.successReports should] beKindOfClass:[NSMutableArray class]];
    });

    it(@"should has failureReports", ^{
        [[reportManager.failureReports should] beKindOfClass:[NSMutableArray class]];
    });

    it(@"should has exceptionReports", ^{
        [[reportManager.exceptionReports should] beKindOfClass:[NSMutableArray class]];
    });
    
    it(@"should has no reports, not success", ^{
        [[theValue([reportManager success]) should] beNo];
    }); 

    context(@"add success report", ^{
        beforeEach(^{
            NLTQReport *report = [NLTQReport reportWithSuccess:YES
                                                    needsRetry:NO
                                                  retryCounter:0
                                                   isException:NO
                                                     arguments:[NSArray array]];
            [reportManager addReport:report];
        });
        
        it(@"should successReports has 1 report object", ^{
            [[theValue([reportManager.successReports count]) should] equal:theValue(1)];
        });
        
        it(@"should failureReports and exceptionReports are empty", ^{
            [[theValue([reportManager.failureReports count]) should] beZero];
            [[theValue([reportManager.exceptionReports count]) should] beZero];
        });
        
        it(@"should success", ^{
            [[theValue([reportManager success]) should] beYes];
        });
        
        it(@"localizedDescription", ^{
            NSString *description = @"\
Tests: 1\n\
  ✓ Successes\t: 1\n\
  ✗ Failures\t: 0\n\
  ✷ Exceptions\t: 0";
            [[[reportManager localizedDescription] should] equal:description];
        });
    });

    context(@"add failure report", ^{
        beforeEach(^{
            NLTQReport *report = [NLTQReport reportWithSuccess:NO
                                                    needsRetry:YES
                                                  retryCounter:0
                                                   isException:NO
                                                     arguments:[NSArray array]];
            [reportManager addReport:report];
        });
        
        it(@"should failureReports has 1 report object", ^{
            [[theValue([reportManager.failureReports count]) should] equal:theValue(1)];
        });
        
        it(@"should successReports and exceptionReports are empty", ^{
            [[theValue([reportManager.successReports count]) should] beZero];
            [[theValue([reportManager.exceptionReports count]) should] beZero];
        });
        
        it(@"should not success", ^{
            [[theValue([reportManager success]) shouldNot] beYes];
        });
        
        it(@"localizedDescription", ^{
            NSString *description = @"\
Tests: 1\n\
  ✓ Successes\t: 0\n\
  ✗ Failures\t: 1\n\
    ✗ Failure : ( )\n\
  ✷ Exceptions\t: 0";
            [[[reportManager localizedDescription] should] equal:description];
        });
    });

    context(@"add exception report", ^{
        beforeEach(^{
            NLTQReport *report = [NLTQReport reportWithSuccess:NO
                                                    needsRetry:NO
                                                  retryCounter:0
                                                   isException:YES
                                                     arguments:[NSArray array]];
            [reportManager addReport:report];
        });
    
        it(@"should exceptionReports has 1 report object", ^{
            [[theValue([reportManager.exceptionReports count]) should] equal:theValue(1)];
        });
    
        it(@"should successReports and failureReports are empty", ^{
            [[theValue([reportManager.successReports count]) should] beZero];
            [[theValue([reportManager.failureReports count]) should] beZero];
        });
        
        it(@"should not success", ^{
            [[theValue([reportManager success]) shouldNot] beYes];
        });
        
        it(@"localizedDescription", ^{
            NSString *description = @"\
Tests: 1\n\
  ✓ Successes\t: 0\n\
  ✗ Failures\t: 0\n\
  ✷ Exceptions\t: 1\n\
    ✷ Exception : ( )";
            [[[reportManager localizedDescription] should] equal:description];
        });
    });
    
    context(@"add reports from array", ^{
        beforeEach(^{
            NLTQReport *success1 = [NLTQReport reportWithSuccess:YES needsRetry:NO retryCounter:0 isException:NO arguments:[NSArray arrayWithObject:@"hoge"]];
            NLTQReport *success2 = [NLTQReport reportWithSuccess:YES needsRetry:NO retryCounter:0 isException:NO arguments:[NSArray arrayWithObject:@"hoge"]];
            NLTQReport *failure1 = [NLTQReport reportWithSuccess:NO needsRetry:YES retryCounter:0 isException:NO arguments:[NSArray arrayWithObject:@"hoge"]];
            NLTQReport *failure2 = [NLTQReport reportWithSuccess:NO needsRetry:YES retryCounter:1 isException:NO arguments:[NSArray arrayWithObject:@"hoge"]];
            NLTQReport *failure3 = [NLTQReport reportWithSuccess:NO needsRetry:NO retryCounter:2 isException:NO arguments:[NSArray arrayWithObject:@"hoge"]];
            NLTQReport *exception = [NLTQReport reportWithSuccess:NO needsRetry:NO retryCounter:0 isException:YES arguments:[NSArray arrayWithObject:@"hoge"]];
            [reportManager addReportsFromArray:[NSArray arrayWithObjects:success1, success2, failure1, failure2, failure3, exception, nil]];
        });
        
        it(@"should successReports has 2 reports objects", ^{
            [[theValue([reportManager.successReports count]) should] equal:theValue(2)];
        });
        
        it(@"should failureReports has 3 reports objects", ^{
            [[theValue([reportManager.failureReports count]) should] equal:theValue(3)];
        });
        
        it(@"should exceptionReports has 1 reports objects", ^{
            [[theValue([reportManager.exceptionReports count]) should] equal:theValue(1)];
        });
        
        it(@"should not success", ^{
            [[theValue([reportManager success]) shouldNot] beYes];
        });
        
        it(@"localizeDescription", ^{
            NSString *description = @"\
Tests: 6\n\
  ✓ Successes\t: 2\n\
  ✗ Failures\t: 3\n\
    ✗ Failure : ( hoge )\n\
    ✗ Failure : ( hoge )\n\
    ✗ Failure : ( hoge )\n\
  ✷ Exceptions\t: 1\n\
    ✷ Exception : ( hoge )";
            [[[reportManager localizedDescription] should] equal:description];
        });
    });
});

SPEC_END
