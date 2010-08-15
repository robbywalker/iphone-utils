//
//  UIUtil.m
//  wmp
//
//  Created by Robert Walker on 6/9/10.
//  Copyright 2010 Fitnio. All rights reserved.
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
