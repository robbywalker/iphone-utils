//
//  QueryString.h
//  FunRun
//
//  Created by Robert Walker on 10/23/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#include <Foundation/Foundation.h>

@interface QueryString : NSObject {
	NSString *input;
	NSMutableDictionary *params;
}

+ (QueryString *)queryStringFromString:(NSString *)string;

+ (QueryString *)queryStringFromURL:(NSURL *)url;

- (NSString *)paramValue:(NSString *)param;

@end
