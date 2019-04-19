//
//  RKViewController.m
//  RSSchool_T4
//
//  Created by Roma on 4/19/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "RKViewController.h"
#import "NSString+RKOnlyDigits.h"

@interface RKViewController () <UITextFieldDelegate>
@property (retain, nonatomic) UIView* rootView;
@property (retain, nonatomic) UIImageView* flagView;
@property (retain, nonatomic) UILabel* tempLabel;
@property (retain, nonatomic) UITextField* phoneTextField;
@end

@implementation RKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView* root = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 50.f, 50.f)];
    self.rootView = root;
    [root release];
    self.rootView.center = CGPointMake(self.view.center.x, self.view.bounds.size.height / 6);
    self.rootView.layer.borderWidth = 2.f;
    self.rootView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.rootView.layer.cornerRadius = 15.f;
    [self.view addSubview:self.rootView];
    
    
    UIImageView* flag = [[UIImageView alloc] initWithFrame:CGRectMake(self.rootView.bounds.origin.x + 4,
                                                                      self.rootView.bounds.origin.y + 4,
                                                                      self.rootView.bounds.size.width / 5.f,
                                                                      self.rootView.bounds.size.height - 8)];
    self.flagView = flag;
    [flag release];
    
    self.flagView.layer.borderWidth = 0.5;
    self.flagView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.flagView.layer.cornerRadius = 15.f;
    [self.rootView addSubview:self.flagView];
    
    UILabel* temp = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              self.flagView.frame.size.width / 10 * 8,
                                                              self.flagView.frame.size.height / 10 * 8)];
    
    self.tempLabel = temp;
    [temp release];
    self.tempLabel.center = self.flagView.center;
    self.tempLabel.text = @"Number:";
    self.tempLabel.adjustsFontSizeToFitWidth = YES;
    self.tempLabel.textAlignment = NSTextAlignmentCenter;
    [self.rootView addSubview:self.tempLabel];
    
    UITextField* phone = [[UITextField alloc] initWithFrame:CGRectMake(self.flagView.frame.origin.y +
                                                                       self.flagView.frame.size.width + 5.f,
                                                                       self.flagView.frame.origin.y,
                                                                       self.rootView.bounds.size.width / 5.f * 3.7f,
                                                                       self.rootView.bounds.size.height - 8.f)];
    self.phoneTextField = phone;
    [phone release];
    
    CALayer* bottomLine  = [CALayer layer];
    bottomLine.frame = CGRectMake(self.phoneTextField.bounds.origin.x,
                                  self.phoneTextField.bounds.origin.y + self.phoneTextField.bounds.size.height - 3,
                                  self.phoneTextField.frame.size.width,
                                  2.f);
    
    bottomLine.borderWidth = 4.f;
    bottomLine.borderColor = [UIColor blackColor].CGColor;
    [self.phoneTextField.layer addSublayer:bottomLine];
    
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTextField.delegate = self;
    self.phoneTextField.textContentType = UITextContentTypeTelephoneNumber;
    
    [self.rootView addSubview:self.phoneTextField];
}

