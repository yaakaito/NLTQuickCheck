//
//  NSNumber+Arbitrary.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSNumber+Arbitrary.h"
#import "NLTQGen.h"
#import "NLTQStandardGen.h"

@implementation NSNumber (Arbitrary)
+ (id)boolArbitrary {
    return [NLTQGen elementsGenWithArray:[NSArray arrayWithObjects:[NSNumber numberWithBool:YES],[NSNumber numberWithBool:NO], nil]];
}
+ (id)doubleArbitrary {
    NLTQGen *quadratic = [NLTQGen quadraticGenWithA:1<<22 b:0 c:0];
    NLTQGen *doubleGen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
        NLTQGen *chooser = [NLTQGen randomGen];
        [chooser resizeWithMinimumSeed:-random maximumSeed:+random];
        random = [[chooser valueWithProgress:progress] intValue];
        int place = [[NSString stringWithFormat:@"%d",random] length] - 2;
        int l = [[NLTQStandardGen standardGenWithMinimumSeed:2 maximumSeed:place] currentGeneratedValue];
        int base = 10;
        for (int i = 1; i < l; i++) {
            base *= 10;
        }
        return [NSNumber numberWithDouble:(double)random/(double)base];
        
    }];
    [doubleGen bindingGen:quadratic];
    return doubleGen;
}

+ (id)intArbitrary {
    NLTQGen *quadratic = [NLTQGen quadraticGenWithA:1<<16 b:0 c:0];
    NLTQGen *doubleGen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
        NLTQGen *chooser = [NLTQGen randomGen];
        [chooser resizeWithMinimumSeed:-random maximumSeed:+random];
        return [chooser valueWithProgress:progress];
        
    }];
    [doubleGen bindingGen:quadratic];
    return doubleGen;
}


@end
