//
//  StringUtil.h
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
