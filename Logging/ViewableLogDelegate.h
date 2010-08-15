//
//  ViewableLogDelegate.h
//  wmp
//
//  Created by Robert Walker on 6/1/10.
//  Copyright 2010 Fitnio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LogManager.h"

@interface ViewableLogDelegate : NSObject <LogDelegate, UITableViewDataSource, UITableViewDelegate> {
  NSMutableArray *logItems;
  int maxSize;
  int startIndex;
  
  BOOL visible;
  UITableView *tableView;
  UIWindow *window;
}

+ (void)install:(UIWindow *)baseView withMaxSize:(int)size;

@end
