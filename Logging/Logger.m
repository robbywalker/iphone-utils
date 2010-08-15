//
//  Logger.m
//  wmp
//
//  Created by Robert Walker on 6/1/10.
//  Copyright 2010 Fitnio. All rights reserved.
//

#import "Logger.h"
#import "LogManager.h"

@implementation Logger

@synthesize className;

- (Logger *)initWithClassName:(NSString*)name {
  self = [super init];
  if (self) {
    self.className = name;
  }
  return self;
}

- (BOOL)isLogging {
  return YES;
}

- (void)log:(NSString *)message atLine:(int)lineNumber {
  [LogManager logMessage:message forClass:className atLine:lineNumber ofType:@"info"];
}

@end
