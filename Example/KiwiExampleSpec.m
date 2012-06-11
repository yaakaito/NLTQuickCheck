//
//  NLTQuickCheck - KiwiExampleSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQuickCheck.h"

SPEC_BEGIN(KiwiExampleSpec)

describe(@"QuickCheck Exmaple", ^{

    it(@"argA == argA", ^{
        NLTQTestable *testable = [NLTQTestable testableWithPropertyBlockArguments1:^BOOL(id argA) {
            return [argA boolValue] == [argA boolValue];
        } arbitrary:[NSNumber boolArbitrary]];
        [testable verboseCheck];
        [[theValue([testable success]) should] beYes];
        NSLog(@"%@", [testable prettyReport]);
    });

    it(@"double", ^{
        NLTQTestable *testable = [NLTQTestable testableWithPropertyBlockArguments2:^BOOL(id argA, id argB) {
            return YES;
        } arbitraries:[NSNumber nonZeroIntArbitrary],[NSNumber nonZeroIntArbitrary], nil];
        [testable verboseCheck];
    });
});

SPEC_END
