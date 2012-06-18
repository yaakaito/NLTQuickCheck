//
//  NLTQTestRunner.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NLTQTestRunner.h"

#define kNLTQTestRunnerDefaultTestLength    (100)

@interface NLTQTestRunner()
@property(nonatomic,strong) NLTQTestCase *testCase;
@property(nonatomic) int testLength;
@end

@implementation NLTQTestRunner {
    NLTQTestCase *_testCase;
    int _testLength;
}

@synthesize testCase = _testCase;
@synthesize testLength = _testLength;

- (id)initWithTestCase:(NLTQTestCase *)testCase {
    self = [super init];
    if(self) {
        self.testCase = testCase;
        self.testLength = kNLTQTestRunnerDefaultTestLength;
    }
    return self;
}

+ (id)testRunnerWithTestCase:(NLTQTestCase *)testCase {
    return [[self alloc] initWithTestCase:testCase];
}

- (NSArray*)runWithVerbose:(BOOL)isVerbose {
    
    NSMutableArray *mutableReports = [NSMutableArray array];
    NLTQReport *report;
    for (int i = 0; i < self.testLength; i++) {
        if(report && report.needsRetry) {
            report = [self.testCase checkWithTestCount:i testLength:self.testLength retryCounter:report.retryCounter+1 arguments:report.arguments];
        }
        else {
            report = [self.testCase checkWithTestCount:i testLength:self.testLength];
        }
        if(!report.skip) {
            [mutableReports addObject:report];
            if(isVerbose) {
                NSLog(@"%@", [report localizedDescription]);
            }
        }

    }
    return mutableReports;
}

- (void)setTestLength:(int)length {
    _testLength = length;
}
@end
