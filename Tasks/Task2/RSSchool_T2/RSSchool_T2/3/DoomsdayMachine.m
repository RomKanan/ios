#import "DoomsdayMachine.h"
#import "RKAssimilationInfo.h"

@implementation DoomsdayMachine



- (id<AssimilationInfo>)assimilationInfoForCurrentDateString:(NSString *)dateString
{
    return [RKAssimilationInfo assimilationInfoFromString:dateString];
}


- (NSString *)doomsdayString
{
    NSString* assimilation =@"14 August 2208 03:13:37";

    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"dd MMMM yyyy HH:mm:ss";
    NSDate* assimilationDate = [formater dateFromString:assimilation];
    [formater release];
    
    NSDateFormatter* humanFormater = [[NSDateFormatter alloc] init];
    humanFormater.dateFormat = @"EEEE, MMMM dd, yyyy";
    NSString* doomsdayStrig = [humanFormater stringFromDate:assimilationDate];
    [humanFormater release];
    
    return doomsdayStrig;
}
@end
