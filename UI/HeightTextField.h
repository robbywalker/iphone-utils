//
//  HeightTextField.h
//  FunRun
//
//  Created by Robert Walker on 7/7/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFormField.h"

@interface HeightTextField : TextFormField <UIPickerViewDataSource, UIPickerViewDelegate>

- (void)setTotalInches:(int)inches animated:(BOOL)animated;
- (void)setCentimeters:(int)cm animated:(BOOL)animated;

@end