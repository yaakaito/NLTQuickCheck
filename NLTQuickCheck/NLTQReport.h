//
//  NLTQReport.h
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLTQReport : NSObject

@property(nonatomic, readonly) BOOL success;
@property(nonatomic, readonly) BOOL needsRetry;
@property(nonatomic, readonly) int retryCounter;
@property(nonatomic, readonly) BOOL isException;
@property(nonatomic, strong, readonly) NSArray *arguments;

+ (id)reportWithSuccess:(BOOL)success
             needsRetry:(BOOL)needsRetry
           retryCounter:(int)retryCounter
            isException:(BOOL)isException
              arguments:(NSArray*)arguments;

- (NSString*)localizedDescription;
@end
