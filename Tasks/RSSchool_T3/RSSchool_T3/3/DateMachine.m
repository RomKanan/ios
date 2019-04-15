#import "DateMachine.h"
#import "NSDate+DateMath.h"

@interface DateMachine () <UITextFieldDelegate>
@property (retain,nonatomic) NSDateFormatter* dateFormater;
@property (retain,nonatomic) UILabel* outputDateLabel;
@property (retain,nonatomic) UITextField* startDateTextField;
@property (retain,nonatomic) UITextField* stepTextField;
@property (retain,nonatomic) UITextField* dateUnitTextField;
@property (retain,nonatomic) UIButton* addButton;
@property (retain,nonatomic) UIButton* subButton;

@end

@implementation DateMachine
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"dd/MM/yyyy HH:mm";
    self.dateFormater = formater;
    [formater release];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UILabel* outputDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300.f, 100.f)];
    self.outputDateLabel = outputDate;
    [outputDate release];
    self.outputDateLabel.center = CGPointMake(self.view.center.x, self.view.frame.origin.y + self.outputDateLabel.frame.size.height);
    self.outputDateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.outputDateLabel.text = [formater stringFromDate:[NSDate date]];
    self.outputDateLabel.font = [UIFont systemFontOfSize:30 weight:UIFontWeightHeavy];
    self.outputDateLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.outputDateLabel];
    
    UITextField* startDateLabel = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300.f, 50.f)];
    self.startDateTextField = startDateLabel;
    [startDateLabel release];
    self.startDateTextField.center = CGPointMake(self.view.center.x,
                                        self.outputDateLabel.center.y + self.startDateTextField.frame.size.height + 50.f);
    self.startDateTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    self.startDateTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.startDateTextField.layer.borderWidth = 2.f;
    self.startDateTextField.layer.cornerRadius = 6.f;
    self.startDateTextField.placeholder = @"Start date";
    self.startDateTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.stepTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.startDateTextField.delegate = self;

    [self.view addSubview:self.startDateTextField];
    
    UITextField* stepTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300.f, 50.f)];
    self.stepTextField = stepTextField;
    [stepTextField release];
    self.stepTextField.center = CGPointMake(self.view.center.x,
                                   self.startDateTextField.center.y + self.stepTextField.frame.size.height + 50.f);
    self.stepTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    self.stepTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.stepTextField.layer.borderWidth = 2.f;
    self.stepTextField.layer.cornerRadius = 6.f;
    self.stepTextField.placeholder = @"Step";
    self.stepTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.stepTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.stepTextField.delegate = self;
    
    [self.view addSubview:self.stepTextField];
    
    UITextField* dateUnitTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300.f, 50.f)];
    self.dateUnitTextField = dateUnitTextField;
    [dateUnitTextField release];
    self.dateUnitTextField.center = CGPointMake(self.view.center.x,
                                      self.stepTextField.center.y + self.stepTextField.frame.size.height + 50.f);
    self.stepTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    self.dateUnitTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.dateUnitTextField.layer.borderWidth = 2.f;
    self.dateUnitTextField.layer.cornerRadius = 6.f;
    self.dateUnitTextField.placeholder = @"Date unit";
    self.dateUnitTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.dateUnitTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.dateUnitTextField.delegate = self;
    
    [self.view addSubview:self.dateUnitTextField];
    
    UIButton* addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    addButton.frame = CGRectMake(0, 0, 100, 50);
    self.addButton = addButton;
    
    self.addButton.center = CGPointMake(self.view.center.x + self.addButton.frame.size.width / 2 + 30,
                                  self.dateUnitTextField.center.y + self.addButton.frame.size.height + 30);
    self.addButton.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    self.addButton.layer.borderWidth = 3.f;
    self.addButton.layer.borderColor = [UIColor greenColor].CGColor;
    self.addButton.layer.cornerRadius = 12.f;
    [self.addButton addTarget:self action:@selector(addPushed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addButton];
    
    UIButton* subButton = [UIButton buttonWithType:UIButtonTypeSystem];
    subButton.frame = CGRectMake(0, 0, 100, 50);
    self.subButton = subButton;
    
    self.subButton.center = CGPointMake(self.view.center.x - self.subButton.frame.size.width / 2 - 30,
                                  self.dateUnitTextField.center.y + self.subButton.frame.size.height + 30);
    self.subButton.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    [self.subButton setTitle:@"Sub" forState:UIControlStateNormal];
    [self.subButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.subButton.layer.borderWidth = 3.f;
    self.subButton.layer.borderColor = [UIColor redColor].CGColor;
    self.subButton.layer.cornerRadius = 12.f;
    [self.subButton addTarget:self action:@selector(subPushed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.subButton];
}

-(void)addPushed:(id)sender
{
    [self addingUnit:YES];
}

-(void)subPushed:(id)sender
{
       [self addingUnit:NO];
}

-(BOOL)startDateTextIsValid
{
    if ([self.startDateTextField.text isEqualToString:@""])
    {
        return YES;
    }
   
    if ([self.dateFormater dateFromString:self.startDateTextField.text])
    {
        return YES;
    }
    
    self.startDateTextField.text = @"";
    
    return NO;
}

-(BOOL)stepTextIsValid
{
    NSCharacterSet* stepTextSet = [NSCharacterSet characterSetWithCharactersInString:self.stepTextField.text];
    
    if ([[NSCharacterSet decimalDigitCharacterSet] isSupersetOfSet:stepTextSet])
    {
        return YES;
    }
    self.stepTextField.text = @"";
    
    return NO;
}

-(BOOL)unitTextIsValid
{
    NSArray* siutableStrings = [NSArray arrayWithObjects:@"year", @"month", @"week",
                                @"day", @"hour", @"minute", nil];
    
    for (NSString* siutable in siutableStrings)
    {
        if ([self.dateUnitTextField.text isEqualToString:siutable])
        {
            return YES;
            break;
        }
    }

    self.dateUnitTextField.text = @"";
    
    return NO;
}

-(void)addingUnit:(BOOL)adding{
    if ([self startDateTextIsValid] && [self stepTextIsValid] && [self unitTextIsValid]) {
        NSDate* startingDate = nil;
        
        if (![self.startDateTextField.text isEqualToString:@""]) {
            startingDate = [self.dateFormater dateFromString:self.startDateTextField.text];
        }
        else
        {
            startingDate = [self.dateFormater dateFromString:self.outputDateLabel.text];
        }
        
        NSInteger amount = [self.stepTextField.text integerValue];
        if (!adding) {
            amount = -amount;
        }
        
        NSString* unit = self.dateUnitTextField.text;
        
        if ([unit isEqualToString:@"year"])
        {
            startingDate = [startingDate rk_dateByAddingYears:amount];
            self.startDateTextField.text = @"";

        }
        else if ([unit isEqualToString:@"month"])
        {
            startingDate = [startingDate rk_dateByAddingMonths:amount];
            self.startDateTextField.text = @"";

        }
        else if ([unit isEqualToString:@"week"])
        {
            startingDate = [startingDate rk_dateByAddingWeek:amount];
            self.startDateTextField.text = @"";

        }
        else if ([unit isEqualToString:@"day"])
        {
            startingDate = [startingDate rk_dateByAddingDays:amount];
            self.startDateTextField.text = @"";

        }
        else if ([unit isEqualToString:@"hour"])
        {
            startingDate = [startingDate rk_dateByAddingHours:amount];
            self.startDateTextField.text = @"";

        }
        else if ([unit isEqualToString:@"minute"])
        {
            startingDate = [startingDate rk_dateByAddingMinutes:amount];
            self.startDateTextField.text = @"";
        }
        
        self.outputDateLabel.text = [self.dateFormater stringFromDate:startingDate];
        NSLog(@"");
        
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"shouldChangeCharactersInRange");
    if(textField == self.startDateTextField)
    {
        NSMutableString* contentOfTextField = [NSMutableString stringWithString:self.startDateTextField.text];
        [contentOfTextField replaceCharactersInRange:range withString:string];
        if ([self.dateFormater dateFromString:contentOfTextField])
        {
            self.outputDateLabel.text = contentOfTextField;
        }
        
        return YES;
    }
    
    if(textField == self.stepTextField)
    {
        NSCharacterSet* stepTextSet = [NSCharacterSet characterSetWithCharactersInString:string];
        
        if ([[NSCharacterSet decimalDigitCharacterSet] isSupersetOfSet:stepTextSet])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    if(textField == self.dateUnitTextField)
    {
        if (![[NSCharacterSet lowercaseLetterCharacterSet] isSupersetOfSet:[NSCharacterSet characterSetWithCharactersInString:string]])
        {
            return NO;
        }
    }
    
    return YES;
}

- (void)dealloc
{
    [_dateFormater release];
    [_outputDateLabel release];
    [_startDateTextField release];
    [_stepTextField release];
    [_dateUnitTextField release];
    [_addButton release];
    [_subButton release];
    [super dealloc];
}

@end