#pragma mark -textFieldDelegate
//Обработка номеров текстфилда
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet* phoneCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789 +-#*()"];
    
    if(![phoneCharacterSet isSupersetOfSet:[NSCharacterSet characterSetWithCharactersInString:string]])
    {
        return NO;
    }
    
    
    if((range.location == 0) && ![string isEqualToString:@"+"] && ![string hasPrefix:@"+"] && (string.length != 0) )
    {
        textField.text = @"+";
        range.location += 1;
    }
    
    NSMutableString* contextOfField = [NSMutableString stringWithString:textField.text];
    [contextOfField replaceCharactersInRange:range withString:string];
    NSString* onlyDigits = [contextOfField rk_cleared];
    
    if (onlyDigits.length > 12)
    {
        textField.text = [NSString stringWithFormat:@"+%@", onlyDigits];
        self.flagView.image = nil;
        self.tempLabel.text = @"ERROR";
        self.tempLabel.textColor = [UIColor redColor];
        [self.rootView bringSubviewToFront:self.tempLabel];
        return NO;
    }
  
    NSString* letteCode = [self countryCode:onlyDigits];
    
    if (letteCode)
    {
        self.flagView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag_%@",letteCode]];
        [self.rootView bringSubviewToFront:self.flagView];
    }
    else
    {
        self.flagView.image = nil;
        self.tempLabel.text = @"Number:";
        self.tempLabel.textColor = [UIColor blackColor];
        [self.rootView bringSubviewToFront:self.tempLabel];
    }
    
    NSArray* tenDigitsCounrty = [NSArray arrayWithObjects:@"KZ", @"RU", nil];
    NSArray* eightDigitsCountry = [NSArray arrayWithObjects:@"MD", @"AM", @"TM", nil];
    
    NSString* removingString = [textField.text substringWithRange:range];
    BOOL delitingFormat = YES;
    if ([removingString isEqualToString:@")"] || [removingString isEqualToString:@"("] ||
        [removingString isEqualToString:@" "] || [removingString isEqualToString:@"-"] )
    {
        delitingFormat = NO;
    }
    
     // Код для стран с 10ти значными номерами
    if (letteCode && delitingFormat)
    {
        if ([tenDigitsCounrty containsObject:letteCode])
        {
            if (onlyDigits.length > 1 && onlyDigits.length < 5 && string.length != 0)
            {
                NSMutableString * returnString = [onlyDigits mutableCopy];
                [returnString insertString:@" (" atIndex:1];
                [returnString appendString:@") "];
                textField.text = [NSString stringWithFormat:@"+%@", returnString];
                [returnString release];
                return NO;
            }
            if (onlyDigits.length > 7 && onlyDigits.length < 10)
            {
                NSMutableString * returnString = [onlyDigits mutableCopy];
                [returnString insertString:@" (" atIndex:1];
                [returnString insertString:@") " atIndex:6];
                [returnString insertString:@" " atIndex:11];
                textField.text = [NSString stringWithFormat:@"+%@", returnString];
                [returnString release];
                return NO;
            }
            if (onlyDigits.length > 9 && onlyDigits.length < 12)
            {
                NSMutableString * returnString = [onlyDigits mutableCopy];
                [returnString insertString:@" (" atIndex:1];
                [returnString insertString:@") " atIndex:6];
                [returnString insertString:@" " atIndex:11];
                [returnString insertString:@" " atIndex:14];
                textField.text = [NSString stringWithFormat:@"+%@", returnString];
                [returnString release];
                return NO;
            }
            if (onlyDigits.length > 11) {
                textField.text = [NSString stringWithFormat:@"+%@", onlyDigits];
                self.flagView.image = nil;
                self.tempLabel.text = @"Unknown";
                self.tempLabel.textColor = [UIColor redColor];
                [self.rootView bringSubviewToFront:self.tempLabel];
                return NO;
            }
        }
        // Код для стран с 8ми значными номерами
        else if ([eightDigitsCountry containsObject:letteCode])
        {
            if (onlyDigits.length > 3 && onlyDigits.length < 6 && string.length != 0)
            {
                NSMutableString * returnString = [onlyDigits mutableCopy];
                [returnString insertString:@" (" atIndex:3];
                [returnString appendString:@") "];
                textField.text = [NSString stringWithFormat:@"+%@", returnString];
                [returnString release];
                return NO;
            }
            if (onlyDigits.length > 7 && onlyDigits.length < 12)
            {
                NSMutableString * returnString = [onlyDigits mutableCopy];
                [returnString insertString:@" (" atIndex:3];
                [returnString insertString:@") " atIndex:7];
                [returnString insertString:@"-" atIndex:12];
                textField.text = [NSString stringWithFormat:@"+%@", returnString];
                [returnString release];
                return NO;
            }
            
            if (onlyDigits.length > 11) {
                textField.text = [NSString stringWithFormat:@"+%@", onlyDigits];
                self.flagView.image = nil;
                self.tempLabel.text = @"Unknown";
                self.tempLabel.textColor = [UIColor redColor];
                [self.rootView bringSubviewToFront:self.tempLabel];
                return NO;
            }
        }
        else
        {
            // Код для стран с 9ти значными номерами

            if (onlyDigits.length > 3 && onlyDigits.length < 6 && string.length != 0)
            {
                NSMutableString * returnString = [onlyDigits mutableCopy];
                [returnString insertString:@" (" atIndex:3];
                [returnString appendString:@") "];
                textField.text = [NSString stringWithFormat:@"+%@", returnString];
                [returnString release];
                return NO;
            }
            if (onlyDigits.length > 7 && onlyDigits.length < 10)
            {
                NSMutableString * returnString = [onlyDigits mutableCopy];
                [returnString insertString:@" (" atIndex:3];
                [returnString insertString:@") " atIndex:7];
                [returnString insertString:@"-" atIndex:12];
                textField.text = [NSString stringWithFormat:@"+%@", returnString];
                [returnString release];
                return NO;
            }
            if (onlyDigits.length > 9 && onlyDigits.length < 13)
            {
                NSMutableString * returnString = [onlyDigits mutableCopy];
                [returnString insertString:@" (" atIndex:3];
                [returnString insertString:@") " atIndex:7];
                [returnString insertString:@"-" atIndex:12];
                [returnString insertString:@"-" atIndex:15];
                textField.text = [NSString stringWithFormat:@"+%@", returnString];
                [returnString release];
                return NO;
            }
       }
    }

    return YES;
}

- (NSString*)countryCode:(NSString*)numbers
{
    if ([numbers hasPrefix:@"77"])
    {
        return @"KZ";
    }
    else if ([numbers hasPrefix:@"7"])
    {
        return @"RU";
    }
    else if ([numbers hasPrefix:@"373"])
    {
        return @"MD";
    }
    else if ([numbers hasPrefix:@"374"])
    {
        return @"AM";
    }
    else if ([numbers hasPrefix:@"375"])
    {
        return @"BY";
    }
    else if ([numbers hasPrefix:@"380"])
    {
        return @"UA";
    }
    else if ([numbers hasPrefix:@"992"])
    {
        return @"TJ";
    }
    else if ([numbers hasPrefix:@"993"])
    {
        return @"TM";
    }
    else if ([numbers hasPrefix:@"994"])
    {
        return @"AZ";
    }
    else if ([numbers hasPrefix:@"996"])
    {
        return @"KG";
    }
    else if ([numbers hasPrefix:@"998"])
    {
        return @"UZ";
    }
    return nil;
}

- (void)dealloc
{
    [_rootView release];
    [_flagView release];
    [_tempLabel release];
    [_phoneTextField release];
    [super dealloc];
}


@end
