//
//  NLTQStandardGen.h
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLTQStandardGen : NSObject

@property(nonatomic, readonly) int minimumSeed;
@property(nonatomic, readonly) int maximumSeed;
@property(nonatomic, readonly) int currentGeneratedValue;

+ (id)standardGenWithMinimumSeed:(int)minimumSeed
                     maximumSeed:(int)maximumSeed;

- (id)generateNext;
@end
