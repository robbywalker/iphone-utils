//
//  ContactNumber.m
//  FunRun
//
//  Created by Robert Walker on 7/14/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import "ContactNumber.h"


@implementation ContactNumber

@synthesize person;
@synthesize phoneIndex;

- (id)initWithRecordId:(ABRecordID)recordId andPhoneIndex:(ABMultiValueIdentifier)index {
	if (self = [super init]) {
		self.person = [[Person alloc] initFromRecordId:recordId];
		self.phoneIndex = index >= [person getPhoneNumberCount] ? 0 : index;
	}
	
	return self;
}

- (id)initWithRecord:(ABRecordRef)record andPhoneIndex:(ABMultiValueIdentifier)index {
	if (self = [super init]) {
		self.person = [[Person alloc] initFromRecord:record];
		self.phoneIndex = index;
	}
	
	return self;
}

- (NSString *)serialize {
	return [NSString stringWithFormat:@"%d %d", [person getRecordId], phoneIndex];	
}

+ (ContactNumber *)deserialize:(NSString *)value {	
	if ([value length]) {
		NSRange space = [value rangeOfString:@" "];
		ABRecordID recordId = [[value substringToIndex:space.location] intValue];
		ABMultiValueIdentifier phoneIndex =
			[[value substringFromIndex:space.location + 1] intValue];
		
		return [[ContactNumber alloc] initWithRecordId:recordId andPhoneIndex:phoneIndex];
	}
	
	return nil;
}

- (NSString *)getPhoneNumber {
	return [person getPhoneNumber:phoneIndex];	
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ (%@)",
			[person getName],
			[person getPhoneType:phoneIndex]];
}

- (void)dealloc {
	[super dealloc];
	NSLog(@"Destroying ContactNumber");
}

@end
