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
    UITextField *dateField;
    UIImageView* clockImage;
    BOOL notificationEnabled;
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
    notificationEnabled = NO;
    [self setupLayout];
    [self setupViews];
    [self addViewHierarchy];
    [self addConstraints];
}

- (void)setupLayout
{
    self.backgroundColor = [UIColor systemGray5Color];
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
    
    clockImage.userInteractionEnabled = YES;

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    [tapGesture setDelegate:self];
    [clockImage addGestureRecognizer:tapGesture];
}

- (void) tapGesture: (id)sender
{
    notificationEnabled ^= YES;
    [self activateNotification];
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
    [dateField setBackgroundColor: [UIColor systemGray3Color]];
    dateField.textAlignment = NSTextAlignmentCenter;
    [dateField setInputView:datePicker];
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
    notificationEnabled = YES;
    [self activateNotification];
}

-(void) activateNotification
{
    if (notificationEnabled) {
        clockImage.tintColor = _primaryColor;
        dateField.backgroundColor = _primaryColor;
        dateField.textColor = [UIColor whiteColor];
    } else {
        clockImage.tintColor = [UIColor grayColor];
        [dateField setBackgroundColor: [UIColor systemGray3Color]];
        dateField.textColor = [UIColor labelColor];
    }
   
}

@end
