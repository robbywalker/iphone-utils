//
//  PathUtil.h
//  FunRun
//
//  Created by Robert Walker on 6/30/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

@interface PathUtil : NSObject

+ (void)setUpPaths;

+ (NSFileManager *)fileManager;
+ (NSString *)documentPath:(NSString *)filename;
+ (NSString *)resourcePath:(NSString *)filename;

@end
