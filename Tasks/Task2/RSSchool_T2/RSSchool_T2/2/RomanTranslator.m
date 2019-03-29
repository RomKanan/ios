#import "RomanTranslator.h"

@implementation RomanTranslator


/////////////arabic for roman

- (NSString *)romanFromArabic:(NSString *)arabicString{
    
    NSMutableString* answer = [[NSMutableString alloc] init];
    
    [self translating:[arabicString integerValue] withKey:@"1000" withInOutResultingString:answer];
    
    NSLog(@"%@ in roman numerical is %@", arabicString, answer);
    return [answer copy];
    
}



- (void)appendToString:(NSMutableString*) string character:(char) chr nTimes:(NSInteger) n{
    for(NSInteger i = 0; i < n; i++){
        [string appendFormat:@"%c", chr];
    }
}

-(void) translating:(NSInteger) arrab withKey:(NSString*) key withInOutResultingString:(NSMutableString*) str{
    
    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:  @'I', @"1", @'V', @"5", @'X', @"10",
                          @'L', @"50", @'C', @"100", @'D', @"500",
                          @'M', @"1000", nil];
    
    NSArray* keys = [[dict allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        if ([obj1 integerValue] < [obj2 integerValue]){
            return NSOrderedDescending;
        } else {return NSOrderedAscending;}
    }];
    
    NSUInteger i = [keys indexOfObject:key];
    
    NSInteger n = arrab / [key integerValue];
    
    NSInteger newValue = arrab % [key integerValue];
    
    
    switch (n) {
        case 4:
            [self appendToString:str character:[[dict objectForKey:key] charValue] nTimes:1];
            [self appendToString:str character:[[dict objectForKey:keys[i - 1]] charValue] nTimes:1];
            break;
        case 9:
            [self appendToString:str character:[[dict objectForKey:key] charValue] nTimes:1];
            [self appendToString:str character:[[dict objectForKey:keys[i - 2]] charValue] nTimes:1];
            break;
        case 5:
            [self appendToString:str character:[[dict objectForKey:keys[i - 1]] charValue] nTimes:1];
            break;
            
        default:
            if (n < 4)
            {
                [self appendToString:str character:[[dict objectForKey:key] charValue] nTimes:n];
            }
            else
            {
                [self appendToString:str character:[[dict objectForKey:keys[i - 1]] charValue] nTimes:1];
                [self appendToString:str character:[[dict objectForKey:key] charValue] nTimes:(n - 5)];
            }
            break;
    }
    
    if ( !((i + 2) > keys.count) ) {
        [self translating:newValue withKey:keys[i + 2] withInOutResultingString:str];
    }
    
}

////////////////////// roman for arabic
- (NSString *)arabicFromRoman:(NSString *)romanString{
    return @"some strung";
}
@end
