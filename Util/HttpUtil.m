//
//  HttpUtil.m
//  iphone-utils
//
//  Copyright 2008 The iphone-utils Authors. All Rights Reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS-IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
