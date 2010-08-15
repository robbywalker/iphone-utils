//
//  TextFormField.h
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

#import <UIKit/UIKit.h>
#import "FormField.h"


@interface TextFormField : UITextField<FormField> {
	// UITextField clobbers the first several bytes of this object
	// when handling touches.  (this may be a simulator issue only)
	// Give it some room.
	double __a;
	double __b;
	double __c;
	double __d;
	
	Form *form;
}

@end
