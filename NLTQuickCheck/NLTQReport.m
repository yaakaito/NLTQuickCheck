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
@property(nonatomic, strong) NSArray *arguments;
@end

@implementation NLTQReport {
    BOOL _success;
    BOOL _needsRetry;
    int _retryCounter;
    BOOL _isException;
    NSArray *_arguments;
}

@synthesize success = _success;
@synthesize needsRetry = _needsRetry;
@synthesize retryCounter = _retryCounter;
@synthesize isException = _isException;
@synthesize arguments = _arguments;

- (id)initWithSuccess:(BOOL)success
           needsRetry:(BOOL)needsRetry
         retryCounter:(int)retryCounter
          isException:(BOOL)isException
            arguments:(NSArray*)arguments{ 

    self = [super init];
    if(self) {
        self.success = success;
        self.needsRetry = needsRetry;
        self.retryCounter = retryCounter;
        self.isException = isException;
        self.arguments = arguments;
    }
    return self;
}

+ (id)reportWithSuccess:(BOOL)success
             needsRetry:(BOOL)needsRetry
           retryCounter:(int)retryCounter
            isException:(BOOL)isException
              arguments:(NSArray *)arguments {
    
    return [[self alloc] initWithSuccess:success
                              needsRetry:needsRetry
                            retryCounter:retryCounter
                             isException:isException
                               arguments:arguments];
}

- (NSString *)localizeNSNumber:(NSNumber *)arg {

    if(strcmp([arg objCType], @encode(BOOL)) == 0) {
        if([arg boolValue]) {
            return @"YES";
        }
        else {
            return @"NO";
        }
    }
    return [arg stringValue];
}

- (NSString *)localizedDescription {
    
    NSMutableArray *strings = [NSMutableArray array];
    if(self.isException) {
        [strings addObject:@"✷ Exception : ("];
    }
    else if(!self.success) {
        [strings addObject:@"✗ Failure : ("];
    }
    else {
        [strings addObject:@"✓ Success : ("];
    }
    for (NSUInteger i = 0; i < [self.arguments count]; i++) {
        id arg = [self.arguments objectAtIndex:i];
        if([arg isKindOfClass:[NSNumber class]]) {
            [strings addObject:[self localizeNSNumber:arg]];
        }
        else {
            [strings addObject:[arg description]];
        }
        if(i < [self.arguments count]-1) {
            [strings addObject:@","];
        }
    }
    [strings addObject:@")"];
    return [strings componentsJoinedByString:@" "];
}

@end
