//
//  ReminderView.m
//  OBJCPickerView
//
//  Created by Lidiane Gomes Barbosa on 18/05/23.
//

#import "ReminderView.h"

@interface ReminderView ()
{
    UIDatePicker *datePicker;
    UITextField *labelDate;
}
@end

@implementation ReminderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self setup];
    }
    return self;
}
- (void)setup {
    [self setupViews];
    [self addViewHierarchy];
    [self addConstraints];
}

- (void)setupViews
{
    datePicker = [[UIDatePicker alloc] init];
    datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    datePicker.datePickerMode = UIDatePickerModeTime;
    datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    datePicker.backgroundColor=[UIColor clearColor];
    [datePicker addTarget:self action:@selector(datePickerDateChanged) forControlEvents:UIControlEventValueChanged];
    
    labelDate = [[UITextField alloc] init];
    labelDate.translatesAutoresizingMaskIntoConstraints = NO;
    labelDate.placeholder = @"0:00";
    labelDate.delegate = self;
    labelDate.textColor = [UIColor lightGrayColor];
    labelDate.backgroundColor=[UIColor clearColor];
    [labelDate setInputView:datePicker];
    [labelDate setTintColor:[UIColor clearColor]];
    

    UIToolbar * toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    [toolbar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *donebtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(datePickerDone)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:space,donebtn, nil]];
    [labelDate setInputAccessoryView:toolbar];
    
}

- (void)addViewHierarchy
{
    [self addSubview:labelDate];
}

- (void)addConstraints
{
    [labelDate.topAnchor constraintEqualToAnchor:self.topAnchor constant:24].active = YES;
    [labelDate.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:24].active = YES;
    [labelDate.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-24].active = YES;
    [labelDate.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-24].active = YES;
}

- (void) datePickerDone
{
    [self datePickerDateChanged];
    [labelDate resignFirstResponder];
}

- (void) datePickerDateChanged
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"HH:mm"];
    NSString* selectedValue = [NSString stringWithFormat:@"%@", [formatter stringFromDate:datePicker.date]];
    labelDate.text = selectedValue;
    labelDate.textColor = self.primaryColor;
    [self.delegate selectedDate:selectedValue];
}

@end
