//
//  NLTQReportManager.h
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLTQReport.h"

@interface NLTQReportManager : NSObject

@property(nonatomic,strong,readonly) NSMutableArray *successReports;
@property(nonatomic,strong,readonly) NSMutableArray *failureReports;
@property(nonatomic,strong,readonly) NSMutableArray *exceptionReports;

+ (id)reportManager;
- (void)clear;
- (BOOL)success;
- (void)addReport:(NLTQReport*)report;
- (void)addSuccessReport:(NLTQReport*)report;
- (void)addFailureReport:(NLTQReport*)report;
- (void)addExceptionReport:(NLTQReport*)report;
- (void)addReportsFromArray:(NSArray*)reports;
- (NSString*)localizedDescription;
@end
