//
//  StringUtil.h
//  FunRun
//
//  Created by Robert Walker on 7/13/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import <CoreFoundation/CoreFoundation.h>


#define CHAR_TO_STRING(value) [NSString stringWithFormat:@"%c", value]
#define INT_TO_STRING(value) [NSString stringWithFormat:@"%d", value]
#define INT64_TO_STRING(value) [NSString stringWithFormat:@"%ld", value]
#define DOUBLE_TO_STRING(value) [NSString stringWithFormat:@"%f", value]

#define APPEND stringByAppendingString:
#define FORMAT(format, args...) [NSString stringWithFormat:format, ## args]


@interface NSString (Utils)

+ (NSString *)stringFromCFStringRef:(CFStringRef)ref;

+ (NSString *)stringWithFormattedDuration:(int)duration;

+ (NSString *)stringWithShortestFormattedDuration:(int)duration;

- (double) parseHeightAsInches;

- (double) parseWeightAsPounds;

- (NSString *)numbersOnly;

- (BOOL)writeToStream:(NSOutputStream *)stream;

- (NSString *)json;

- (BOOL)contains:(NSString *)string;

@end
