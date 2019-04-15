//
//  NSDate+DateMath.h
//  RSSchool_T3
//
//  Created by Roma on 4/14/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (DateMath)

-(NSDate*)rk_dateByAddingYears:(NSInteger)amount;
-(NSDate*)rk_dateByAddingMonths:(NSInteger)amount;
-(NSDate*)rk_dateByAddingWeek:(NSInteger)amount;
-(NSDate*)rk_dateByAddingDays:(NSInteger)amount;
-(NSDate*)rk_dateByAddingHours:(NSInteger)amount;
-(NSDate*)rk_dateByAddingMinutes:(NSInteger)amount;


@end

NS_ASSUME_NONNULL_END
