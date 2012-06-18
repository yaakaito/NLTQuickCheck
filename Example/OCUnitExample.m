//
//  OCUnitExample.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/06/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OCUnitExample.h"
#import "NLTQuickCheck.h"
#import "EXMath.h"

@implementation OCUnitExample

- (BOOL)propAdd:(NSNumber*)a b:(NSNumber*)b {
    return [EXMath add:[a intValue] b:[b intValue]] == [a intValue] + [b intValue];
}
- (void)testQuickCheckXUnitStyleExample {
    NLTQTestable *testable = [NLTQTestable testableWithPropertySelector:@selector(propAdd:b:) 
                                                                 target:self
                                                            arbitraries:[NSNumber intArbitrary], [NSNumber intArbitrary], nil];
    [testable check];
    NSLog(@"%@", [testable prettyReport]);
    STAssertTrue([testable success], @"%@", [testable prettyReport]);
}
@end
