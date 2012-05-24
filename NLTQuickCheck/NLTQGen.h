//
//  NLTQGen.h
//  NLTQuickCheck
//
//  Created by KAZUMA Ukyo on 12/05/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLTQStandardGen.h"

#define kNLTQGenDefaultMiniumSedd   (0)
#define kNLTQGenDefaultMaxiumSeed   (1000)

typedef id(^__generateBlock)(double progress);

@interface NLTQGen : NSObject
+ (id)genWithGenerateBlock:(__generateBlock)block;
+ (id)genWithGenerateBlock:(__generateBlock)block miniumSeed:(NSInteger)minimumSeed maximumSeed:(NSInteger)maxiumSeed;
- (id)valueWithProgress:(double)progress;

// Combinators
+ (NSInteger)chooseWithLow:(NSInteger)low high:(NSInteger)high;
+ (id)objectAtRandomIndexFromArray:(NSArray*)array;
/*
 -- ランダムに値を生成できる2つの値の組から、その範囲内のジェネレーターを作る
 choose :: Random a => (a, a) -> Gen a
 
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
 
 -- リストの中から一個
 elements :: [a] -> Gen a
 
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
