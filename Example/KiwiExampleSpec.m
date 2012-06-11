//
//  NLTQuickCheck - KiwiExampleSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQuickCheck.h"

@interface Math : NSObject
+ (int)add:(int)a b:(int)b;
@end

@implementation Math
+ (int)add:(int)a b:(int)b {
    return a + b;
}
@end

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
            return [Math add:[argA intValue] b:[argB intValue]] == [argA intValue] + [argB intValue];
        } arbitraries:[NSNumber intArbitrary], [NSNumber intArbitrary], nil];
        [testable verboseCheck];
        [[theValue([testable success]) should] beYes];
    });
    
    it(@"string", ^{
        NLTQTestable *testable = [NLTQTestable testableWithPropertyBlockArguments1:^BOOL(id argA) {
            return [argA isEqualToString:argA];
        } arbitrary:[NSString alphabetStringArbitrary]];
        [testable verboseCheck];
        [[theValue([testable success]) should] beYes];
        NSLog(@"%@", [testable prettyReport]);
    });
     

});

SPEC_END
