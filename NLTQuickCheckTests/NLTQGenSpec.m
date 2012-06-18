//
//  NLTQuickCheck - NLTQGenSpec.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import "Kiwi.h"
#import "NLTQGen.h"

SPEC_BEGIN(NLTQGenSpec)

describe(@"Gen(erator)", ^{
    __block NLTQGen *gen;
    context(@"genWithGenerateBlock and return 'string'", ^{
        beforeEach(^{
            gen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
                return @"string";
            }];
        });
        
        it(@"should value is fixed string", ^{
            for(double p = 0.0; p < 1.0; p += 0.01) {
                NSString *v = [gen valueWithProgress:p];
                [[v should] equal:@"string"];
            }
        });
    });
    
    context(@"genWithGenerateBlock and return progress", ^{
        beforeEach(^{
            gen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
                return [NSNumber numberWithDouble:progress];
            }];
        });
        
        it(@"should value equal progress", ^{
            for(double p = 0.0; p < 1.0; p += 0.01) {
                NSNumber *v = [gen valueWithProgress:p];
                [[theValue([v doubleValue]) should] equal:theValue(p)];
            }
        });
    });
    
    context(@"resizeWithMinimumSeed:maximumSeed and low 40, high 100", ^{
        __block NLTQGen *gen;
        beforeEach(^{
            gen = [NLTQGen randomGen];
            [gen resizeWithMinimumSeed:40 maximumSeed:100];
        });
        
        it(@"should value between 40 ~ 100", ^{
            for(double p = 0.0; p < 1.0; p += 0.01) {
                NSNumber *v = [gen valueWithProgress:p];
                [[theValue([v doubleValue]) should] beBetween:theValue(40) and:theValue(100)];
            }
        });
        
    });
    
    context(@"`bindingGen`", ^{
        context(@"and binding not return NSNumber object generator", ^{
            __block NLTQGen *bindingGen;
            __block NLTQGen *gen;
            beforeAll(^{
                bindingGen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
                    return [NSString stringWithFormat:@"hoge"];
                }];
            });
            
            it(@"should raise exception", ^{
                gen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
                    return [NSNumber numberWithInt:random];
                }];
                [[theBlock(^{
                    [gen bindingGen:bindingGen];
                }) should] raise];
            });
        });
        
        context(@"and binding return (NSNumber*)((int)progress*100) generator", ^{
            __block NLTQGen *bindingGen;
            __block NLTQGen *gen;
            beforeAll(^{
                bindingGen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
                    return [NSNumber numberWithInt:(int)(progress * 100)];
                }];
            });
        
            it(@"should retrun binding gens value * 10", ^{
                gen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
                    return [NSNumber numberWithInt:random*10];
                }];
                __unsafe_unretained id gen_ = gen;
                [[theBlock(^{
                    [gen_ bindingGen:bindingGen];
                }) shouldNot] raise];
                
                int v = [[gen valueWithProgress:0.1] intValue];
                [[theValue(v) should] equal:theValue(100)];
            });
        });
    });
    
    context(@"skip case", ^{
        __block NLTQGen *gen;
        context(@"when fixble return NSNumber 10 and Skip NSNumber 10", ^{
            beforeEach(^{
                gen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
                    return [NSNumber numberWithInt:10];
                }];
                [gen skipCaseWithBlock:^BOOL(id value) {
                    if([value intValue] == 10) {
                        return YES;
                    }
                    return NO;
                }];
            });
            
            it(@"should value is nil", ^{
                id value = [gen valueWithProgress:0];
                [[theValue(value == nil) should] beYes]; // Kiwis Bug? :( [[nil should] beNil] -> Failure
            });
            
        });
    });

});

SPEC_END
