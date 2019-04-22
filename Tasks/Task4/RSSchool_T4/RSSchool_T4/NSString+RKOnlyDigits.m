//
//  NSString+RKOnlyDigits.m
//  RSSchool_T4
//
//  Created by Roma on 4/19/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "NSString+RKOnlyDigits.h"

@implementation NSString (RKOnlyDigits)
- (NSString*)rk_cleared{
    NSArray* array = [self componentsSeparatedByCharactersInSet:[NSCharacterSet decimalDigitCharacterSet].invertedSet];
    NSString* answer = [array componentsJoinedByString:@""];
    return answer;
}

@end

