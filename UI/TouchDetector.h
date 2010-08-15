//
//  TouchDetector.h
//  FunRun
//
//  Created by Robert Walker on 2/20/09.
//  Copyright 2009 Fitnio. All rights reserved.
//

// Add a touch delegate first to detect all touches, and add it last to detect all touches that
// hit nothing.

#import <UIKit/UIKit.h>

@protocol TouchDetectorDelegate

- (void)handleTouch;

@end


@interface TouchDetector : UIView {
	id<TouchDetectorDelegate> touchDelegate;
}

@property (nonatomic, assign) id<TouchDetectorDelegate> touchDelegate;

@end
