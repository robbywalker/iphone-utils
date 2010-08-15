//
//  TextFormField.m
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
