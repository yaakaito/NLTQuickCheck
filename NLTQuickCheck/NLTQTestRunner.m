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

- (void)runWithVerbose:(BOOL)isVerbose reports:(NSArray *__autoreleasing *)reports {
    
    int retryCounter = 0;
    NSMutableArray *mutableReports = [NSMutableArray array];
    for (int i = 0; i < self.testLength; i++) {
        NLTQReport *report = [self.testCase checkWithTestCount:i testLength:self.testLength];
        [mutableReports addObject:report];
    }
    
    if(reports) {
        *reports = [NSArray arrayWithArray:mutableReports];
    }
    
}

- (void)setTestLength:(int)length {
    _testLength = length;
}
@end
