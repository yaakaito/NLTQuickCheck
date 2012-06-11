//
//  NSNumber+Arbitrary.h
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Arbitrary)
+ (id)boolArbitrary;
+ (id)doubleArbitrary;
+ (id)intArbitrary;
+ (id)nonZeroIntArbitrary;
@end
