//
//  ReminderViewDelegate.h
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 18/05/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^Completion)(BOOL success);

@protocol ReminderViewDelegate <NSObject>

- (void) selectedDate: (NSDate*) date completed:(Completion)completed;
- (void) disableNotification;

@end

NS_ASSUME_NONNULL_END
