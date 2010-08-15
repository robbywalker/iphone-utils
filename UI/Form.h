//
//  Form.h
//  FunRun
//
//  Created by Robert Walker on 1/31/09.
//  Copyright 2009 Fitnio. All rights reserved.
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
