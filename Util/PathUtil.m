//
//  PathUtil.m
//  iphone-utils
//
//  Copyright 2008 The iphone-utils Authors. All Rights Reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS-IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
