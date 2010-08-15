//
//  StringUtil.m
//  FunRun
//
//  Created by Robert Walker on 7/13/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import "StringUtil.h"
#import "Units.h"


@implementation NSString (Utils)

+ (NSString *)stringFromCFStringRef:(CFStringRef)ref {
	NSString *output = [NSString stringWithFormat:@"%@", ref];
	CFRelease(ref);
	return output;
}

+ (NSString *)stringWithFormattedDuration:(int)duration {
	int hours = duration / (60 * 60);
	int minutes = (duration - (hours * 60 * 60)) / 60;
	int seconds = duration % 60;
	
	if (hours > 0) {
		return [NSString stringWithFormat:@"%1d:%02d:%02d", hours, minutes, seconds];
	} else {
		return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
	}
}

+ (NSString *)stringWithShortestFormattedDuration:(int)duration {
	int hours = duration / (60 * 60);
	int minutes = (duration - (hours * 60 * 60)) / 60;
	int seconds = duration % 60;
	
	if (hours > 0) {
		return [NSString stringWithFormat:@"%1d:%02d:%02d", hours, minutes, seconds];
	} else {
		return [NSString stringWithFormat:@"%01d:%02d", minutes, seconds];
	}
}

- (double) parseHeightAsInches {
	if ([self hasSuffix:@"cm"]) {
		return [self intValue] / INCH_IN_CENTIMETERS;
		
	} else {
		int feet = [self intValue];
		int inches = [[self substringFromIndex:3] intValue];
		return feet * 12 + inches;
	}
}

- (double) parseWeightAsPounds {
	if ([self hasSuffix:@"lbs"]) {
		return [self intValue];
	} else {
		return round([self intValue] / POUND_IN_KILOGRAMS);
	}
}

- (NSString *)numbersOnly {
	NSMutableString *output = [NSMutableString stringWithCapacity:0];
	for (int i = 0; i < [self length]; i++) {
		char c = [self characterAtIndex:i];
		if (c >= '0' && c <= '9') {
			[output appendFormat:@"%c", c];
		}
	}
	return output;
}

- (BOOL)writeToStream:(NSOutputStream *)stream {
	if ([self length]) {
		int bytes = [stream write:(const uint8_t *)[self UTF8String] maxLength:[self length]];
		return bytes > 0;
	}
	return YES;
}

- (NSString *)json {
	// From: http://code.google.com/p/json-framework/
	NSMutableString *output = [NSMutableString stringWithCapacity:128];
		
	static NSMutableCharacterSet *kEscapeChars;
	if( ! kEscapeChars ) {
		kEscapeChars = [[NSMutableCharacterSet characterSetWithRange: NSMakeRange(0,32)] retain];
		[kEscapeChars addCharactersInString: @"\"\\"];
	}
	
	[output appendString:@"\""];
	
	NSRange esc = [self rangeOfCharacterFromSet:kEscapeChars];
	if ( !esc.length ) {
		// No special chars -- can just add the raw string:
		[output appendString:self];
		
	} else {
		NSUInteger length = [self length];
		for (NSUInteger i = 0; i < length; i++) {
			unichar uc = [self characterAtIndex:i];
			switch (uc) {
				case '"':   [output appendString:@"\\\""]; break;
				case '\\':  [output appendString:@"\\\\"]; break;
				case '\t':  [output appendString:@"\\t"]; break;
				case '\n':  [output appendString:@"\\n"]; break;
				case '\r':  [output appendString:@"\\r"]; break;
				case '\b':  [output appendString:@"\\b"]; break;
				case '\f':  [output appendString:@"\\f"]; break;
				default:    
					if (uc < 0x20) {
						[output appendFormat:@"\\u%04x", uc];
					} else {
						[output appendFormat:@"%C", uc];
					}
					break;
					
			}
		}
	}
	
	[output appendString:@"\""];
	return output;
}

- (BOOL)contains:(NSString *)substring {
	return [self rangeOfString:substring].location != NSNotFound;
}

@end
