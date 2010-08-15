//
//  BackgroundTouchView.m
//  FunRun
//
//  Created by Robert Walker on 3/28/09.
//  Copyright 2009 Fitnio. All rights reserved.
//

#import "BackgroundTouchView.h"


@implementation BackgroundTouchView

@synthesize touchDelegate;

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view {
	// Check whether the view is a control, or if its parent is a control.  The latter occurs for
	// editable text fields.
	if (![view isKindOfClass:[UIControl class]] &&
		![[view superview] isKindOfClass:[UIControl class]]) {
		[touchDelegate handleTouch];
	}
	
	return [super touchesShouldBegin:touches withEvent:event inContentView:view];
}

- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated {
  // We disable this method so the call when editing text doesn't cause the view to move again.
}

- (void)setContentOffset:(CGPoint)p {
  [super setContentOffset:p];
}

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
  [super setContentOffset:contentOffset animated:animated];
}

@end
