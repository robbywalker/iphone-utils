//
//  WeightTextField.h
//  FunRun
//
//  Created by Robert Walker on 7/15/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFormField.h"

@interface WeightTextField : TextFormField <UIPickerViewDataSource, UIPickerViewDelegate>

- (void)setKg:(int)kg animated:(BOOL)animated;
- (void)setLbs:(int)lbs animated:(BOOL)animated;

@end
