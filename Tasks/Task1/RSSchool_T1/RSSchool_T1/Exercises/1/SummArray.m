#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    
    NSInteger sum = 0;
    
    for (NSNumber *number in array) {
        sum += [number integerValue];
    }

    return [[[NSNumber alloc] initWithInteger:sum] autorelease];
}

@end

