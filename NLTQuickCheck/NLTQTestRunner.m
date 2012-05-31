//
//  NLTQTestRunner.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NLTQTestRunner.h"

@implementation NLTQTestRunner {
    NLTQTestCase *_testCase;
}

- (id)initWithTestCase:(NLTQTestCase *)testCase {
    self = [super init];
    if(self) {
        _testCase = testCase;
    }
    return self;
}

+ (id)testRunnerWithTestCase:(NLTQTestCase *)testCase {
    return [[self alloc] initWithTestCase:testCase];
}

- (void)runWithVerbose:(BOOL)isVerbose reports:(NSArray *__autoreleasing *)reports {
    
    int retryCounter = 0;
    for (int i = 0; i < 100; i++) {
/*
        NLTQReport
        if(retry) {
            retryCounter++;
            if(retryCounter > 3) {
                // failure
            }
            
            // retry
        }
    
        if(!result) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
    
    if(reports) {
        *reports = [NSArray array];
 */
    }
}
@end
