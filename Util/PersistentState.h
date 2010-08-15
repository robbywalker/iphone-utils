//
//  PersistentState.h
//  Greplin
//
//  Created by Robert Walker on 8/7/10.
//  Copyright 2010 Greplin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PersistentState : NSObject

+ (void)setProperty:(NSString *)propertyName toValue:(NSString *)value;

+ (void)clearProperty:(NSString *)propertyName;

+ (NSString *)get:(NSString *)propertyname;

@end
