//
//  PersistentState.m
//  iphone-utils
//
//  Copyright 2010 The iphone-utils Authors. All Rights Reserved.
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

#import "PersistentState.h"

#import "PathUtil.h"
#import "StringUtil.h"


static NSMutableDictionary *properties = nil;

@interface PersistentState (Private)

+ (NSString *)filename;

+ (void)save;

@end

@implementation PersistentState (Private)

+ (NSString *)filename {
  return [PathUtil documentPath:@"state.plist"];
}

+ (void)save {
  NSError *error;
  NSOutputStream *stream = [NSOutputStream outputStreamToFileAtPath:[PersistentState filename] append:NO];
  [stream open];
  [NSPropertyListSerialization writePropertyList:properties 
                                        toStream:stream
                                          format:NSPropertyListBinaryFormat_v1_0 
                                         options:0
                                           error:&error];
  [stream close];  
}

@end

@implementation PersistentState

+ (void)initialize {
  if ([[PathUtil fileManager] fileExistsAtPath:[PersistentState filename]]) {
    NSError *error;
    NSInputStream *stream = [NSInputStream inputStreamWithFileAtPath:[PersistentState filename]];
    [stream open];
    properties = (NSMutableDictionary *)[NSPropertyListSerialization
                                         propertyListWithStream:stream
                                         options:NSPropertyListMutableContainers
                                         format:nil
                                         error:&error];
    [stream close];
  }
  if (!properties) {
    properties = [NSMutableDictionary dictionaryWithCapacity:1];
  }
  [properties retain];
}

+ (void)setProperty:(NSString *)propertyName toValue:(NSString *)value {
  if (value) {
    [properties setObject:value forKey:propertyName];
  } else {
    [properties removeObjectForKey:propertyName];
  }
  [PersistentState save];
}

+ (NSString *)get:(NSString *)propertyName {
  return (NSString *)[properties objectForKey:propertyName];
}

+ (void)clearProperty:(NSString *)propertyName {
  [properties removeObjectForKey:propertyName];
  [PersistentState save];
}

@end
