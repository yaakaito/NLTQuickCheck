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

+ (id)testableWithPropertySelector:(SEL)selector arbitraries:(id)arbitraries, ... {

    NSMutableArray *arbitraries_ = [NSMutableArray array];
    va_list arguments;
    va_start(arguments, arbitraries);
    id value = arbitraries;
    while (value) {
        [arbitraries_ addObject:value];
        value = va_arg(arguments, typeof(id));
    }
    va_end(arguments);
    
    NLTQTestCase *testCase = [NLTQTestCase selectorTestCaseWithSelector:selector arbitraries:arbitraries_];
    return [[self alloc] initWithTestCase:testCase];
}


+ (id)testableWithPropertyBlock:(__testCasePropertyBlockArguments0)block {
    
    NLTQTestCase *testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments0:block];
    return [[self alloc] initWithTestCase:testCase];
}

+ (id)testableWithPropertyBlockArguments1:(__testCasePropertyBlockArguments1)block arbitrary:(id)arbitrary {
    
    NLTQTestCase *testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments1:block arbitraries:[NSArray arrayWithObject:arbitrary]];
    return [[self alloc] initWithTestCase:testCase];
}

+ (id)testableWithPropertyBlockArguments2:(__testCasePropertyBlockArguments2)block arbitraries:(id)arbitraries, ... {
    
    NSMutableArray *arbitraries_ = [NSMutableArray array];
    va_list arguments;
    va_start(arguments, arbitraries);
    id value = arbitraries;
    while (value) {
        [arbitraries_ addObject:value];
        value = va_arg(arguments, typeof(id));
    }
    va_end(arguments);
    NLTQTestCase *testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments2:block arbitraries:arbitraries_];
    return [[self alloc] initWithTestCase:testCase];
}

+ (id)testableWithPropertyBlockArguments3:(__testCasePropertyBlockArguments3)block arbitraries:(id)arbitraries, ... {
    
    NSMutableArray *arbitraries_ = [NSMutableArray array];
    va_list arguments;
    va_start(arguments, arbitraries);
    id value = arbitraries;
    while (value) {
        [arbitraries_ addObject:value];
        value = va_arg(arguments, typeof(id));
    }
    va_end(arguments);
    NLTQTestCase *testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments3:block arbitraries:arbitraries_];
    return [[self alloc] initWithTestCase:testCase];
}

+ (id)testableWithPropertyBlockArguments4:(__testCasePropertyBlockArguments4)block arbitraries:(id)arbitraries, ... {
    
    NSMutableArray *arbitraries_ = [NSMutableArray array];
    va_list arguments;
    va_start(arguments, arbitraries);
    id value = arbitraries;
    while (value) {
        [arbitraries_ addObject:value];
        value = va_arg(arguments, typeof(id));
    }
    va_end(arguments);
    NLTQTestCase *testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments4:block arbitraries:arbitraries_];
    return [[self alloc] initWithTestCase:testCase];
}

+ (id)testableWithPropertyBlockArguments5:(__testCasePropertyBlockArguments5)block arbitraries:(id)arbitraries, ... {
    
    NSMutableArray *arbitraries_ = [NSMutableArray array];
    va_list arguments;
    va_start(arguments, arbitraries);
    id value = arbitraries;
    while (value) {
        [arbitraries_ addObject:value];
        value = va_arg(arguments, typeof(id));
    }
    va_end(arguments);
    NLTQTestCase *testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments5:block arbitraries:arbitraries_];
    return [[self alloc] initWithTestCase:testCase];
}

+ (id)testableWithPropertyBlockArguments6:(__testCasePropertyBlockArguments6)block arbitraries:(id)arbitraries, ... {
    
    NSMutableArray *arbitraries_ = [NSMutableArray array];
    va_list arguments;
    va_start(arguments, arbitraries);
    id value = arbitraries;
    while (value) {
        [arbitraries_ addObject:value];
        value = va_arg(arguments, typeof(id));
    }
    va_end(arguments);
    NLTQTestCase *testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments6:block arbitraries:arbitraries_];
    return [[self alloc] initWithTestCase:testCase];
}

+ (id)testableWithPropertyBlockArguments7:(__testCasePropertyBlockArguments7)block arbitraries:(id)arbitraries, ... {
    
    NSMutableArray *arbitraries_ = [NSMutableArray array];
    va_list arguments;
    va_start(arguments, arbitraries);
    id value = arbitraries;
    while (value) {
        [arbitraries_ addObject:value];
        value = va_arg(arguments, typeof(id));
    }
    va_end(arguments);
    NLTQTestCase *testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments7:block arbitraries:arbitraries_];
    return [[self alloc] initWithTestCase:testCase];
}

+ (id)testableWithPropertyBlockArguments8:(__testCasePropertyBlockArguments8)block arbitraries:(id)arbitraries, ... {
    
    NSMutableArray *arbitraries_ = [NSMutableArray array];
    va_list arguments;
    va_start(arguments, arbitraries);
    id value = arbitraries;
    while (value) {
        [arbitraries_ addObject:value];
        value = va_arg(arguments, typeof(id));
    }
    va_end(arguments);
    NLTQTestCase *testCase = [NLTQTestCase blocksTestCaseWithBlocksArguments8:block arbitraries:arbitraries_];
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
