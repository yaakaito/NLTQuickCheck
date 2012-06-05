//
//  NLTQReportManager.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NLTQReportManager.h"

@interface NLTQReportManager()
@property(nonatomic, strong) NSMutableArray *successReports;
@property(nonatomic, strong) NSMutableArray *failureReports;
@property(nonatomic, strong) NSMutableArray *exceptionReports;
@end

@implementation NLTQReportManager {
    NSMutableArray *_successReports;
    NSMutableArray *_failureReports;
    NSMutableArray *_exceptionReports;
}

@synthesize successReports = _successReports;
@synthesize failureReports = _failureReports;
@synthesize exceptionReports = _exceptionReports;

- (id)init {
    self = [super init];
    if(self) {
        self.successReports = [NSMutableArray array];
        self.failureReports = [NSMutableArray array];
        self.exceptionReports = [NSMutableArray array];
    }
    return self;
}

+ (id)reportManager {
    return [[self alloc] init];
}

- (void)clear {
    [self.successReports removeAllObjects];
    [self.failureReports removeAllObjects];
    [self.exceptionReports removeAllObjects];
}

- (void)addReport:(NLTQReport *)report {

    if(report.isException) {
        [self addExceptionReport:report];
    }
    else if(!report.success) {
        [self addFailureReport:report];
    }
    else {
        [self addSuccessReport:report];
    }
}

- (void)addSuccessReport:(NLTQReport *)report {
    [self.successReports addObject:report];
}

- (void)addFailureReport:(NLTQReport *)report {
    [self.failureReports addObject:report];
}

- (void)addExceptionReport:(NLTQReport *)report {
    [self.exceptionReports addObject:report];
}

- (NSString *)stringFormat {
    return @"pending";
}
@end
