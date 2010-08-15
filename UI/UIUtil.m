//
//  UIUtil.m
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

#import "UIUtil.h"

#pragma mark UrlLink helper class

@interface UrlLink : NSObject {
  NSString *url;
}

- (id)initWithUrl:(NSString *)linkUrl;

- (void)openUrl;

@end

@implementation UrlLink

- (id)initWithUrl:(NSString *)linkUrl {
  if (self = [super init]) {
    url = [linkUrl retain];
  }
  return self;
}

- (void)openUrl {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end

#pragma mark -
#pragma mark UIUtil implementation

@implementation UIUtil

+ (UIButton *)createOverlappingButton:(UIView *)view {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = view.frame;
  [view.superview addSubview:button];
  [view.superview bringSubviewToFront:button];
  return button;
}

+ (void)setLink:(NSString *)url forView:(UIView *)view {
  UIButton *button = [UIUtil createOverlappingButton:view];
  [button addTarget:[[UrlLink alloc] initWithUrl:url] action:@selector(openUrl) forControlEvents:UIControlEventTouchUpInside];
}

+ (void)setAction:(SEL)action onTarget:(id)target forView:(UIView *)view {
  UIButton *button = [UIUtil createOverlappingButton:view];
  [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

+ (void)setHeight:(NSInteger)height forView:(UIView *)view {
  CGRect frame = view.frame;
  frame.size.height = height;
  view.frame = frame;
}

@end
