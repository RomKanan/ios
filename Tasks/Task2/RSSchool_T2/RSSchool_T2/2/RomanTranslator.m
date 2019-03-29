#import "RomanTranslator.h"

@implementation RomanTranslator


/////////////arabic to roman

- (NSString *)romanFromArabic:(NSString *)arabicString{
    
    NSMutableString* answer = [[[NSMutableString alloc] init] autorelease];
    
    [self translating:[arabicString integerValue] withKey:@"1000" withInOutResultingString:answer];
    
    NSLog(@"%@ in roman numerical is %@", arabicString, answer);
    
    return [[answer copy] autorelease];
    
}



- (void)appendToString:(NSMutableString*) string character:(char) chr nTimes:(NSInteger) n{
    for(NSInteger i = 0; i < n; i++){
        [string appendFormat:@"%c", chr];
    }
}

-(void)     translating:(NSInteger)arrab
                withKey:(NSString*)key
withInOutResultingString:(NSMutableString*)str{
    
    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:@'I', @"1", @'V', @"5", @'X', @"10",
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
    
    [dict release];
    
}

////////////////////// roman to arabic
- (NSString *)arabicFromRoman:(NSString *)romanString{
    
    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:   @"1",@"I", @"5", @"V", @"10", @"X",
                          @"50",@"L", @"100", @"C", @"500", @"D",
                          @"1000",@"M", nil];
    
    NSMutableArray* romanComponents = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < romanString.length; i++) {
        [romanComponents addObject:[romanString substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSInteger result = 0;
    
    for (NSInteger i = 0; i < romanComponents.count; i++)
    {
        if (i + 1 < romanComponents.count)
        {
            NSInteger checkingValue = [[dict valueForKey:[romanComponents objectAtIndex:i]] integerValue];
            NSInteger nextValue = [[dict valueForKey:[romanComponents objectAtIndex:i + 1]] integerValue];
            
            if (nextValue <= checkingValue)
            {
                result += checkingValue;
            } else
            {
                result -= checkingValue;
            }
        }
        else
        {
            NSInteger checkingValue = [[dict valueForKey:[romanComponents objectAtIndex:i]] integerValue];
            result += checkingValue;
        }
    }
    

    NSString* resultString = [[[NSString alloc] initWithFormat:@"%ld", result] autorelease];
    
    return resultString;
}
@end
