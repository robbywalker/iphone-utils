//
//  BackgroundTouchView.m
//  iphone-utils
//
//  Copyright 2009 The iphone-utils Authors. All Rights Reserved.
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
