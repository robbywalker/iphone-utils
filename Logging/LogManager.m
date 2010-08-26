//
//  LogManager.m
//  iphone-utils
//
//  Copyright 2010 The iphone-utils Authors. All Rights Reserved.
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

#import "LogManager.h"
#import "StringUtil.h"

static NSMutableSet *delegates;

@implementation LogManager

+ (void)initialize {
  delegates = [[NSMutableSet setWithCapacity:1] retain];
}

+ (void)addDelegate:(id<LogDelegate>)delegate {
  [delegates addObject:delegate];
}

+ (void)removeDelegate:(id<LogDelegate>)delegate {
  [delegates removeObject:delegate];
}

// Internal only.

+ (void)logMessage:(NSString *)message 
          forClass:(NSString *)className 
            atLine:(int)lineNumber
            ofType:(NSString *)severity {
  if ([delegates count]) {
    NSString *formattedMessage = FORMAT(@"%f - %@ - %@:%d - %@", [[NSDate date] timeIntervalSince1970], severity, className, lineNumber, message);
    NSEnumerator *e = [delegates objectEnumerator];
    id delegate;
    while ((delegate = [e nextObject])) {
      [(id<LogDelegate>)delegate logMessage:formattedMessage];
    }
  }
}

@end
