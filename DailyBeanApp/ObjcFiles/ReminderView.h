//
//  ReminderView.h
//  OBJCPickerView
//
//  Created by Lidiane Gomes Barbosa on 18/05/23.
//

#import <UIKit/UIKit.h>
#import "ReminderViewDelegate.h"

@interface ReminderView : UIView<UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (nonatomic) UIColor *primaryColor;
@property (nonatomic, weak) id<ReminderViewDelegate> delegate;

@end

