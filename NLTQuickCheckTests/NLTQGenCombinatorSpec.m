//
//  NLTQuickCheck - NLTQGenCombinatorSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQGen.h"

@interface NLTQGen(Privates)
+ (NSArray*)numbersArrayWithLow:(NSInteger)low high:(NSInteger)high;
@end

SPEC_BEGIN(NLTQGenCombinatorSpec)

describe(@"Gen(erator)", ^{
    context(@"class method ``chooseGenWithLow:High`` ", ^{
        
        context(@"call with low 10 and high 20", ^{
            __block NLTQGen *gen;
            
            beforeEach(^{
                gen = [NLTQGen chooseGenWithLow:10 high:20];
            });
            
            it(@"at progress 0.1, value in 10 - 20", ^{
                NSNumber *v = [gen valueWithProgress:0.1];
                [[theValue([v intValue]) should] beGreaterThanOrEqualTo:theValue(10)];
                [[theValue([v intValue]) should] beLessThanOrEqualTo:theValue(20)];
            });
        });
    });
    
    context(@"class method ``elementsGenWithArray:`` ", ^{
        
        context(@"support method ``numbersArrayWithLow:high`` ", ^{
           
            context(@"when call low 20 and high 30", ^{
                __block NSArray *array;
                
                beforeEach(^{
                    array = [NLTQGen numbersArrayWithLow:20 high:30];
                });
                
                it(@"has 11 numbers", ^{
                    [[[array should] have:11] count];
                });
                
                it(@"first object 20", ^{
                    [[theValue([[array objectAtIndex:0] intValue]) should] equal:theValue(20)];
                });
                
                it(@"lastest object 30", ^{
                    [[theValue([[array lastObject] intValue]) should] equal:theValue(30)];
                });
            });
        }); 

        context(@"call with [1,2,3]", ^{
            __block NLTQGen *gen;
            
            beforeEach(^{
                gen = [NLTQGen elementsGenWithArray:[NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2], nil]];
            });

            it(@"at progress 0.1 value in 1 ~ 3", ^{
                NSNumber *v = [gen valueWithProgress:0.1];
                [[theValue([v intValue]) should] beGreaterThanOrEqualTo:theValue(1)];
                [[theValue([v intValue]) should] beLessThanOrEqualTo:theValue(3)];
            });
        });
    });
});

SPEC_END
