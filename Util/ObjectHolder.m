//
//  ObjectHolder.m
//  FunRun
//
//  Created by Robert Walker on 6/29/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import "ObjectHolder.h"

@implementation ObjectHolder

@synthesize object;

-(id) initializeWithObject:(id)obj {
    if (self = [super init]) {
		[self setObject:obj];
	}
	return self;
}

@end