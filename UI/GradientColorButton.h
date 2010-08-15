//
//  ButtonGradientImage.h
//  FunRun
//
//  Created by Robert Walker on 8/30/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    GradientColorStyleBlue       = 0,                       
	GradientColorStyleSimpleGray = 1
};
typedef NSUInteger GradientColorStyle;

@interface GradientColorButton : UIButton {
	int roundedSize;
	CGGradientRef gradient;
	GradientColorStyle gradientStyle;
}

@property (nonatomic, assign) int roundedSize;
@property (nonatomic, assign) GradientColorStyle gradientStyle;

@end
