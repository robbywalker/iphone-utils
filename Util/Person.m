//
//  Person.m
//  FunRun
//
//  Created by Robert Walker on 7/14/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import "Person.h"
#import "StringUtil.h"


@implementation Person

- (NSString *)formatPhoneNumberLabel:(NSString *)label {
	if ([label hasPrefix:@"_$!<"]) {
		return [[label substringWithRange:NSMakeRange(4, label.length - 8)] lowercaseString];
	}
	return label;
}

- (id)initFromRecordId:(ABRecordID)recordId {
	if (self = [super init]) {
		addressBook = ABAddressBookCreate();
		record = ABAddressBookGetPersonWithRecordID(addressBook, recordId);
		phoneData = ABRecordCopyValue(record, kABPersonPhoneProperty);
	}
	
	return self;
}

- (id)initFromRecord:(ABRecordRef)_record {
	if (self = [super init]) {	
		addressBook = ABAddressBookCreate();
		record = _record;
		phoneData = ABRecordCopyValue(record, kABPersonPhoneProperty);	
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
	
	CFRelease(addressBook);
	CFRelease(phoneData);
	CFRelease(record);
}

- (NSString *)getPhoneType:(int)index {
	return [self formatPhoneNumberLabel:[NSString stringFromCFStringRef:
										 ABMultiValueCopyLabelAtIndex(phoneData, index)]];
}

- (NSString *)getPhoneNumber:(int)index {
	return [NSString stringFromCFStringRef:ABMultiValueCopyValueAtIndex(phoneData, index)];
}

- (NSString *)getFirstName {
	return [NSString stringFromCFStringRef:ABRecordCopyValue(record, kABPersonFirstNameProperty)];
}

- (NSString *)getName {
	NSString *output;
	
	CFStringRef firstName = ABRecordCopyValue(record, kABPersonFirstNameProperty);
	CFStringRef lastName = ABRecordCopyValue(record, kABPersonLastNameProperty);
	if (!firstName && !lastName) {
		CFStringRef companyName = ABRecordCopyValue(record, kABPersonOrganizationProperty);
		output = [NSString stringWithFormat:@"%@", companyName];
		if (companyName) {
			CFRelease(companyName);
		}
	} else {
		output = [NSString stringWithFormat:@"%@ %@",
				  firstName ? (NSString *)firstName : @"",
				  lastName ? (NSString *)lastName : @""];		
		if (firstName) {
			CFRelease(firstName);
		}
		if (lastName) {
			CFRelease(lastName);
		}	
	}
	
	return output;
}

- (ABRecordID)getRecordId {
	return ABRecordGetRecordID(record);
}

- (int)getPhoneNumberCount {
	return ABMultiValueGetCount(phoneData);
}

@end
