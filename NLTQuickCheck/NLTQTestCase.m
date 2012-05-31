//
//  NLTQTestCase.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NLTQTestCase.h"
#import "NLTQGen.h"

@implementation NLTQTestCase {
    __testCasePropertyExecuteBlock _block;
    NSArray *_arbitraries;
}

- (id)initWithExcecuteBlock:(__testCasePropertyExecuteBlock)block arbitraries:(NSArray*)array {
    self = [super init];
    if(self) {
        _block = block;
        _arbitraries = array;
    }
    return self;
}

- (NLTQReport *)checkWithTestCount:(int)testCount testLength:(int)testLength {
    
    NLTQReport *report = [[NLTQReport alloc] init];
    
    NSMutableArray *args = [NSMutableArray array];
    double progress = testCount / testLength;
    for (NSUInteger i = 0; i < [_arbitraries count]; i++) {
        NLTQGen *gen = [_arbitraries objectAtIndex:i];
        [args addObject:[gen valueWithProgress:progress]];
    }
    
    BOOL success, isException, needsRetry;
    int retryCounter;
    @try {
        report.successs = success = _block(args);
        if(!success) {
            if(++retryCounter < 3) {
                needsRetry = YES;
            }
        }
    }
    @catch (NSException *exception) {
        isException = YES;
    }
    
    return report;
}

+ (id)selectorTestCaseWithSelector:(SEL)selector arbitraries:(NSArray *)array {
    
}

+ (id)blocksTestCaseWithBlocksArguments0:(__testCasePropertyBlockArguments0)block {
    return [[self alloc] initWithExcecuteBlock:^BOOL(NSArray *args) {
        return block();
    } arbitraries:nil];
}

@end
