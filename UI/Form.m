//
//  Form.m
//  FunRun
//
//  Created by Robert Walker on 1/31/09.
//  Copyright 2009 Fitnio. All rights reserved.
//

#import "BackgroundTouchView.h"
#import "Form.h"
#import "FormField.h"
#import "ObjectHolder.h"
#import "StringUtil.h"
#import "TouchDetector.h"

#define KEYBOARD_HEIGHT 215

#define FIELD_BUTTON_WIDTH 75

NSInteger positionSort(id item1, id item2, void *context) {
	UIView *view1 = (UIView *)item1;
	UIView *view2 = (UIView *)item2;
	
    int v1 = view1.frame.origin.y;
    int v2 = view2.frame.origin.y;
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

NSString *mapKey(UIView *view) {
	return FORMAT(@"%ld", view);
}

#pragma mark -
#pragma mark Private interface

@interface Form(Private)

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
- (void)keyboardDidHide:(NSNotification *)notification;

@end

#pragma mark -
#pragma mark Public implementation

@implementation Form

@synthesize mainView;
@synthesize viewController;

- (id)initWithBaseViewController:(UIViewController *)controller {
	if (!(self = [super init])) {
		return nil;
	}

	viewController = [controller retain];
	
	// Use the view from Interface Builder as the content view.
	contentView = viewController.view;
  
  viewWidth = contentView.frame.size.width;
  viewHeight = contentView.frame.size.height;
  
	// Create a scrolling view for the form.
	scrollingView = [[BackgroundTouchView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
	scrollingView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	scrollingView.showsHorizontalScrollIndicator = NO;
	scrollingView.showsVerticalScrollIndicator = NO;
	scrollingView.contentSize = [contentView bounds].size;
	scrollingView.scrollEnabled = NO;
	scrollingView.bounces = YES;		
	[scrollingView addSubview:contentView];
	scrollingView.touchDelegate = self;
	
	// Create the main view to hold the background image and the scrolling view, plus any
	// controls.
	mainView = [[[UIView alloc] initWithFrame:contentView.frame] retain];
	mainView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	UIImage *bgImage = [UIImage imageNamed:@"view_controller_grey_bg.png"];
	UIImageView *bgImageView = [[UIImageView alloc] initWithImage:bgImage];
	bgImageView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
	[mainView addSubview:bgImageView];		
	[mainView addSubview:scrollingView];
  [mainView bringSubviewToFront:scrollingView];	

	viewController.view = mainView;
	
	currentField = nil;
	
	previousButton = nil;
	nextButton = nil;
	
	submitFields = [[NSMutableDictionary dictionaryWithCapacity:0] retain];
	fieldTops = [[NSMutableDictionary dictionaryWithCapacity:0] retain];
	
  toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 0)];
  toolbar.barStyle = UIBarStyleBlackTranslucent;
  
	[self attachFieldHandlers];
	
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
  [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
  [nc addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
  
	return self;
}

- (void)viewWillDisappear {
  [currentField resignFirstResponder];
	[scrollingView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];	
}

- (void)attachFieldHandlers {
	// Build a list of the text fields.
	NSMutableArray *unorderedTextFields = [[NSMutableArray alloc] initWithCapacity:0];
	for (UIView *view in contentView.subviews) {
		if ([view isKindOfClass:[UITextField class]]) {
			[unorderedTextFields addObject:view];
			((UITextField *)view).delegate = self;
      ((UITextField *)view).inputAccessoryView = toolbar;
		}
		if ([view conformsToProtocol:@protocol(FormField)]) {
			[(id<FormField>)view registerWithForm:self];
      if ([view isKindOfClass:[UITextField class]]) {
        ((UITextField *)view).inputView = [(id<FormField>)view input];
      }
		}
	}
	textFields = [unorderedTextFields sortedArrayUsingFunction:positionSort context:nil];
	[textFields retain];
}

- (void)previousField {
	NSInteger index = [textFields indexOfObject:currentField];
	if (index != NSNotFound && index > 0) {
		[self selectField:[textFields objectAtIndex:index - 1]];
	}
}

- (void)closeInput {
	if (currentField) {
		[currentField resignFirstResponder];
		currentField = nil;
	}
}

- (void)nextField {
	NSInteger index = [textFields indexOfObject:currentField];
	if (index != NSNotFound && index < [textFields count] - 1) {
		[self selectField:[textFields objectAtIndex:index + 1]];
	} else {
		[self closeInput];
	}
}

- (void)handleTouch {
	// Handles a touch to the background by closing the inputs.
	[self closeInput];
}

- (void)setToolbarItems:(NSString *)title atIndex:(NSInteger)index {
	if (!previousButton) {
		previousButton = [[[UIBarButtonItem alloc] 
						   initWithTitle:NSLocalizedString(@"Previous", @"Previous button title")
						   style:UIBarButtonItemStyleBordered
						   target:self
						   action:@selector(previousField)] retain];
		previousButton.width = FIELD_BUTTON_WIDTH;
		nextButton =  [[[UIBarButtonItem alloc]
						initWithTitle:NSLocalizedString(@"Next", @"Next button title")
						style:UIBarButtonItemStyleBordered
						target:self
						action:@selector(nextField)] retain];
		nextButton.width = FIELD_BUTTON_WIDTH;
		doneButton = [[[UIBarButtonItem alloc] 
					  initWithTitle:NSLocalizedString(@"Done", @"Done button title")
					  style:UIBarButtonItemStyleDone
					  target:self
					  action:@selector(nextField)] retain];
		doneButton.width = FIELD_BUTTON_WIDTH;
	}
	
	UIBarButtonItem *firstButton = previousButton;
	if (index == 0) {
		firstButton = [[UIBarButtonItem alloc] 
					   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace 
					   target:self 
					   action:nil];
		firstButton.width = FIELD_BUTTON_WIDTH;
	}
	
	UIBarButtonItem *lastButton = index == [textFields count] - 1 ? doneButton : nextButton;
	
	toolbar.items = [NSArray arrayWithObjects:
						  firstButton,
						  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																		target:self
																		action:nil],						 
						  [[UIBarButtonItem alloc] initWithTitle:title
														   style:UIBarButtonItemStylePlain
														  target:self
														  action:nil],
						  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																		target:self
																		action:nil],						 
						  lastButton,
						  nil];
}

- (void)setField:(UITextField *)field {
	NSInteger index = [textFields indexOfObject:currentField];
	
	[self setToolbarItems:field.placeholder atIndex:index];
	[toolbar sizeToFit];
	
  contentView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
	
	[[toolbar.items objectAtIndex:2] setTitle:field.placeholder];
}

- (void)selectField:(UITextField *)field {
	// Normal text fields cause events that end up calling handleSelectField for us.
	[field becomeFirstResponder];
}

- (int)getFieldTop:(UIView *)field {
	ObjectHolder *top = [fieldTops objectForKey:mapKey(field)];
	if (top) {
		return (int)top.object;
	}
	
	return field.frame.origin.y;
}

- (void)scrollToField:(UIView *)field {
  int top = [self getFieldTop:field];
  
  if (top == scrollingView.contentOffset.y) {
    return;
  }
  
  [scrollingView setContentOffset:CGPointMake(0, top) animated:YES];
}

- (void)setSubmitField:(UITextField *)field selector:(SEL)selector {
	ObjectHolder *holder = [[ObjectHolder alloc] initializeWithObject:(id)selector];
	[submitFields setObject:holder forKey:mapKey(field)];
}

- (void)setFieldTop:(UIView *)field top:(int)top {
	ObjectHolder *holder = [[ObjectHolder alloc] initializeWithObject:(id)top];	
	[fieldTops setObject:holder forKey:mapKey(field)];
}

/**
 * Handles selecting the given field by showing field selection UI.
 * @param field The field to handle selection of.
 * @return Whether to allow the field to be selected (which brings up the keyboard).
 */
- (BOOL)handleSelectField:(UITextField *)field {
	UIResponder * oldField;
	oldField = currentField;
	currentField = field;
	
	if (oldField == field) {
		return ![field conformsToProtocol:@protocol(FormField)];
	}
	
	if ([field conformsToProtocol:@protocol(FormField)]) {
		[(id<FormField>)field startEditing];
		if ([(id<FormField>)field shouldScroll]) {
			[self scrollToField:field];
		}
		return NO;
	} else {
		[self setField:field];
		[self scrollToField:field];
    return YES;
	}
}	

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	SEL s = (SEL) (((ObjectHolder *)[submitFields objectForKey:mapKey(textField)]).object);
	if (s) {
		[viewController performSelector:s withObject:textField];
	}	
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  [self handleSelectField:textField];
  return YES;
}

- (void)resetCurrentField {
	currentField = nil;
  [currentField resignFirstResponder];
}

@end


#pragma mark -
#pragma mark Public implementation

@implementation Form(Private)

- (void)keyboardWillShow:(NSNotification *)notification {
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
  [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];

  CGRect frame = scrollingView.frame;
  frame.size.height = viewHeight - [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
  scrollingView.frame = frame;
  scrollingView.scrollEnabled = YES;
  
  [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
  [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];  
  
  scrollingView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
  scrollingView.contentOffset = CGPointMake(0, 0);

  [UIView commitAnimations];  
}

- (void)keyboardDidHide:(NSNotification *)notification {
  scrollingView.scrollEnabled = NO;
}

@end