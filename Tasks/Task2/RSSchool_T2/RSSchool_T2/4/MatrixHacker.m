#import "MatrixHacker.h"
// your code here

@interface MatrixHacker ()

@property (copy) id<Character> (^neoBlock)(NSString* name);
@end

@implementation MatrixHacker

-(void)injectCode:(id<Character> (^)(NSString *))theBlock
{
    self.neoBlock = theBlock;
}

- (NSArray<id<Character>> *)runCodeWithData:(NSArray<NSString *> *)names
{
    NSMutableArray* outputArray = [[[NSMutableArray alloc] init] autorelease];
    for (NSString* name in names)
    {
        if(self.neoBlock)
        {
            id<Character> character = self.neoBlock(name);
            [outputArray addObject:character];
        }
    }
    return outputArray;
}

- (void)dealloc
{
    [_neoBlock release];
    [super dealloc];
}
@end
