//
//  ViewableLogDelegate.m
//  wmp
//
//  Created by Robert Walker on 6/1/10.
//  Copyright 2010 Fitnio. All rights reserved.
//

#import "ViewableLogDelegate.h"


@implementation ViewableLogDelegate

- (ViewableLogDelegate *)initWithMaxSize:(int)size andWindow:(UIWindow *)win {
  self = [super init];
  if (self) {
    maxSize = size;
    startIndex = 0;
    logItems = [[NSMutableArray arrayWithCapacity:maxSize] retain];
    
    tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 20, 320, 460)] retain];
    tableView.dataSource = self;
    tableView.delegate = self;
    visible = NO;
    window = win;
  }
  return self;
}

- (void)toggleUi {
  if (visible) {
    visible = NO;
    [tableView removeFromSuperview];
  } else {
    visible = YES;
    [tableView reloadData];
    [window addSubview:tableView];
  }
}

+ (void)install:(UIWindow *)window withMaxSize:(int)size {
  ViewableLogDelegate *delegate = [[ViewableLogDelegate alloc] initWithMaxSize:size andWindow:(UIWindow *)window];
  [LogManager addDelegate:delegate];
  
  // Detect toggle of the log view.
  UITapGestureRecognizer *tripleTapDetector = [[UITapGestureRecognizer alloc] init];
  tripleTapDetector.numberOfTapsRequired = 3;
  [tripleTapDetector addTarget:delegate action:@selector(toggleUi)];
  [window addGestureRecognizer:tripleTapDetector];
}

- (void)logMessage:(NSString *)message {
  if ([logItems count] < maxSize) {
    [logItems addObject:message];
  } else {
    [logItems replaceObjectAtIndex:startIndex withObject:message];
    startIndex = (startIndex + 1) % maxSize;
  }
  if (visible) {
    [tableView reloadData];
  }
}

#pragma mark -
#pragma mark Table Data Source

#define FONT_SIZE 12.0f
#define CELL_CONTENT_WIDTH 300.0f
#define CELL_CONTENT_MARGIN 6.0f

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *MyIdentifier = @"LogCells";
  UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:MyIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
  }

  cell.textLabel.numberOfLines = 0;
  cell.textLabel.font = [cell.textLabel.font fontWithSize:FONT_SIZE];
  cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
  cell.textLabel.text = [logItems objectAtIndex:((indexPath.row + startIndex) % [logItems count])];
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *text = [logItems objectAtIndex:((indexPath.row + startIndex) % [logItems count])];
  CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
  CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
  return size.height + (CELL_CONTENT_MARGIN * 2);
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
  return [logItems count];
}


@end
