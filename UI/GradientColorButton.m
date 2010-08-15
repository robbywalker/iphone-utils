//
//  ButtonGradientImage.m
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

#import "GradientColorButton.h"

#define RGB(r, g, b) r / 255.0, g / 255.0, b / 255.0, 1.0

static CGFloat blueLocations[4] = { 0.0, 0.2, 0.5, 1.0 };
static CGFloat blueComponents[16] = {
	RGB(120, 166, 254),
	RGB(74, 122, 235),
	RGB(66, 106, 220),
	RGB(51, 82, 172)};

static CGFloat simpleGrayLocations[4] = { 0.0, 1.0 };
static CGFloat simpleGrayComponents[8] = {
	RGB(255, 255, 255),
	RGB(233, 233, 233)};

static NSMutableSet *initialized;

@implementation GradientColorButton

+ (void)initialize {
	initialized = [[NSMutableSet setWithCapacity:1] retain];
}

- (void)setUpStyle {
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();		
	switch (gradientStyle) {
		case GradientColorStyleBlue:
			gradient = CGGradientCreateWithColorComponents(rgb, blueComponents,
														   blueLocations, 4);
			[self setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]
											 forState:UIControlStateNormal];
			[self setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.82 alpha:1.0]
											 forState:UIControlStateHighlighted];
			break;
		case GradientColorStyleSimpleGray:
			gradient = CGGradientCreateWithColorComponents(rgb, simpleGrayComponents,
														   simpleGrayLocations, 2);
			[self setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]
					   forState:UIControlStateNormal];
			[self setTitleColor:[UIColor colorWithRed:0.48 green:0.48 blue:0.48 alpha:1.0]
					   forState:UIControlStateHighlighted];			
			break;
	}
	CGColorSpaceRelease(rgb);
}

// Buttons are created in bizarre ways, and as such overriding standard constructors does no good.
// Also, no variable can be initialized in the class definition.  Hence this bizarre solution.
- (void)ensureInitialized {
	if (![initialized containsObject:self]) {
		[initialized addObject:self];

		roundedSize = 10;
		gradientStyle = GradientColorStyleBlue;
		[self setUpStyle];
	}
}

- (void)createRoundedRectPath:(CGRect)rect inContext:(CGContextRef)context {
	CGFloat left = rect.origin.x;
	CGFloat top = rect.origin.y;
	CGFloat right = left + rect.size.width;
	CGFloat bottom = top + rect.size.height;	
	
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, left, top + roundedSize);
	CGContextAddArcToPoint(context,
						   left, top,
						   left + roundedSize, top,
						   roundedSize);
	CGContextAddLineToPoint(context, right - roundedSize, top);
	CGContextAddArcToPoint(context,
						   right, top,
						   right, top + roundedSize,
						   roundedSize);
	CGContextAddLineToPoint(context, right, bottom - roundedSize);
	CGContextAddArcToPoint(context,
						   right, bottom,
						   right - roundedSize, bottom,
						   roundedSize);
	CGContextAddLineToPoint(context, left + roundedSize, bottom);
	CGContextAddArcToPoint(context,
						   left, bottom,
						   left, bottom - roundedSize,
						   roundedSize);
	CGContextClosePath(context);
}

- (void)drawRect:(CGRect)rect {
	[self ensureInitialized];
	CGContextRef context = UIGraphicsGetCurrentContext();

	[self createRoundedRectPath:rect inContext:context];
	CGContextClip(context);

	if (self.state & UIControlStateHighlighted) {
		// Highlighted
		CGContextDrawLinearGradient(context, gradient,
									CGPointMake(rect.origin.x, rect.origin.y + rect.size.height),
									CGPointMake(rect.origin.x, rect.origin.y),
									0);
	} else {
		// Normal
		CGContextDrawLinearGradient(context, gradient,
									CGPointMake(rect.origin.x, rect.origin.y),
									CGPointMake(rect.origin.x, rect.origin.y + rect.size.height),
									0);
	}
	
	[self createRoundedRectPath:rect inContext:context];
	CGContextSetRGBStrokeColor(context, 0, 0, 0, 0.2);
	CGContextSetLineWidth(context, 2.0);
	CGContextStrokePath(context);	
}

- (void)dealloc {
	[super dealloc];
	CGGradientRelease(gradient);	
}

// Property access.

- (int)roundedSize {
	[self ensureInitialized];
	return roundedSize;
}

- (void)setRoundedSize:(int)_roundedSize {
	[self ensureInitialized];
	if (roundedSize != _roundedSize) {
		roundedSize = _roundedSize;
		[self setNeedsDisplay];
	}
}

- (GradientColorStyle)gradientStyle {
	[self ensureInitialized];
	return gradientStyle;
}

- (void)setGradientStyle:(GradientColorStyle)style {
	[self ensureInitialized];
	if (style != gradientStyle) {
		gradientStyle = style;
		
		// Release the old gradient.
		if (gradient) {
			CGGradientRelease(gradient);
		}
		
		// Set up our style.
		[self setUpStyle];
		
		// Ensure the button gets redrawn.
		[self setNeedsDisplay];
	}
}

// Methods to force updates on state changes.

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	UIControlState state = self.state;
	BOOL result = [super beginTrackingWithTouch:touch withEvent:event];
	if (self.state != state) {
		[self setNeedsDisplay];
	}
	return result;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
	UIControlState state = self.state;
	[super cancelTrackingWithEvent:event];
	if (self.state != state) {
		[self setNeedsDisplay];
	}
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	UIControlState state = self.state;
	BOOL result = [super continueTrackingWithTouch:touch withEvent:event];
	if (self.state != state) {
		[self setNeedsDisplay];
	}
	return result;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	UIControlState state = self.state;
	[super endTrackingWithTouch:touch withEvent:event];
	if (self.state != state) {
		[self setNeedsDisplay];
	}
}

@end
