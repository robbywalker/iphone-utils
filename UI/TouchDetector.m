//
//  TouchDetector.m
//  FunRun
//
//  Created by Robert Walker on 2/20/09.
//  Copyright 2009 Fitnio. All rights reserved.
//

#import "TouchDetector.h"


@implementation TouchDetector

@synthesize touchDelegate;

// Draw nothing.
- (void)drawRect:(CGRect)rect {
	return;
}

// Treat hit test events as indication that the window was touched.

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	[self.touchDelegate handleTouch];
	return nil;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	[self.touchDelegate handleTouch];
	return NO;
}

@end
