#import "Sorted.h"

@implementation ResultObject

- (void) setDetail:(NSString *)detail {
    if (detail != _detail) {
        [_detail release];
        _detail = [[NSString alloc] initWithString:detail];
    }
}

- (void)dealloc
{
    if (_detail) {
        [_detail release];
        [super dealloc];
    }
}


@end

@implementation Sorted

////////////
BOOL isArraySorted(NSArray* arr){
    BOOL result = YES;
    for (NSInteger i = 0; i < [arr count] - 1; i++) {
        if ( !([arr[i] integerValue] < [arr[i + 1] integerValue]) ){
            result = NO;
            break;
        }
    }
    
    return result;
}


///////////////
NSArray* reversedArray(NSArray* arr) {
    NSMutableArray* reverced = [[NSMutableArray alloc] init] ;
    
    for (NSInteger i = [arr count] - 1; i >= 0; i-- ){
        [reverced addObject:arr[i]];
    }
    NSArray* answer = [[[NSArray alloc] initWithArray:reverced] autorelease];
    [reverced release];
    return answer;
}


// Complete the sorted function below.

- (ResultObject*)sorted:(NSString*)string {
    ResultObject *value = [[[ResultObject alloc] init] autorelease];
    
    NSArray* arr =[string componentsSeparatedByString:@" "];
    
    if (isArraySorted(arr)) {
    
        value.status = YES;
    
    } else {
        
        NSInteger pointOfBreak = 0;
        NSString* breakValue = nil;
        
        NSInteger siutable = 0;
        NSString* siutableValue = nil;
        
        for (NSInteger i = 0; i < [arr count] - 1; i++) {
            if ( !([arr[i] integerValue] < [arr[i + 1] integerValue]) ){
                pointOfBreak = i;
                breakValue = [arr objectAtIndex:pointOfBreak];
                break;
            }
        }
        
        if (pointOfBreak == 0) {
            for (NSInteger i = 0; i < [arr count]; i++) {
                
                if ([arr[i] integerValue] < [breakValue integerValue]) {
                    
                    siutable = i;
                    siutableValue = arr[siutable];
                    break;
                }
            }
        } else {
        
            for (NSInteger i = pointOfBreak; i < [arr count]; i++) {

                if (([arr[i] integerValue] > [arr[pointOfBreak - 1] integerValue]) &&
                    ([arr[i] integerValue] < [arr[pointOfBreak + 1] integerValue]) ) {
                
                    siutable = i;
                    siutableValue = arr[siutable];
                    break;
                }
            }
        }
        
        NSMutableArray* mutableArr = [NSMutableArray arrayWithArray:arr];
        [mutableArr removeObjectAtIndex:pointOfBreak];
        if(siutableValue) {
            [mutableArr insertObject:siutableValue atIndex:pointOfBreak];
        }

        [mutableArr removeObjectAtIndex:siutable];
       
        if (breakValue) {
            [mutableArr insertObject:breakValue atIndex:siutable];
        }
        
        if (isArraySorted(mutableArr)) {
            value.status = YES;
            value.detail = [NSString stringWithFormat:@"swap %ld %ld", pointOfBreak + 1, siutable + 1];
        } else {
            
            NSInteger pointOfBreakRev = 0;
            
            NSInteger secondBreak = 0;
            
            for (NSInteger i = 0; i < [arr count] - 1; i++) {
                if ( !([arr[i] integerValue] < [arr[i + 1] integerValue]) ){
                    pointOfBreakRev = i;
                    break;
                }
            }
            
            for (NSInteger i = pointOfBreakRev; i < [arr count] - 1; i++) {
                if (!([arr[i] integerValue] > [arr[i + 1] integerValue])) {
                    secondBreak = i;
                    break;
                }
            }
            NSRange myRangge = NSMakeRange(pointOfBreakRev, secondBreak - pointOfBreakRev + 1);
            
            NSArray* subArr = [arr subarrayWithRange:myRangge];
            
            NSMutableArray* mutableArr = [NSMutableArray arrayWithArray:arr];
            
            [mutableArr replaceObjectsInRange:myRangge withObjectsFromArray:reversedArray(subArr)];
            
            if (isArraySorted(mutableArr)){
                value.status = YES;
                value.detail = [NSString stringWithFormat:@"reverse %ld %ld", pointOfBreakRev + 1, secondBreak + 1];
            } else {
                value.status = NO;
            }
            
        }
    }
    
    return value;
}


@end

