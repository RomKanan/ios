//
//  NSString+RKOnlyDigits.m
//  RSSchool_T4
//
//  Created by Roma on 4/19/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "NSString+RKOnlyDigits.h"

@implementation NSString (RKOnlyDigits)
- (NSMutableString*)rk_cleared{
    NSArray* array = [self componentsSeparatedByCharactersInSet:[NSCharacterSet decimalDigitCharacterSet].invertedSet];
    NSMutableString* answer = [NSMutableString string];
    for (NSString* string in array) {
        [answer appendString:string];
    }
    return [[answer copy] autorelease];
}

@end

