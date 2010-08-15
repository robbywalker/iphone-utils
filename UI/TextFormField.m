//
//  TextFormField.m
//  FunRun
//
//  Created by Robert Walker on 2/1/09.
//  Copyright 2009 Fitnio. All rights reserved.
//

#import "TextFormField.h"


@implementation TextFormField

- (void)registerWithForm:(Form *)_form {
	form = [_form retain];
}

- (BOOL)shouldScroll {
	return YES;
}

- (UIView *)input {
  return nil;
}

- (void)startEditing {
	[[NSException exceptionWithName:@"abstractMethod"
							 reason:@"startEditing should be considered abstract"
						   userInfo:nil] raise];
}

@end
