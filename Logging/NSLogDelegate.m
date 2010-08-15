//
//  NSLogDelegate.m
//  wmp
//
//  Created by Robert Walker on 6/1/10.
//  Copyright 2010 Fitnio. All rights reserved.
//

#import "LogManager.h"
#import "NSLogDelegate.h"

@implementation NSLogDelegate

+ (void)install {
  [LogManager addDelegate:[[NSLogDelegate alloc] init]];
}

- (void)logMessage:(NSString *)message {
  NSLog(@"%@", message);
}

@end
