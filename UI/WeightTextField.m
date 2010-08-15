//
//  WeightTextField.m
//  iphone-utils
//
//  Copyright 2008 The iphone-utils Authors. All Rights Reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS-IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "StringUtil.h"
#import "Units.h"
#import "Util.h"
#import "WeightTextField.h"

static UIView *sharedWeightPicker = nil;
static UIPickerView *standardPicker = nil;
static UIPickerView *metricPicker = nil;

@implementation WeightTextField

+ (UIView*)getInputArea {
	if (!sharedWeightPicker) {
		sharedWeightPicker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		
		standardPicker = [[UIPickerView alloc] init];
		standardPicker.showsSelectionIndicator = YES;
		[standardPicker sizeToFit];
		
		int height = standardPicker.frame.size.height;
		standardPicker.frame = CGRectMake(0, 0, 160, height);
		[sharedWeightPicker addSubview:standardPicker];
		
		metricPicker = [[UIPickerView alloc] init];
		metricPicker.showsSelectionIndicator = YES;
		[metricPicker sizeToFit];
		
		metricPicker.frame = CGRectMake(160, 0, 160, height);
		[sharedWeightPicker addSubview:metricPicker];
		sharedWeightPicker.frame = CGRectMake(0, 0, 320, metricPicker.frame.size.height);	
	}
  
  return sharedWeightPicker;
}

+ (void)updateInputArea:(WeightTextField *)field {
  standardPicker.dataSource = field;
  standardPicker.delegate = field;

  metricPicker.dataSource = field;
  metricPicker.delegate = field;
  
	int lbs, kg;
	if (![field.text length]) {
		lbs = 150;
		kg = (int) round(POUND_IN_KILOGRAMS * 150);
	} else if ([field.text hasSuffix:@"lbs"]) {
		lbs = [field.text intValue];
		kg = (int) round(POUND_IN_KILOGRAMS * lbs);
	} else {
		kg = [field.text intValue];
		lbs = (int) round(kg / POUND_IN_KILOGRAMS);
	}
	[field setKg:kg animated:NO];
	[field setLbs:lbs animated:NO];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (pickerView == standardPicker) {
		// 40 - 1000
		return 960;
	} else {
		// 18 - 454
		return 436;
	}
}

- (NSString *)pickerView:(UIPickerView *)pickerView
			 titleForRow:(NSInteger)row
			forComponent:(NSInteger)component {
	if (pickerView == standardPicker) {
		return FORMAT(@"%d lbs", 40 + row);
	} else {
		return FORMAT(@"%d kg", 18 + row);
	}
}

- (void)pickerView:(UIPickerView *)pickerView
	  didSelectRow:(NSInteger)row
	   inComponent:(NSInteger)component {
	if (pickerView == standardPicker) {
		int lbs = [pickerView selectedRowInComponent:0] + 40;
		[self setKg:round(lbs * POUND_IN_KILOGRAMS) animated:YES];
		self.text = FORMAT(@"%d lbs", lbs);
	} else {
		int kg = (int)round([pickerView selectedRowInComponent:0]) + 18;
		[self setLbs:kg / POUND_IN_KILOGRAMS animated:YES];		
		self.text = FORMAT(@"%d kg", kg);
	}
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setLbs:(int)lbs animated:(BOOL)animated {
	[standardPicker selectRow:lbs - 40 inComponent:0 animated:animated];
}

- (void)setKg:(int)kg animated:(BOOL)animated{
	[metricPicker selectRow:kg - 18 inComponent:0 animated:animated];
}

- (UIView *)input {
  return [WeightTextField getInputArea];
}

- (void)startEditing {
  [WeightTextField updateInputArea:self];
  [form setField:self];
}

@end
