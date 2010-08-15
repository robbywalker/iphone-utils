//
//  DateTextField.m
//  FunRun
//
//  Created by Robert Walker on 7/7/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import "DateTextField.h"

static UIDatePicker *datePicker;
static NSDateFormatter *formatter;

@implementation DateTextField

+ (void)initialize {
	datePicker = nil;
	
	[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
	
	formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterMediumStyle];
	[formatter setTimeStyle:NSDateFormatterNoStyle];
}

+ (UIDatePicker *)getPicker {
	if (!datePicker) {
		datePicker = [[[UIDatePicker alloc] init] retain];
		datePicker.datePickerMode = UIDatePickerModeDate;
		[datePicker sizeToFit];
		
		// Pick a default that is close to the average birthday of our users.
		datePicker.date = [NSDate dateWithTimeIntervalSince1970:(10 * 365 + 169) * 24 * 60 * 60];
	}
  
  return datePicker;
}

- (UIView *)input {
  return [DateTextField getPicker];
}

- (void)startEditing {
	// Override it with the real date if we have one.
	if (self.text && [self.text length]) {
		@try {
			[datePicker setDate:[formatter dateFromString:self.text] animated:NO];
		} @catch (NSException *e) {
		}
	}
	
  // TODO(robbyw): Issues here with multiple dates?
	[datePicker addTarget:self
				   action:@selector(datePickerChanged)
		 forControlEvents:UIControlEventValueChanged];
  
  [form setField:self];
}

- (void)datePickerChanged {
	self.text = [formatter stringFromDate:datePicker.date];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
