//
//  FieldSelectingAlertDelegate.h
//  Greplin
//
//  Created by Robert Walker on 8/14/10.
//  Copyright 2010 Greplin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FieldSelectingAlertDelegate : NSObject <UIAlertViewDelegate> {
  UIResponder *field;
}

- (FieldSelectingAlertDelegate *)initWithField:(UIResponder *)field;

@end
