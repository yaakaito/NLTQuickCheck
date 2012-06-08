//
//  NLTQTestable.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NLTQTestable.h"
#import "NLTQTestRunner.h"
#import "NLTQReportManager.h"

@interface NLTQTestable()
@property(nonatomic, strong) NLTQTestRunner *runner;
@property(nonatomic, strong) NLTQReportManager *reportManager;
@end

@implementation NLTQTestable
@synthesize runner = _runner;
@synthesize reportManager = _reportManager;

- (id)initWithTestCase:(NLTQTestCase*)testCase {
    self = [super init];
    if(self) {
        self.runner = [NLTQTestRunner testRunnerWithTestCase:testCase];
        self.reportManager = [NLTQReportManager reportManager];
    }
    
    return self;
}

+ (id)testableWithName:(NSString *)testName propSelector:(SEL)selector arbitraries:(id)arbitraries, ... {
    
    NSMutableArray *arbitraries_ = [NSMutableArray array];
    va_list arguments;
    va_start(arguments, arbitraries);
    id value = arbitraries_;
    while (value) {
        [arbitraries_ addObject:value];
        value = va_arg(arguments, typeof(id));
    }
    va_end(arguments);
    
    NLTQTestCase *testCase = [NLTQTestCase selectorTestCaseWithSelector:selector arbitraries:arbitraries_];
    return [[self alloc] initWithTestCase:testCase];
}

- (void)_check:(BOOL)verbose {
    
    NSArray *reports;
    [_runner runWithVerbose:verbose reports:&reports];
}

- (void)check {
    
    [self _check:NO];
}

- (void)verboseCheck {
    
    [self _check:YES];
}

@end
