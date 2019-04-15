//
//  NSDate+DateMath.m
//  RSSchool_T3
//
//  Created by Roma on 4/14/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "NSDate+DateMath.h"

@implementation NSDate (DateMath)

-(NSDate*)rk_dateByAddingYears:(NSInteger)amount
{
    return [self dateByAddingUnit:NSCalendarUnitYear amount:amount];
}

-(NSDate*)rk_dateByAddingMonths:(NSInteger)amount
{
    return [self dateByAddingUnit:NSCalendarUnitMonth amount:amount];
}

-(NSDate*)rk_dateByAddingWeek:(NSInteger)amount{
    return [self dateByAddingUnit:NSCalendarUnitWeekOfYear amount:amount];
}

-(NSDate*)rk_dateByAddingDays:(NSInteger)amount
{
    return [self dateByAddingUnit:NSCalendarUnitDay amount:amount];
}

-(NSDate*)rk_dateByAddingHours:(NSInteger)amount
{
    return [self dateByAddingUnit:NSCalendarUnitHour amount:amount];
}

-(NSDate*)rk_dateByAddingMinutes:(NSInteger)amount
{
    return [self dateByAddingUnit:NSCalendarUnitMinute amount:amount];
}


-(NSDate*)dateByAddingUnit:(NSCalendarUnit)unit amount:(NSInteger)amount
{
    NSDateComponents * components = [[NSDateComponents alloc] init];
    [components setValue:amount forComponent:unit];
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components
                                                         toDate:self
                                                        options:nil];
}

@end
