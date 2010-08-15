//
//  PersistentState.m
//  Common
//
//  Created by Robert Walker on 8/7/10.
//  Copyright 2010 Robby Walker. All rights reserved.
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
  [properties setObject:value forKey:propertyName];
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
