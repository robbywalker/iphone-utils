//
//  HttpUtil.m
//  FunRun
//
//  Created by Robert Walker on 8/24/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import "HttpConfig.h"
#import "HttpUtil.h"
#import "Logger.h"
#import "StringUtil.h"

DECLARE_LOGGER(@"HttpUtil");

@implementation HttpUtil

+ (NSURL *)buildUrl:(NSString *)path, ... {
	va_list argumentList;
	
	NSMutableString *result = [NSMutableString stringWithCapacity:50];
	if (![path contains:@"://"]) {
		[result appendString:[HttpConfig baseUrl]];
	}
	[result appendString:path];
	[result appendString:@"?"];
	
	id key;
	BOOL first = YES;
	va_start(argumentList, path);
	while (key = va_arg(argumentList, id)) {
		NSString *value = (NSString *)va_arg(argumentList, id);
		// Filter out nil values.
		if (value) {
			if (first) {
				first = NO;
			} else {
				[result appendString:@"&"];
			}
			[result appendFormat:@"%@=%@", key,
			 [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		}
	}
	va_end(argumentList);
	
	return [NSURL URLWithString:result];
}

+ (NSURLRequest *)createPostRequest:(NSURL *)destination withFile:(NSString *)path {
	NSMutableURLRequest* post = [NSMutableURLRequest requestWithURL:destination];
	LOG(@"Posting to %@", destination);
	[post addValue: @"application/octet-stream" forHTTPHeaderField: @"Content-Type"];
	[post setHTTPMethod: @"POST"];
	[post setHTTPBodyStream:[NSInputStream inputStreamWithFileAtPath:path]];

	return post;
}

@end
