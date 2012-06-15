# NLTQucikCheck
like Haskell QuickCheck in Objective-C.

## Feature
QucikCheck is random test library. 
It generate random values, and run many test cases with the values.
Let's start Data Driven Testing.

## How to install 
CocoaPods](https://github.com/CocoaPods/)
```ruby
dependency 'NLTQuickCheck'
```

## Usage
### BDD style (Kiwi)
```objective-c
describe(@"QuickCheck", ^{
    it(@"BDD style example", ^{
        NLTQTestable *testable = [NLTQTestable testableWithPropertyBlockArguments2:^BOOL(id argA, id argB) {
            return [Math add:[argA intValue] b:[argB intValue]] == [argA intValue] + [argB intValue];
        } arbitraries:[NSNumber intArbitrary], [NSNumber intArbitrary], nil];
        [testable check];
        [[theValue([testable success]) should] beYes];
        NSLog(@"%@", [testable prettyReport]);
    });
});
// Tests: 100
//   ✓ Successes	: 100
//   ✗ Failures	    : 0
//   ✷ Exceptions	: 0
```

### xUnit style (OCUnit)
```objective-c
- (BOOL)propAdd:(NSNumber*)a b:(NSNumber*)b {
    return [Math add:[a intValue] b:[b intValue]] == [a intValue] + [b intValue];
}
- (void)testQuickCheckXUnitStyleExample {
    NLTQTestable *testable = [NLTQTestable testableWithPropertySelector:@selector(propAdd:b:) 
                                                                 target:self
                                                            arbitraries:[NSNumber intArbitrary], [NSNumber intArbitrary], nil];
    [testable check];
    STAssertTrue([testable success], @"%@", [testable prettyReport]);
}
// Tests: 100
//   ✓ Successes	: 100
//   ✗ Failures	    : 0
//   ✷ Exceptions	: 0
```

### Failure (Exception) Case
```objective-c
it(@"failure case", ^{
    NLTQTestable *testable = [NLTQTestable testableWithPropertyBlockArguments2:^BOOL(id argA, id argB) {
        return [argA intValue] - [argB intValue] > 0;
    } arbitraries:[NSNumber intArbitrary], [NSNumber intArbitrary], nil];
    [testable verboseCheck];
    [[theValue([testable success]) should] beYes];
    NSLog(@"%@", [testable prettyReport]);  
});
//Tests: 100
//  ✓ Successes	: 29
//  ✗ Failures  : 71
//    ✗ Failure  : ( 0 , 0 )
//    ✗ Failure  : ( 0 , 0 )
//    ✗ Failure  : ( 0 , 0 )
//    ✗ Failure  : ( -38 , 51 )
//    ✗ Failure  : ( -38 , 51 )
//    ✗ Failure  : ( -38 , 51 )
//    ✗ Failure  : ( -102 , 94 )
//    ✗ Failure  : ( -102 , 94 )
//    ✗ Failure  : ( -102 , 94 )
//    ✗ Failure  : ( 206 , 502 )
//    ....
//    ✗ Failure  : ( -8537 , 26611 )
//  ✷ Exceptions: 0
```

## Default Arbitraries
### NSString
* `[NSString arbitary]`
* `[NSString alphabetStringArbitrary]`

### NSNumber
* `[NSNumber intArbitrary]`
* `[NSNumber nonZeroIntArbitrary]`
* `[NSNumber doubleArbitrary]`
* `[NSNumber boolArbitrary]`
