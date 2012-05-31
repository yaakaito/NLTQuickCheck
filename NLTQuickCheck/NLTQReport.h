//
//  NLTQReport.h
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLTQReport : NSObject

@property(nonatomic) BOOL successs;
@property(nonatomic, readonly) BOOL needsRetry;
@property(nonatomic, readonly) int retryCounter;
@property(nonatomic, readonly) BOOL isException;

@end
