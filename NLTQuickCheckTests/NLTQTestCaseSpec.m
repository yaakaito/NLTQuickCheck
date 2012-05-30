//
//  NLTQuickCheck - NLTQTestCaseSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"

SPEC_BEGIN(NLTQTestCaseSpec)

describe(@"Example", ^{
    __block NSString *string;
    context(@"New", ^{
        beforeEach(^{
            string = @"example";
        });
        
        context(@"append 'exsample'", ^{
            beforeEach(^{
                string = [string stringByAppendingString:@"example"];
            });
            
            it(@"length = 14", ^{
                [[theValue([string length]) should] equal:theValue(15)];
            });
        });
    });
});

SPEC_END
