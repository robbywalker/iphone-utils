//
//  UIUtil.h
//  wmp
//
//  Created by Robert Walker on 6/9/10.
//  Copyright 2010 Fitnio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIUtil : NSObject

+ (void)setLink:(NSString *)url forView:(UIView *)view;

+ (void)setAction:(SEL)action onTarget:(id)target forView:(UIView *)view;

+ (void)setHeight:(NSInteger)height forView:(UIView *)view;

@end
