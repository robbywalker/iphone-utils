//
//  HeightTextField.m
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

#import "HeightTextField.h"
#import "StringUtil.h"
#import "Units.h"
#import "Util.h"

static UIView *sharedHeightPicker = nil;
static UIPickerView *standardPicker = nil;
static UIPickerView *metricPicker = nil;

@implementation HeightTextField

+ (UIView*)getInputArea {
	if (!sharedHeightPicker) {
		sharedHeightPicker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		
		standardPicker = [[UIPickerView alloc] init];
		standardPicker.showsSelectionIndicator = YES;
		[standardPicker sizeToFit];
		
		int height = standardPicker.frame.size.height;
		standardPicker.frame = CGRectMake(0, 0, 160, height);
		[sharedHeightPicker addSubview:standardPicker];
			
		metricPicker = [[UIPickerView alloc] init];
		metricPicker.showsSelectionIndicator = YES;
		[metricPicker sizeToFit];
		
		metricPicker.frame = CGRectMake(160, 0, 160, height);
		[sharedHeightPicker addSubview:metricPicker];
		sharedHeightPicker.frame = CGRectMake(0, 0, 320, metricPicker.frame.size.height);	
	}
  
  return sharedHeightPicker;
}

+ (void)updateInputArea:(HeightTextField *)field {
  standardPicker.dataSource = field;
  standardPicker.delegate = field;
  
  metricPicker.dataSource = field;
  metricPicker.delegate = field;
  
	int cm;
	int totalInches;
	if (![field.text length]) {
		cm = 170;
		totalInches = 67;
	} else if ([field.text hasSuffix:@"cm"]) {
		cm = [field.text intValue];
		totalInches = cm / INCH_IN_CENTIMETERS;
		
	} else {
		int feet = [field.text intValue];
		int inches = [[field.text substringFromIndex:3] intValue];
		totalInches = feet * 12 + inches;
		cm = totalInches * INCH_IN_CENTIMETERS;
	}
	[field setCentimeters:cm animated:NO];
	[field setTotalInches:totalInches animated:NO];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return pickerView == standardPicker ? 2 : 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (pickerView == standardPicker) {
		return component ? 12 : 8;
	} else {
		return 241;
	}
}

- (NSString *)pickerView:(UIPickerView *)pickerView
			 titleForRow:(NSInteger)row
			forComponent:(NSInteger)component {
	if (pickerView == standardPicker) {
		NSInteger offset = component ? 0 : 1;
		return FORMAT(@"%d %s", offset + row, component ? "in" : "ft");
	} else {
		return FORMAT(@"%d cm", 30 + row);
		((UILabel *) [pickerView viewForRow:row forComponent:component]).textAlignment =
			UITextAlignmentCenter;
	}
}

- (void)pickerView:(UIPickerView *)pickerView
	  didSelectRow:(NSInteger)row
	   inComponent:(NSInteger)component {
	if (pickerView == standardPicker) {
		int totalInches = ([pickerView selectedRowInComponent:0] + 1) * 12 + 
			[pickerView selectedRowInComponent:1];
		[self setCentimeters:(int) round(totalInches * INCH_IN_CENTIMETERS) animated:YES];
		self.text = FORMAT(@"%d' %d\"", [pickerView selectedRowInComponent:0] + 1,
					   [pickerView selectedRowInComponent:1]);
	} else {
		int inches = (int)round(([pickerView selectedRowInComponent:0] + 30) / INCH_IN_CENTIMETERS);
		[self setTotalInches:inches animated:YES];		
		self.text = FORMAT(@"%d cm", [pickerView selectedRowInComponent:0] + 30);
	}
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setTotalInches:(int)inches animated:(BOOL)animated {
	[standardPicker selectRow:inches / 12 - 1 inComponent:0 animated:animated];
	[standardPicker selectRow:inches % 12 inComponent:1 animated:animated];	
}

- (void)setCentimeters:(int)cm animated:(BOOL)animated{
	[metricPicker selectRow:cm - 30 inComponent:0 animated:animated];
}

- (UIView *)input {
  return [HeightTextField getInputArea];
}

- (void)startEditing {
	[HeightTextField updateInputArea:self];
  [form setField:self];
}

@end
