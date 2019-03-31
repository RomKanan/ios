//
//  RKAssimilationInfo.m
//  RSSchool_T2
//
//  Created by Roma on 3/30/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "RKAssimilationInfo.h"

@interface RKAssimilationInfo ()
@property (nonatomic, assign) NSInteger years;
@property (nonatomic, assign) NSInteger months;
@property (nonatomic, assign) NSInteger weeks;
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, assign) NSInteger hours;
@property (nonatomic, assign) NSInteger minutes;
@property (nonatomic, assign) NSInteger seconds;


@end

@implementation RKAssimilationInfo

+ (instancetype)assimilationInfoFromString:(NSString*)dateString
{
    RKAssimilationInfo* info = [[RKAssimilationInfo alloc] init];
    NSDateFormatter* borgFormater = [[NSDateFormatter alloc] init];
    NSDateFormatter* humanFormater = [[NSDateFormatter alloc] init];
    NSString* assimilation =@"14 August 2208 03:13:37";
    
    borgFormater.dateFormat = @"yyyy:MM:dd@ss\\mm/HH";
    humanFormater.dateFormat = @"dd MMMM yyyy HH:mm:ss";
    
    NSDate* assimilationDate = [humanFormater dateFromString:assimilation];
    NSDate* date = [borgFormater dateFromString:dateString];
    
    [borgFormater release];
    [humanFormater release];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:(kCFCalendarUnitYear |
                                                         kCFCalendarUnitMonth |
                                                         kCFCalendarUnitDay |
                                                         kCFCalendarUnitHour |
                                                         kCFCalendarUnitMinute |
                                                         kCFCalendarUnitSecond)
                                               fromDate:date
                                                 toDate:assimilationDate
                                                options:NSCalendarWrapComponents];
    
    info.years = components.year;
    info.months = components.month;
    info.days = components.day;
    info.hours = components.hour;
    info.minutes = components.minute;
    info.seconds = components.second;

    return [info autorelease];
}

@end
