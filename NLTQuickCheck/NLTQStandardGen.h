//
//  NLTQStandardGen.h
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLTQStandardGen : NSObject

@property(nonatomic, readonly) NSInteger minimumSeed;
@property(nonatomic, readonly) NSInteger maximumSeed;
@property(nonatomic, readonly) NSInteger currentGeneratedValue;

+ (id)standardGenWithMinimumSeed:(NSInteger)minimumSeed
                     maximumSeed:(NSInteger)maximumSeed;

- (id)initWithMinimumSeed:(NSInteger)minimumSeed 
              maximumSeed:(NSInteger)maximumSeed;

- (id)generateNext;
@end
