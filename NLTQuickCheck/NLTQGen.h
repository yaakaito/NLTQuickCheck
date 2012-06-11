//
//  NLTQGen.h
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNLTQGenDefaultMiniumSeed   (0)
#define kNLTQGenDefaultMaxiumSeed   (1000)

typedef id(^__generateBlock)(double progress, int random);

@interface NLTQGen : NSObject
+ (id)genWithGenerateBlock:(__generateBlock)block;
+ (id)genWithGenerateBlock:(__generateBlock)block miniumSeed:(int)minimumSeed maximumSeed:(int)maximumSeed;
- (id)valueWithProgress:(double)progress;
- (void)resizeWithMinimumSeed:(int)minimumSeed maximumSeed:(int)maximumSeed;
- (void)bindingGen:(NLTQGen*)gen;

// Combinators
+ (id)chooseGenWithLow:(int)low high:(int)high;
+ (id)elementsGenWithArray:(NSArray*)array;
+ (id)elementsGenWithObjects:(id)objects, ... NS_REQUIRES_NIL_TERMINATION; 
+ (id)randomGen;
+ (id)quadraticGenWithA:(int)a b:(int)b c:(int)c;
/*
 
 -- 外部入力やリソースから読み込んだジェネレーターを、テストに利用できるようにする
 promote :: Monad m => m (Gen a) -> Gen (m a)
 
 -- ジェネレーターを「生成された値が特定の条件に合うように」加工する
 suchThat :: Gen a -> (a -> Bool) -> Gen a
 
 -- ジェネレーターを「生成された値が特定の条件に合うなら Just, 合わなければ Nothing に」加工する
 suchThatMaybe :: Gen a -> (a -> Bool) -> Gen (Maybe a)
 
 -- ジェネレーターのリストから、一つ選ぶ
 oneof :: [Gen a] -> Gen a
 
 -- [(比率, ジェネレーター)] のリストから、偏りがあるようにジェネレーターを選ぶ
 frequency :: [(Int, Gen a)] -> Gen a
 
 -- 無限リストからジェネレーターを作る
 growingElements :: [a] -> Gen a
 
 -- ジェネレーターから、空リストを含む、リストのジェネレーターを作る
 listOf :: Gen a -> Gen [a]
 
 -- 空じゃない(最少でも一個は要素のある)リストのジェネレーターを作る
 listOf1 :: Gen a -> Gen [a]
 
 -- 固定長リスト
 vectorOf :: Int -> Gen a -> Gen [a]
*/
@end
