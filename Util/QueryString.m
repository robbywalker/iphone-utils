//
//  QueryString.m
//  FunRun
//
//  Created by Robert Walker on 10/23/08.
//  Copyright 2008 Fitnio. All rights reserved.
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
