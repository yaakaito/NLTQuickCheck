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

- (BOOL)success {
    
    return [self.successReports count] > 0 && [self.failureReports count] == 0 && [self.exceptionReports count] == 0;
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

- (void)addReportsFromArray:(NSArray *)reports {
    for (id report in reports) {
        [self addReport:report];
    }
}

- (NSString *)localizedDescription {
    NSMutableArray *strings = [NSMutableArray array];
    [strings addObject:[NSString stringWithFormat:@"Tests: %d", [self.successReports count] + [self.failureReports count] + [self.exceptionReports count]]];
    [strings addObject:[NSString stringWithFormat:@"  ✓ Successes\t: %d", [self.successReports count]]];
    [strings addObject:[NSString stringWithFormat:@"  ✗ Failures\t: %d", [self.failureReports count]]];
    for (NLTQReport *report in self.failureReports) {
        [strings addObject:[NSString stringWithFormat:@"    %@", [report localizedDescription]]];
    }
    [strings addObject:[NSString stringWithFormat:@"  ✷ Exceptions\t: %d", [self.exceptionReports count]]];
    for (NLTQReport *report in self.exceptionReports) {
        [strings addObject:[NSString stringWithFormat:@"    %@", [report localizedDescription]]];
    }
    return [strings componentsJoinedByString:@"\n"];
}
@end
