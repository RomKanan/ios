#import "KidnapperNote.h"

@implementation KidnapperNote
- (BOOL)checkMagazine:(NSString *)magaine note:(NSString *)note{
    
    __block BOOL answer = YES;
    
    NSString* lowercasedMagazine = [magaine lowercaseString];
    NSString* lowercasedNote = [note lowercaseString];
    
    
    NSArray* wordsFromMagazine = [lowercasedMagazine componentsSeparatedByString:@" "];
    NSArray* wordsFromNote = [lowercasedNote componentsSeparatedByString:@" "];
    
    
    NSCountedSet* setFromMag = [[NSCountedSet alloc] initWithArray:wordsFromMagazine];
    NSCountedSet* setFromNote = [[NSCountedSet alloc] initWithArray:wordsFromNote];
    
    if ([setFromNote isSubsetOfSet:setFromMag])
    {
        [setFromNote enumerateObjectsUsingBlock:^(NSString* word, BOOL * _Nonnull stop)
         {
             
             if ([setFromMag countForObject:word] < [setFromNote countForObject:word])
             {
                 answer = NO;
                 *stop = YES;
             }
             
         }];
        
    } else
        
    {
        answer = NO;
    }
    
    [setFromMag release];
    [setFromNote release];
    
    
    return answer;
    
    
    
    
}
@end
