//
//  QueryString.m
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

#import "QueryString.h"


@implementation QueryString

- (QueryString *)initWithString:(NSString *)string {
	if (self = [super init]) {
		params = nil;
		input = [string retain];
	}
	
	return (QueryString *)self;
}

+ (QueryString *)queryStringFromString:(NSString *)string {
	if (!string || !string.length) {
		return nil;
	}
	return [[QueryString alloc] initWithString:string];
}

+ (QueryString *)queryStringFromURL:(NSURL *)url {
	return [QueryString queryStringFromString:[url parameterString]];
}

- (void)parse {
	params = [[NSMutableDictionary dictionaryWithCapacity:3] retain];
	int inputLength = input.length;
	
	NSRange range;
	NSRange substring = NSMakeRange(0, inputLength);
	do {
		range = [input rangeOfString:@"&" options:0 range:substring];
		
		NSRange chunk;
		if (range.location == NSNotFound) {
			chunk = substring;
		} else {
			chunk = NSMakeRange(substring.location, range.location - substring.location);
			substring.location = range.location + range.length;
			substring.length = inputLength - substring.location;
		}

		// Find the equals sign.
		NSRange equalSign = [input rangeOfString:@"=" options:0 range:chunk];
		
		if (equalSign.location != NSNotFound) {
			NSString *key = [input substringWithRange:
							 NSMakeRange(chunk.location,
										 equalSign.location - chunk.location)];
			NSString *value = [input substringWithRange:
							   NSMakeRange(equalSign.location + 1,
										   chunk.location + chunk.length - equalSign.location - 1)];
			value = [value stringByReplacingOccurrencesOfString:@"+" withString:@" "];
			value = [value stringByReplacingPercentEscapesUsingEncoding:
					 NSUTF8StringEncoding];
			[params setObject:value forKey:key];
		}
	} while (range.location != NSNotFound);
	
	[input release];
}

- (NSString *)paramValue:(NSString *)param {
	if (!params) {
		[self parse];
	}
	
	return [params objectForKey:param];
}

@end
