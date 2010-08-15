//
//  ObjectHolder.h
//  FunRun
//
//  Created by Robert Walker on 6/29/08.
//  Copyright 2008 Fitnio. All rights reserved.
//

// Class used to hold any object.  Useful as a value for collections if the object being held is
// not an NSObject.
@interface ObjectHolder : NSObject {
	id object;
}

-(id) initializeWithObject:(id)obj;
@property (nonatomic, assign) id object;

@end

