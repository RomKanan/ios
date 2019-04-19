//
//  NSString+RKOnlyDigits.h
//  RSSchool_T4
//
//  Created by Roma on 4/19/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (RKOnlyDigits)
- (NSMutableString*)rk_cleared;
@end

NS_ASSUME_NONNULL_END
