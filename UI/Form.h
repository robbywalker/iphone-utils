//
//  Form.h
//  iphone-utils
//
//  Copyright 2009 The iphone-utils Authors. All Rights Reserved.
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

#import <Foundation/Foundation.h>
#import "BackgroundTouchView.h"
#import "TouchDetector.h"

@interface Form : NSObject <UITextFieldDelegate, TouchDetectorDelegate> {
	UIViewController *viewController;
	
	UIView *mainView;
	UIView *contentView;
	BackgroundTouchView *scrollingView;
	
  CGFloat viewWidth;
  CGFloat viewHeight;
  
	UIBarButtonItem *previousButton;
	UIBarButtonItem *nextButton;
	UIBarButtonItem *doneButton;
	
	UIToolbar *toolbar;
	UITextField *currentField;
	
	NSArray *textFields;
	
	NSMutableDictionary *submitFields;
	NSMutableDictionary *fieldTops;
}

- (id)initWithBaseViewController:(UIViewController *)controller;

// Setup methods.
- (void)setSubmitField:(UITextField *)field selector:(SEL)selector;
- (void)setFieldTop:(UIView *)field top:(int)top;

// Event handlers.
- (void)viewWillDisappear;

// Methods for child controls.
- (void)resetCurrentField;
- (void)setField:(UITextField *)input;

// Field navigation.
- (void)attachFieldHandlers;
- (int)getFieldTop:(UIView *)field;
- (BOOL)handleSelectField:(UITextField *)field;
- (void)nextField;
- (void)previousField;
- (void)selectField:(UITextField *)field;

@property (nonatomic, readonly) UIViewController *viewController;
@property (nonatomic, readonly) UIView *mainView;

@end
