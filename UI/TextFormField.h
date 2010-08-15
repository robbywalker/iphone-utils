//
//  TextFormField.h
//  FunRun
//
//  Created by Robert Walker on 2/1/09.
//  Copyright 2009 Fitnio. All rights reserved.
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
