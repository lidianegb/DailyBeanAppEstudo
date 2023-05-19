//
//  ReminderViewDelegate.h
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 18/05/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ReminderViewDelegate <NSObject>

- (void)selectedDate:(NSString*) date;

@end

NS_ASSUME_NONNULL_END
