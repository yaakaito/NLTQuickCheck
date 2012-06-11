//
//  NLTQuickCheck - NLTQGenCombinatorSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQGen.h"

@interface NLTQGen(Privates)
+ (NSArray*)numbersArrayWithLow:(int)low high:(int)high;
@end

SPEC_BEGIN(NLTQGenCombinatorSpec)

describe(@"Gen(erator) Combinator", ^{

    context(@"chooseGenWithLow:high:", ^{
        
        context(@"support method numbersArrayWithLow:high", ^{
            
            context(@"with low 20 and high 30", ^{
                __block NSArray *array;
                
                beforeEach(^{
                    array = [NLTQGen numbersArrayWithLow:20 high:30];
                });
                
                it(@"should has 11 numbers", ^{
                    [[theValue([array count]) should] equal:theValue(11)];
                });
                
                it(@"should first object 20", ^{
                    [[theValue([[array objectAtIndex:0] intValue]) should] equal:theValue(20)];
                });
                
                it(@"should lastest object 30", ^{
                    [[theValue([[array lastObject] intValue]) should] equal:theValue(30)];
                });
                
            });
        }); 
        
        context(@"with low 10 and high 20", ^{
            __block NLTQGen *gen;
            beforeEach(^{
                gen = [NLTQGen chooseGenWithLow:10 high:20];
            });
            
            it(@"should value between 10 - 20", ^{
                for(double p = 0.0; p < 1.0; p += 0.01) {
                    NSNumber *v = [gen valueWithProgress:p];
                    [[theValue([v doubleValue]) should] beBetween:theValue(10) and:theValue(20)];
                }
            });
        });
    });
    
    context(@"elementsGenWithArray: with [1,2,3]", ^{

        __block NLTQGen *gen;
        beforeEach(^{
            gen = [NLTQGen elementsGenWithArray:[NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2], nil]];
        });
        
        it(@"should value between 1 ~ 3", ^{
            for(double p = 0.0; p < 1.0; p += 0.01) {
                NSNumber *v = [gen valueWithProgress:p];
                [[theValue([v intValue]) should] beBetween:theValue(1) and:theValue(3)];
            }
        });
    });
    
    context(@"elementsGenWithObjects: with [1,2,3]", ^{
        
        __block NLTQGen *gen;
        beforeEach(^{
            gen = [NLTQGen elementsGenWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2], nil];
        });
        
        it(@"should value between 1 ~ 3", ^{
            for(double p = 0.0; p < 1.0; p += 0.01) {
                NSNumber *v = [gen valueWithProgress:p];
                [[theValue([v intValue]) should] beBetween:theValue(1) and:theValue(3)];
            }
        });
    });
    
    context(@"randomGen with default", ^{
        __block NLTQGen *gen;
        beforeEach(^{
            gen = [NLTQGen randomGen];
        });
        
        it(@"should value between 0 ~ 1000", ^{
            for(double p = 0.0; p < 1.0; p += 0.01) {
                NSNumber *v = [gen valueWithProgress:p];
                [[theValue([v intValue]) should] beBetween:theValue(0) and:theValue(1000)];
            }
        });
    });

});

SPEC_END
