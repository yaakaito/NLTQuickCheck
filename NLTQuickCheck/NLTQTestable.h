//
//  NLTQTestable.h
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLTQTestCase.h"

@interface NLTQTestable : NSObject

+ (id)testableWithProperySelector:(SEL)selector 
                      arbitraries:(id)arbitraries, ... NS_REQUIRES_NIL_TERMINATION;

+ (id)testableWithPropertyBlock:(__testCasePropertyBlockArguments0)block;
//+ (id)testableWithPropertyBlock:(id)block
//                    arbitraries:(id)arbitraries, ... NS_REQUIRES_NIL_TERMINATION;
+ (id)testableWithPropertyBlockArguments1:(__testCasePropertyBlockArguments1)block
                                arbitrary:(id)arbitrary;
+ (id)testableWithPropertyBlockArguments2:(__testCasePropertyBlockArguments2)block
                              arbitraries:(id)arbitraries, ... NS_REQUIRES_NIL_TERMINATION;
+ (id)testableWithPropertyBlockArguments3:(__testCasePropertyBlockArguments3)block
                              arbitraries:(id)arbitraries, ... NS_REQUIRES_NIL_TERMINATION;
+ (id)testableWithPropertyBlockArguments4:(__testCasePropertyBlockArguments4)block
                              arbitraries:(id)arbitraries, ... NS_REQUIRES_NIL_TERMINATION;
+ (id)testableWithPropertyBlockArguments5:(__testCasePropertyBlockArguments5)block
                              arbitraries:(id)arbitraries, ... NS_REQUIRES_NIL_TERMINATION;
+ (id)testableWithPropertyBlockArguments6:(__testCasePropertyBlockArguments6)block
                              arbitraries:(id)arbitraries, ... NS_REQUIRES_NIL_TERMINATION;
+ (id)testableWithPropertyBlockArguments7:(__testCasePropertyBlockArguments7)block
                              arbitraries:(id)arbitraries, ... NS_REQUIRES_NIL_TERMINATION;
+ (id)testableWithPropertyBlockArguments8:(__testCasePropertyBlockArguments8)block
                              arbitraries:(id)arbitraries, ... NS_REQUIRES_NIL_TERMINATION;
- (void)check;
- (void)verboseCheck;
@end
