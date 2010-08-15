//
//  HttpUtil.h
//  FunRun
//
//  Created by Robert Walker on 8/24/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpUtil : NSObject {
}

+ (NSURL *)buildUrl:(NSString *)path, ...;

+ (NSURLRequest *)createPostRequest:(NSURL *)destination withFile:(NSString *)path;

@end
