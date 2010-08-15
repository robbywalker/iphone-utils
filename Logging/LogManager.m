//
//  LogManager.m
//  wmp
//
//  Created by Robert Walker on 6/1/10.
//  Copyright 2010 Fitnio. All rights reserved.
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
    NSString *formattedMessage = FORMAT(@"info - %@:%d - %@", className, lineNumber, message);
    NSEnumerator *e = [delegates objectEnumerator];
    id delegate;
    while ((delegate = [e nextObject])) {
      [(id<LogDelegate>)delegate logMessage:formattedMessage];
    }
  }
}

@end
