//
//  NLTQuickCheck - KiwiExampleSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQuickCheck.h"
#import "EXMath.h"

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

    it(@"add", ^{
        NLTQTestable *testable = [NLTQTestable testableWithPropertyBlockArguments2:^BOOL(id argA, id argB) {
            return [EXMath add:[argA intValue] b:[argB intValue]] == [argA intValue] + [argB intValue];
        } arbitraries:[NSNumber intArbitrary], [NSNumber intArbitrary], nil];
        [testable verboseCheck];
        [[theValue([testable success]) should] beYes];
    });
    
    it(@"div", ^{
        NLTQTestable *testable = [NLTQTestable testableWithPropertyBlockArguments2:^BOOL(id argA, id argB) {
            return [argA intValue] / [argB intValue] == [argA intValue] / [argB intValue];
        } arbitraries:[NSNumber intArbitrary], [[NSNumber intArbitrary] andSkipCaseBlock:^BOOL(id value) {
            return [value intValue] == 0;
        }], nil];
        [testable verboseCheck];
        [[theValue([testable success]) should] beYes];
        NSLog(@"%@", [testable prettyReport]);
    });
    
    it(@"string", ^{
        NLTQTestable *testable = [NLTQTestable testableWithPropertyBlockArguments1:^BOOL(id argA) {
            return [argA isEqualToString:argA];
        } arbitrary:[NSString alphabetStringArbitrary]];
        [testable verboseCheck];
        [[theValue([testable success]) should] beYes];
        NSLog(@"%@", [testable prettyReport]);
    });
    
    it(@"failure case", ^{
        NLTQTestable *testable = [NLTQTestable testableWithPropertyBlockArguments2:^BOOL(id argA, id argB) {
            return [argA intValue] - [argB intValue] > 0;
        } arbitraries:[NSNumber intArbitrary], [NSNumber intArbitrary], nil];
        [testable verboseCheck];
        [[theValue([testable success]) should] beNo];
        NSLog(@"%@", [testable prettyReport]);  
    });
     
    it(@"exception case", ^{
        NLTQTestable *testable = [NLTQTestable testableWithPropertyBlockArguments2:^BOOL(id argA, id argB) {
            return [argA intValue] / [argB intValue] == [argA intValue] / [argB intValue];
        } arbitraries:[NSNumber intArbitrary], [NSNumber nonZeroIntArbitrary], nil];
        [testable verboseCheck];
        [[theValue([testable success]) should] beYes];
        NSLog(@"%@", [testable prettyReport]);  
    });
});

SPEC_END
