//
//  Logger.h
//  wmp
//
//  Created by Robert Walker on 6/1/10.
//  Copyright 2010 Fitnio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StringUtil.h"

#define DECLARE_LOGGER(className) static NSString *_loggerClassName = className; static Logger* logger
#define INIT_LOGGER if (logger == nil) { logger = [[[Logger alloc] initWithClassName:_loggerClassName] retain]; }
#define LOG(args...) INIT_LOGGER if ([logger isLogging]) { [logger log:FORMAT(args) atLine:__LINE__]; }

@interface Logger : NSObject {
  NSString *className;
}

@property (nonatomic, retain) NSString* className;

- (Logger *)initWithClassName:(NSString*)className;

- (BOOL)isLogging;

- (void)log:(NSString*)message atLine:(int)lineNumber;

@end
