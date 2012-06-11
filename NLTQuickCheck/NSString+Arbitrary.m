//
//  NSString+Arbitrary.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/06/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+Arbitrary.h"
#import "NLTQGen.h"

@implementation NSString (Arbitrary)

+ (id)lowerCaseAlphabetArbitrary {
    NLTQGen *gen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
        return [NSString stringWithFormat:@"%c",random];
    }];
    [gen bindingGen:[NLTQGen chooseGenWithLow:97 high:122]];
    return gen;
}

+ (id)upperCaseAlphabetArbitrary {
    NLTQGen *gen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
        return [NSString stringWithFormat:@"%c",random];
    }];
    [gen bindingGen:[NLTQGen chooseGenWithLow:65 high:90]];
    return gen;
}

+ (id)characterArbitray {
    NLTQGen *gen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
        return [NSString stringWithFormat:@"%c",random];
    }];
    [gen bindingGen:[NLTQGen chooseGenWithLow:0 high:127]];
    return gen;
}

+ (id)arbitrary {
    NLTQGen *quadratic = [NLTQGen quadraticGenWithA:1000 b:1 c:0];
    NLTQGen *lengthGen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
        return [[NLTQGen chooseGenWithLow:0 high:random] valueWithProgress:progress];
    }];
    [lengthGen bindingGen:quadratic];
    
    NLTQGen *stringGen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0 ; i < random; i++) {
            [array addObject:[[self characterArbitray] valueWithProgress:progress]];
        }
        return [array componentsJoinedByString:@""];
    }];
    [stringGen bindingGen:lengthGen];
    
    return stringGen;
}

+ (id)alphabetStringArbitrary {
    NLTQGen *quadratic = [NLTQGen quadraticGenWithA:1000 b:1 c:0];
    NLTQGen *lengthGen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
        return [[NLTQGen chooseGenWithLow:0 high:random] valueWithProgress:progress];
    }];
    [lengthGen bindingGen:quadratic];
    
    NLTQGen *alphabetGenChooser = [NLTQGen oneOfGenWithGens:[self upperCaseAlphabetArbitrary], [self lowerCaseAlphabetArbitrary], nil];
    NLTQGen *stringGen = [NLTQGen genWithGenerateBlock:^id(double progress, int random) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0 ; i < random; i++) {
            [array addObject:[[alphabetGenChooser valueWithProgress:progress] valueWithProgress:progress]];
        }
        return [array componentsJoinedByString:@""];
    }];
    [stringGen bindingGen:lengthGen];
    
    return stringGen; 
}
@end
