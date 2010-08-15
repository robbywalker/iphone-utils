//
//  Person.h
//  FunRun
//
//  Created by Robert Walker on 7/14/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import <AddressBook/AddressBook.h>

@interface Person : NSObject {
	ABAddressBookRef addressBook;
	ABRecordRef record;
	CFTypeRef phoneData;
}

- (id)initFromRecord:(ABRecordRef)record;
- (id)initFromRecordId:(ABRecordID)recordID;

- (NSString *)getFirstName;
- (NSString *)getName;
- (NSString *)getPhoneType:(int)index;
- (NSString *)getPhoneNumber:(int)index;
- (int)getPhoneNumberCount;
- (ABRecordID)getRecordId;

@end
