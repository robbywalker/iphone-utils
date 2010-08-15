//
//  BackgroundTouchView.h
//  FunRun
//
//  Created by Robert Walker on 3/28/09.
//  Copyright 2009 Fitnio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchDetector.h"


@interface BackgroundTouchView : UIScrollView {
	id<TouchDetectorDelegate> touchDelegate;
}

@property (nonatomic, assign) id<TouchDetectorDelegate> touchDelegate;

@end
