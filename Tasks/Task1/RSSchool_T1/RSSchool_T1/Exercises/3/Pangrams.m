#import "Pangrams.h"

@implementation Pangrams

// Complete the pangrams function below.
- (BOOL)pangrams:(NSString *)string {
    
    NSString* alphabet = @"abcdefghijklmnopqrstuvwxyz";
    
    for (NSInteger i = 0; i < [alphabet length]; i++ ) {
        NSString* letter = [NSString stringWithFormat:@"%c", [alphabet characterAtIndex:i]];
        if (![[string lowercaseString] containsString:letter ]) {
            return NO;
        }
    }
    
    return YES;
}

@end
