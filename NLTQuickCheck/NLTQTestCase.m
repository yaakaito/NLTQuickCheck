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

- (NSArray *)gensRealize:(double)progress {
    NSMutableArray *args = [NSMutableArray array];
    for (NSUInteger i = 0; i < [_arbitraries count]; i++) {
        NLTQGen *gen = [_arbitraries objectAtIndex:i];
        [args addObject:[gen valueWithProgress:progress]];
    }
    return args;
}

- (NLTQReport *)checkWithTestCount:(int)testCount testLength:(int)testLength retryCounter:(int)retryCounter arguments:(NSArray *)arguments {
    
    double progress = testCount / testLength;
    BOOL success = NO, needsRetry = NO, isException = NO;
    if(!arguments) {
        arguments = [self gensRealize:progress];
    }
    @try {
        success = _block(arguments);
    }
    @catch (NSException *exception) {
        isException = YES;
    }
    if(retryCounter > 0) {
        retryCounter++;
        if(retryCounter < 3){
            needsRetry = YES;
        }
    }
    
    return [NLTQReport reportWithSuccess:success needsRetry:needsRetry retryCounter:retryCounter isException:isException arguments:nil];
}

- (NLTQReport *)checkWithTestCount:(int)testCount testLength:(int)testLength {
    
    return [self checkWithTestCount:testCount testLength:testLength retryCounter:0 arguments:nil];
}

+ (id)selectorTestCaseWithSelector:(SEL)selector arbitraries:(NSArray *)array {
    return nil;
}

+ (id)blocksTestCaseWithBlocksArguments0:(__testCasePropertyBlockArguments0)block {
    return [[self alloc] initWithExcecuteBlock:^BOOL(NSArray *args) {
        return block();
    } arbitraries:nil];
}

+ (id)blocksTestCaseWithBlocksArguments1:(__testCasePropertyBlockArguments1)block arbitraries:(NSArray *)array {
    return [[self alloc] initWithExcecuteBlock:^BOOL(NSArray *args) {
        return block([args objectAtIndex:0]);
    } arbitraries:array];
}

+ (id)blocksTestCaseWithBlocksArguments2:(__testCasePropertyBlockArguments2)block arbitraries:(NSArray *)array {
    return [[self alloc] initWithExcecuteBlock:^BOOL(NSArray *args) {
        return block([args objectAtIndex:0], [args objectAtIndex:1]);
    } arbitraries:array];
}

+ (id)blocksTestCaseWithBlocksArguments3:(__testCasePropertyBlockArguments3)block arbitraries:(NSArray *)array {
    return [[self alloc] initWithExcecuteBlock:^BOOL(NSArray *args) {
        return block([args objectAtIndex:0], [args objectAtIndex:1], [args objectAtIndex:2]);
    } arbitraries:array];
}

+ (id)blocksTestCaseWithBlocksArguments4:(__testCasePropertyBlockArguments4)block arbitraries:(NSArray *)array {
    return [[self alloc] initWithExcecuteBlock:^BOOL(NSArray *args) {
        return block([args objectAtIndex:0], [args objectAtIndex:1], [args objectAtIndex:2], [args objectAtIndex:3]);
    } arbitraries:array];
}

+ (id)blocksTestCaseWithBlocksArguments5:(__testCasePropertyBlockArguments5)block arbitraries:(NSArray *)array {
    return [[self alloc] initWithExcecuteBlock:^BOOL(NSArray *args) {
        return block([args objectAtIndex:0], [args objectAtIndex:1], [args objectAtIndex:2], [args objectAtIndex:3], [args objectAtIndex:4]);
    } arbitraries:array];
}

+ (id)blocksTestCaseWithBlocksArguments6:(__testCasePropertyBlockArguments6)block arbitraries:(NSArray *)array {
    return [[self alloc] initWithExcecuteBlock:^BOOL(NSArray *args) {
        return block([args objectAtIndex:0], [args objectAtIndex:1], [args objectAtIndex:2], [args objectAtIndex:3], [args objectAtIndex:4], [args objectAtIndex:5]);
    } arbitraries:array];
}

+ (id)blocksTestCaseWithBlocksArguments7:(__testCasePropertyBlockArguments7)block arbitraries:(NSArray *)array {
    return [[self alloc] initWithExcecuteBlock:^BOOL(NSArray *args) {
        return block([args objectAtIndex:0], [args objectAtIndex:1], [args objectAtIndex:2], [args objectAtIndex:3], [args objectAtIndex:4], [args objectAtIndex:5], [args objectAtIndex:6]);
    } arbitraries:array];
}

+ (id)blocksTestCaseWithBlocksArguments8:(__testCasePropertyBlockArguments8)block arbitraries:(NSArray *)array {
    return [[self alloc] initWithExcecuteBlock:^BOOL(NSArray *args) {
        return block([args objectAtIndex:0], [args objectAtIndex:1], [args objectAtIndex:2], [args objectAtIndex:3], [args objectAtIndex:4], [args objectAtIndex:5], [args objectAtIndex:6], [args objectAtIndex:7]);
    } arbitraries:array];
}
@end
