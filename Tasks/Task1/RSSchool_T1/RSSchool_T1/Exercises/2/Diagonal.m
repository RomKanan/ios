#import "Diagonal.h"

@implementation Diagonal

// Complete the diagonalDifference function below.
- (NSNumber *) diagonalDifference:(NSArray *)array {
    
    NSInteger answer = 0;
    NSInteger primaryDiagSum = [self diagonalCountFromArray:array isPrimary:YES];
    NSInteger secondryDiagSum = [self diagonalCountFromArray:array isPrimary:NO];
    
    if (primaryDiagSum >= secondryDiagSum){
        answer = ABS(primaryDiagSum - secondryDiagSum);
    } else {
        answer = ABS(secondryDiagSum - primaryDiagSum);
    }
    
    return [[[NSNumber alloc] initWithInteger:answer] autorelease];
}

- (NSInteger) diagonalCountFromArray: (NSArray*) array isPrimary:(BOOL) primary {
    
    NSInteger sum = 0;
    NSInteger i = primary ? 1 : -1;
    NSInteger startingPoint = primary ? 0 : [array count] - 1;

    for (NSString *row in array) {
        NSArray* arrayRow = [row componentsSeparatedByString:@" "]; 
        sum += [arrayRow[startingPoint] integerValue ];
        startingPoint += i;
    }
    
    return sum;
}

@end

