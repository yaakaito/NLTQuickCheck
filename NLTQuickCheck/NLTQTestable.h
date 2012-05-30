//
//  NLTQTestable.h
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLTQTestable : NSObject

+ (id)testableWithName:(NSString*)testName 
          propSelector:(SEL)selector 
           arbitraries:(id)arbitraries, ... NS_REQUIRES_NIL_TERMINATION;

- (void)check;
- (void)verboseCheck;
@end
