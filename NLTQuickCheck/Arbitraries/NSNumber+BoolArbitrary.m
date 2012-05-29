//
//  NSNumber+BoolArbitrary.m
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSNumber+BoolArbitrary.h"
#import "NLTQGen.h"

@implementation NSNumber (BoolArbitrary)
+ (id)boolArbitrary {
    return [NLTQGen elementsGenWithArray:[NSArray arrayWithObjects:[NSNumber numberWithBool:YES],[NSNumber numberWithBool:NO], nil]];
}
@end
