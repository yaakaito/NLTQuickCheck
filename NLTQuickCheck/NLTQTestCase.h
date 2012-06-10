//
//  NLTQTestCase.h
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLTQReport.h"

typedef BOOL(^__testCasePropertyBlockArguments0)();
typedef BOOL(^__testCasePropertyBlockArguments1)(id argA);
typedef BOOL(^__testCasePropertyBlockArguments2)(id argA, id argB);
typedef BOOL(^__testCasePropertyBlockArguments3)(id argA, id argB, id argC);
typedef BOOL(^__testCasePropertyBlockArguments4)(id argA, id argB, id argC, id argD);
typedef BOOL(^__testCasePropertyBlockArguments5)(id argA, id argB, id argC, id argD, id argE);
typedef BOOL(^__testCasePropertyBlockArguments6)(id argA, id argB, id argC, id argD, id argE, id argF);
typedef BOOL(^__testCasePropertyBlockArguments7)(id argA, id argB, id argC, id argD, id argE, id argF, id argG);
typedef BOOL(^__testCasePropertyBlockArguments8)(id argA, id argB, id argC, id argD, id argE, id argF, id argG, id argH);

typedef BOOL(^__testCasePropertyExecuteBlock)(NSArray *args);

@interface NLTQTestCase : NSObject

+ (id)selectorTestCaseWithSelector:(SEL)selector target:(id)target arbitraries:(NSArray*)array;
+ (id)blocksTestCaseWithBlocksArguments0:(__testCasePropertyBlockArguments0)block;
+ (id)blocksTestCaseWithBlocksArguments1:(__testCasePropertyBlockArguments1)block arbitraries:(NSArray*)array;
+ (id)blocksTestCaseWithBlocksArguments2:(__testCasePropertyBlockArguments2)block arbitraries:(NSArray*)array;
+ (id)blocksTestCaseWithBlocksArguments3:(__testCasePropertyBlockArguments3)block arbitraries:(NSArray*)array;
+ (id)blocksTestCaseWithBlocksArguments4:(__testCasePropertyBlockArguments4)block arbitraries:(NSArray*)array;
+ (id)blocksTestCaseWithBlocksArguments5:(__testCasePropertyBlockArguments5)block arbitraries:(NSArray*)array;
+ (id)blocksTestCaseWithBlocksArguments6:(__testCasePropertyBlockArguments6)block arbitraries:(NSArray*)array;
+ (id)blocksTestCaseWithBlocksArguments7:(__testCasePropertyBlockArguments7)block arbitraries:(NSArray*)array;
+ (id)blocksTestCaseWithBlocksArguments8:(__testCasePropertyBlockArguments8)block arbitraries:(NSArray*)array;

- (NLTQReport*)checkWithTestCount:(int)testCount testLength:(int)testLength;
- (NLTQReport*)checkWithTestCount:(int)testCount testLength:(int)testLength retryCounter:(int)retryCounter arguments:(NSArray*)arguments;
@end
