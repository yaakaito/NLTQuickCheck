//
//  NLTQTestRunner.h
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLTQTestCase.h"

@interface NLTQTestRunner : NSObject

+ (id)testRunnerWithTestCase:(NLTQTestCase*)testCase;
- (void)runWithVerbose:(BOOL)isVerbose reports:(NSArray**)reports;
@end
