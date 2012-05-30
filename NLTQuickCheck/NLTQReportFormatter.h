//
//  NLTQReportFormatter.h
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLTQReportFormatter : NSObject

+ (id)formatter;
- (NSString*)stringFromReports:(NSArray*)report;
@end
