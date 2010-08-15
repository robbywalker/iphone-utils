//
//  ContactTextField.h
//  FunRun
//
//  Created by Robert Walker on 7/10/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <UIKit/UIKit.h>
#import "ContactNumber.h"
#import "FormField.h"
#import "TextFormField.h"

@interface ContactTextField : TextFormField <ABPeoplePickerNavigationControllerDelegate> {
	ContactNumber *contactNumber;
	ABPeoplePickerNavigationController *peoplePicker;
}

@property (nonatomic, retain) ContactNumber *contactNumber;

- (void)setSerializedContactData:(NSString *)string;

@end
