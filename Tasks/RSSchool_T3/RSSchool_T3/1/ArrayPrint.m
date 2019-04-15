#import "ArrayPrint.h"

@implementation NSArray (RSSchool_Extension_Name)

- (NSString *)print
{
    NSMutableString* result = [NSMutableString stringWithFormat:@"["];
    for (NSUInteger i = 0; i < self.count; i++)
    {
        id object = [self objectAtIndex:i];
        
        if ([object isKindOfClass:[NSNull class]])
        {
            [result appendString:@"null"];
        }
        else if ([object isKindOfClass:[NSNumber class]])
        {
            [result appendFormat:@"%@", [object stringValue]];
        }
        else if ([object isKindOfClass:[NSString class]])
        {
            [result appendFormat:@"\"%@\"", object];
        }
        else if ([object isKindOfClass:[NSArray class]])
        {
            if ([(NSArray*)object count] == 0)
            {
                [result appendString:@"[]"];
            }
            else
            {
                [result appendString:[object print]];
            };
        }
        else
        {
            [result appendString:@"unsupported"];
        }
        
        if (i == self.count - 1)
        {
            [result appendString:@"]"];
        }
        else
        {
            [result appendString:@","];
        }
    }
        return result;
}

#pragma mark -auxiliaryForSecondTask
- (NSString *)trickyPrint
{
    NSMutableString* result = [NSMutableString stringWithFormat:@""];
    for (NSUInteger i = 0; i < self.count; i++)
    {
        id object = [self objectAtIndex:i];
        
        if ([object isKindOfClass:[NSNull class]])
        {
            [result appendString:@"null"];
        }
        else if ([object isKindOfClass:[NSNumber class]])
        {
            [result appendFormat:@"%@", [object stringValue]];
        }
        else if ([object isKindOfClass:[NSString class]])
        {
            [result appendFormat:@"\"%@\"", object];
        }
        else if ([object isKindOfClass:[NSArray class]])
        {
            if ([(NSArray*)object count] == 0)
            {
                [result appendString:@"[]"];
            }
            else
            {
                [result appendString:[object trickyPrint]];
            };
        }
        else
        {
            [result appendString:@"unsupported"];
        }
        
        if (i == self.count - 1)
        {
            [result appendString:@""];
        }
        else
        {
            [result appendString:@","];
        }
    }
    return result;
}
@end
