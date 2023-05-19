//
//  ReminderView.m
//  OBJCPickerView
//
//  Created by Lidiane Gomes Barbosa on 18/05/23.
//

#import "ReminderView.h"
#import <QuartzCore/QuartzCore.h>

@interface ReminderView ()
{
    UIDatePicker *datePicker;
    UITextField *dateField;
    UIImageView* clockImage;
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
    [self setupLayout];
    [self setupViews];
    [self addViewHierarchy];
    [self addConstraints];
}

- (void)setupLayout
{
    self.backgroundColor = [UIColor lightGrayColor];
}

- (void)setupViews
{
    [self setupImage];
    [self setupDatePicker];
    [self setupDataField];
}

-(void)setupImage
{
    clockImage = [[UIImageView alloc] init];
    clockImage.translatesAutoresizingMaskIntoConstraints = NO;
    clockImage.image = [UIImage systemImageNamed:@"deskclock.fill"];
    clockImage.contentMode = UIViewContentModeScaleAspectFit;
    clockImage.tintColor = [UIColor grayColor];
   
}

- (void)setupDatePicker
{
    datePicker = [[UIDatePicker alloc] init];
    datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    datePicker.datePickerMode = UIDatePickerModeTime;
    datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    [datePicker addTarget:self action:@selector(datePickerDateChanged) forControlEvents:UIControlEventValueChanged];
    
    datePicker.backgroundColor = [UIColor whiteColor];
}

- (void)setupDataField
{
    dateField = [[UITextField alloc] init];
    dateField.translatesAutoresizingMaskIntoConstraints = NO;
    dateField.placeholder = @"0:00";
    
    dateField.delegate = self;
    dateField.textColor = [UIColor labelColor];
    [dateField setTintColor:[UIColor clearColor]];
    [dateField setBackgroundColor: [UIColor whiteColor]];
    dateField.textAlignment = NSTextAlignmentCenter;
    [dateField setInputView:datePicker];
    dateField.alpha = 0.3;
    dateField.borderStyle = UITextBorderStyleRoundedRect;

    UIToolbar * toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    [toolbar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *donebtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(datePickerDone)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:space,donebtn, nil]];
    [dateField setInputAccessoryView:toolbar];
    
}

- (void)addViewHierarchy
{
    [self addSubview:dateField];
    [self addSubview:clockImage];
}

- (void)addConstraints
{
    [clockImage.topAnchor constraintEqualToAnchor:self.topAnchor constant:24].active = YES;
    [clockImage.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:24].active = YES;
    [clockImage.trailingAnchor constraintLessThanOrEqualToAnchor:dateField.leadingAnchor constant: 24].active = YES;
    [clockImage.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-24].active = YES;
    [clockImage.widthAnchor constraintEqualToConstant:30].active = YES;
    [clockImage.heightAnchor constraintEqualToConstant:30].active = YES;
    
    [dateField.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-24].active = YES;
    [dateField.centerYAnchor constraintEqualToAnchor:clockImage.centerYAnchor].active = YES;
    [dateField.widthAnchor constraintEqualToConstant:80].active = YES;
}

- (void) datePickerDone
{
    [self datePickerDateChanged];
    [dateField resignFirstResponder];
}

- (void) datePickerDateChanged
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"HH:mm"];
    NSString* selectedValue = [NSString stringWithFormat:@"%@", [formatter stringFromDate:datePicker.date]];
    dateField.text = selectedValue;
    [self.delegate selectedDate:selectedValue];
}

@end
