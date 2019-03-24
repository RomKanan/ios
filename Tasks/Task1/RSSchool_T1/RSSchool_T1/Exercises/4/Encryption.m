#import "Encryption.h"

@implementation Encryption

// Complete the encryption function below.
- (NSString *)encryption:(NSString *)string {
    
    double lenght = [string length];
    double bounds = sqrt(lenght);
    
    NSInteger row = bounds;
    NSInteger collumn = 0;
    
    if ((double)row == bounds) {
        collumn = row;
    } else {
        collumn = row + 1;
    }
    
    
    if (!(row * collumn >= lenght)) {
        row += 1;
        collumn = row;
    }
    
    NSInteger index = 0;
    NSMutableArray* array = [[NSMutableArray alloc ] init];
    
    for (NSInteger i = 0; i < row - 1; i++) {
        [array addObject:[string substringWithRange:NSMakeRange(index, collumn)]];
        index += collumn;
    }
    [array addObject:[string substringFromIndex:index]];
    
    NSMutableString* encrypted = [[NSMutableString alloc] init];
    
    for (NSInteger i = 0; i < collumn; i++){
        NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        
        NSMutableString* tempEncrypt = [[[NSMutableString alloc] init] autorelease];
        
        for (NSInteger j = 0; j < row; j++) {
            
            NSString* tempString = array[j];
            NSInteger stringLenght = [tempString length];
            if (i - 1 >= stringLenght - 1 ) {break;}
            unichar tempChar = [tempString characterAtIndex:i];
            [tempEncrypt appendString: [NSString stringWithCharacters:&tempChar length:1]];
        }
        
        [encrypted appendString:tempEncrypt];
        
        if (i < collumn - 1) {
            [encrypted appendString:@" "];
        }
        [pool drain];
    }
    
    [array release];
    
    NSString * retString = [[encrypted copy] autorelease];
    [encrypted release];
    
    return  retString;
}

@end
