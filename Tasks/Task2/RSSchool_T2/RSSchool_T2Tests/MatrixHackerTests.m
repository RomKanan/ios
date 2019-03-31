#import <XCTest/XCTest.h>
#import "MatrixHacker.h"

@interface MatrixHackerTests : XCTestCase
@property (nonatomic, strong) MatrixHacker *hacker;
@property (nonatomic, retain) NSArray *people;
@end

@interface Char : NSObject <Character>
@property (nonatomic, retain) NSString* name;
@property (nonatomic, assign) BOOL isClone;

- (NSString *)name;
- (BOOL)isClone;
+ (instancetype)createWithName:(NSString *)name isClone:(BOOL)clone;
@end

@implementation Char
- (NSString *)name
{
    return [self name];
}
- (BOOL)isClone
{
    return [self isClone];
}
+ (instancetype)createWithName:(NSString *)name isClone:(BOOL)clone
{
    Char * newChar = [[[Char alloc] init] autorelease];
    
    newChar.name = name;
    if ([name isEqualToString:@"Neo"])
    {
        newChar.isClone = NO;
    }
    else
    {
        newChar.isClone = YES;
    }
    
    return newChar;
}

@end

@implementation MatrixHackerTests

- (void)setUp {
  self.hacker = [MatrixHacker new];
  self.people = @[@"Delivery Guy", @"Neo", @"Policeman", @"Agent John", @"Agent Black", @"Bartender"];
}

- (void)test1 {
  __block NSInteger counter = 0;
  [self.hacker injectCode:^id<Character>(NSString *name) {
      
    counter += 1;
    return [Char createWithName:name isClone:YES];
  }];
  [self.hacker runCodeWithData:self.people];
  XCTAssertTrue(self.people.count == counter);
}


@end
