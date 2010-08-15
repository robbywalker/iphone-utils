//
//  ContactTextField.m
//  FunRun
//
//  Created by Robert Walker on 7/10/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

//#import "BaseViewController.h"
#import "ContactTextField.h"
#import "Form.h"
#import "StringUtil.h"


@implementation ContactTextField

@synthesize contactNumber;

- (void)registerWithForm:(Form *)_form {
	[super registerWithForm:_form];
	contactNumber = nil;
}

- (BOOL)shouldScroll {
	return NO;
}

- (void)setSerializedContactData:(NSString *)string {
	self.contactNumber = [ContactNumber deserialize:string];
	self.text = [contactNumber description];
}

- (void)dealloc {
	[super dealloc];
	[contactNumber release];
}

- (UIView *)input {
  return nil;
}

- (void)startEditing {
	peoplePicker = [[[ABPeoplePickerNavigationController alloc] init] retain];
	peoplePicker.title = @"Pick Emergency Contact";
	peoplePicker.displayedProperties = [NSArray arrayWithObject:
										[[NSNumber alloc] initWithInt:
										 kABPersonPhoneProperty]];
	peoplePicker.peoplePickerDelegate = self;
	[form.viewController presentModalViewController:peoplePicker animated:YES];
}

- (void)pickPerson:(ContactNumber *)number {
	self.contactNumber = number;
	self.text = [contactNumber description];

	[self sendActionsForControlEvents:UIControlEventValueChanged];
	
	[form.viewController dismissModalViewControllerAnimated:YES];
	[form resetCurrentField];
	[peoplePicker release];	
}

// ABPeoplePickerNavigationControllerDelegate

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)sender
	  shouldContinueAfterSelectingPerson:(ABRecordRef)person {
	return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)sender
	  shouldContinueAfterSelectingPerson:(ABRecordRef)person
								property:(ABPropertyID)property
							  identifier:(ABMultiValueIdentifier)identifier {	
	ContactNumber *number = [[ContactNumber alloc] initWithRecord:person andPhoneIndex:identifier];
	[self performSelectorOnMainThread:@selector(pickPerson:) withObject:number waitUntilDone:YES];
	return NO;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)sender {
	[form.viewController dismissModalViewControllerAnimated:YES];
	[form resetCurrentField];
	[peoplePicker release];
}

@end
