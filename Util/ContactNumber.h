//
//  ContactNumber.h
//  FunRun
//
//  Created by Robert Walker on 7/14/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import <CoreFoundation/CoreFoundation.h>
#import "Person.h"


@interface ContactNumber : NSObject {
	Person *person;
	ABMultiValueIdentifier phoneIndex;
}

@property (nonatomic, retain) Person *person;
@property (nonatomic, assign) ABMultiValueIdentifier phoneIndex;

- (id)initWithRecord:(ABRecordRef)record andPhoneIndex:(ABMultiValueIdentifier)index;
- (id)initWithRecordId:(ABRecordID)recordId andPhoneIndex:(ABMultiValueIdentifier)index;

- (NSString *)getPhoneNumber;

- (NSString *)serialize;

+ (ContactNumber *)deserialize:(NSString *)value;

@end
