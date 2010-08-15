//
//  PathUtil.m
//  FunRun
//
//  Created by Robert Walker on 6/30/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import "PathUtil.h"

static BOOL isSetup = NO;

// Info used to determine the database files paths.
static NSFileManager *fileManager;
static NSString *documentsDirectory;
static NSString *resourcesDirectory;

@implementation PathUtil

+ (void)initialize {
  [PathUtil setUpPaths];
}

+ (void)setUpPaths {
	if (!isSetup) {
		fileManager = [[NSFileManager defaultManager] retain];
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
															 NSUserDomainMask,
															 YES);
		documentsDirectory = [[paths objectAtIndex:0] copy];
		resourcesDirectory = [[[NSBundle bundleForClass:[self class]] resourcePath] copy];
		isSetup = YES;		
	}
}

+ (NSFileManager *)fileManager {
	return fileManager;
}

+ (NSString *)documentPath:(NSString *)filename {
	return [documentsDirectory stringByAppendingPathComponent:filename];
}

+ (NSString *)resourcePath:(NSString *)filename {
	return [resourcesDirectory stringByAppendingPathComponent:filename];
}
	
@end
