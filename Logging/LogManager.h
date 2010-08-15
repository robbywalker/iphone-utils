//
//  LogManager.h
//  wmp
//
//  Created by Robert Walker on 6/1/10.
//  Copyright 2010 Fitnio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LogDelegate

- (void)logMessage:(NSString *)message;

@end


@interface LogManager : NSObject {
}

+ (void)addDelegate:(id<LogDelegate>)delegate;

+ (void)removeDelegate:(id<LogDelegate>)delegate;

// Internal only.

+ (void)logMessage:(NSString *)message forClass:(NSString *)className atLine:(int)lineNumber ofType:(NSString *)severity;

@end
