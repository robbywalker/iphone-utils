//
//  NSLogDelegate.h
//  wmp
//
//  Created by Robert Walker on 6/1/10.
//  Copyright 2010 Fitnio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogManager.h"

@interface NSLogDelegate : NSObject <LogDelegate>

+ (void)install;

@end
