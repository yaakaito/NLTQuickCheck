//
//  NLTQTestable.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NLTQTestable.h"
#import "NLTQTestCase.h"
#import "NLTQTestRunner.h"

@implementation NLTQTestable {
    NSString* _testName;
    NLTQTestRunner *_runner;
    NSArray *_reports;
}

- (id)initWithName:(NSString *)testName propSelector:(SEL)selector arbitraries:(NSArray*)arbitraries {
    self = [super init];
    if(self) {
        _testName = testName;
        NLTQTestCase *testCase = [NLTQTestCase selectorTestCaseWithSelector:selector arbitraries:arbitraries];
        _runner = [NLTQTestRunner testRunnerWithTestCase:testCase];
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
    
    return [[self alloc] initWithName:testName propSelector:selector arbitraries:arbitraries_];
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
