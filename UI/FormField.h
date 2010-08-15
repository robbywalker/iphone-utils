//
//  FormField.h
//  FunRun
//
//  Created by Robert Walker on 1/31/09.
//  Copyright 2009 Fitnio. All rights reserved.
//

#import "Form.h"

@protocol FormField

- (void)registerWithForm:(Form *)form;

- (UIView *)input;

- (void)startEditing;

- (BOOL)shouldScroll;

@end
