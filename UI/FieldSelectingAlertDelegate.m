//
//  FieldSelectingAlertDelegate.m
//  Greplin
//
//  Created by Robert Walker on 8/14/10.
//  Copyright 2010 Greplin. All rights reserved.
//

#import "FieldSelectingAlertDelegate.h"


@implementation FieldSelectingAlertDelegate

- (FieldSelectingAlertDelegate *)initWithField:(UIResponder *)theField {
  if (self = [super init]) {
    field = theField;
  }
  return self;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  [field becomeFirstResponder];
}

@end
