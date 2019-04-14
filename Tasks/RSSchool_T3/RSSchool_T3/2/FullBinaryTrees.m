#import "FullBinaryTrees.h"
#import "ArrayPrint.h"

@implementation FullBinaryTrees : NSObject

- (NSString *)stringForNodeCount:(NSInteger)count
{
    if (count == 1) {
        return @"[[0]]";
    }
    
    if (count == 3) {
        return @"[[0,0,0]]";
    }
    
    
    if (((count - 1) % 2 != 0) ||  count <= 0)
    {
        return @"[]";
    }
    
    NSMutableArray* arrayOfAnswers = [NSMutableArray array];
    
    NSArray* OO = [NSArray arrayWithObjects:@0, @0, nil];
    NSArray* nullnull = [NSArray arrayWithObjects:[NSNull  null], [NSNull  null], nil];
    
    NSMutableArray* start =[NSMutableArray arrayWithObjects:@0,OO, nil];
    
    NSArray* arrayOfCombinations = [NSArray arrayWithObject:start];
    
    for (NSInteger i = 0; i < (count - 3); i++) {
        NSMutableArray* tempOO = [NSMutableArray array];
        NSMutableArray* tempNullNull = [NSMutableArray array];
        NSMutableArray* tempAnswers = [NSMutableArray array];
        
        for (NSMutableArray* element in arrayOfCombinations) {
            NSMutableArray* tempElement = [[element mutableCopy] autorelease];
            [tempElement addObject:OO];
            [tempOO addObject:tempElement];
        }
        
        for (NSMutableArray* element in arrayOfCombinations) {
            NSMutableArray* tempElement = [[element mutableCopy] autorelease];
            [tempElement addObject:nullnull];
            [tempNullNull addObject:tempElement];
            
        }
        [tempAnswers addObjectsFromArray:tempOO];
        [tempAnswers addObjectsFromArray:tempNullNull];
        arrayOfCombinations = [[tempAnswers copy] autorelease];
    }

    for (NSMutableArray* combianation in arrayOfCombinations)
    {
        
        NSCountedSet* set = [NSCountedSet setWithArray:combianation];
        
        NSUInteger countOfOO = [set countForObject:OO];
        NSUInteger countOfNullNull = [set countForObject:nullnull];
        
        if ( countOfOO == (count - 1) / 2 &&
            countOfNullNull == ((count - 1) / 2) - 1  )
        {
            while ([combianation lastObject] == nullnull)
            {
                [combianation removeLastObject];
            }
            
            NSString* combinationString = [combianation trickyPrint];
            
            if ([self canBeTree:combinationString])
            {
                [arrayOfAnswers addObject:[NSString stringWithFormat:@"[%@]",combinationString]];
            }
        }
    }
    

    NSString* debug =  [arrayOfAnswers print];
    return debug;
}

- (NSString*) lastObjectOfArray:(NSMutableArray*)array moveToIndex:(NSUInteger)index
{
    NSArray* lastObject = [array lastObject];
    [array insertObject:lastObject atIndex:index];
    [array removeLastObject];
    return [array trickyPrint];
}

- (BOOL) canBeTree:(NSString*)string
{
    NSArray* testingElements = [string componentsSeparatedByString:@","];
    
    NSInteger nods = 0;
    NSInteger nools = 0;
    
    for (NSString* element in testingElements)
    {
        if ([element isEqualToString:@"0"])
        {
            nods++;
        }
        else
        {
            nools++;
        }
        
        if (nools >= nods)
        {
            return NO;
        }
    }
    return YES;
}

@end


