//
//  NLTQReport.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NLTQReport.h"

@interface NLTQReport()
@property(nonatomic) BOOL success;
@property(nonatomic) BOOL needsRetry;
@property(nonatomic) int  retryCounter;
@property(nonatomic) BOOL isException;
@end

@implementation NLTQReport {
    BOOL _success;
    BOOL _needsRetry;
    int _retryCounter;
    BOOL _isException;
}

@synthesize success = _success;
@synthesize needsRetry = _needsRetry;
@synthesize retryCounter = _retryCounter;
@synthesize isException = _isException;

- (id)initWithSuccess:(BOOL)success needsRetry:(BOOL)needsRetry retryCounter:(int)retryCounter isException:(BOOL)isException { 

    self = [super init];
    if(self) {
        self.success = success;
        self.needsRetry = needsRetry;
        self.retryCounter = retryCounter;
        self.isException = isException;
    }
    return self;
}

+ (id)reportWithSuccess:(BOOL)success needsRetry:(BOOL)needsRetry retryCounter:(int)retryCounter isException:(BOOL)isException {
    
    return [[self alloc] initWithSuccess:success needsRetry:needsRetry retryCounter:retryCounter isException:isException];
}

@end
