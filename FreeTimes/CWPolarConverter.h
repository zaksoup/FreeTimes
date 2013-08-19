//
//  CWPolarConverter.h
//  Clockwork8
//
//  Created by James Quintana on 8/4/13.
//  Copyright (c) 2013 Soupy Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWPolarConverter : NSObject

typedef struct CWPolarPoint{
    double theta;
    double radius;
}CWPolarPoint;

+ (CWPolarPoint)cartesianToPolar:(CGPoint)cartesian;
+ (CGPoint)polarToCartesian:(CWPolarPoint)polar;

+ (CWPolarPoint)cartesianToPolar:(CGPoint)cartesian origin:(CGPoint)origin;
+ (CGPoint)polarToCartesian:(CWPolarPoint)polar origin:(CGPoint)origin;

//this is a function which is apparently different from a method so thus the C syntax
CWPolarPoint CWPolarPointMake(double theta, double radius);

@end
