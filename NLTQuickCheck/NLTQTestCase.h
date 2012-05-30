//
//  NLTQTestCase.h
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLTQReport.h"

@interface NLTQTestCase : NSObject

+ (id)selectorTestCaseWithSelector:(SEL)selector arbitraries:(NSArray*)array;
- (BOOL)checkWithTestCount:(int)testCount report:(NLTQReport**)report retry:(BOOL*)retry error:(NSError**)error;
@end
