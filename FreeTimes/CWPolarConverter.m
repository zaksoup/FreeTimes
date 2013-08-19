//
//  CWPolarConverter.m
//  Clockwork8
//
//  Created by James Quintana on 8/4/13.
//  Copyright (c) 2013 Soupy Apps. All rights reserved.
//

#import "CWPolarConverter.h"

@implementation CWPolarConverter

+ (CWPolarPoint)cartesianToPolar:(CGPoint)cartesian {
    double theta = atan2(cartesian.y, cartesian.x);
    double radius = sqrt(cartesian.x*cartesian.x+cartesian.y*cartesian.y);
    return CWPolarPointMake(theta, radius);
}

+ (CWPolarPoint)cartesianToPolar:(CGPoint)cartesian origin:(CGPoint)origin {
    double __x = cartesian.x-origin.x;
    double __y = cartesian.y-origin.y;
    double theta = atan2(__y, __x);
    double radius = sqrt(__x*__x+__y*__y);
    return CWPolarPointMake(theta, radius);
}

+ (CGPoint)polarToCartesian:(CWPolarPoint)polar origin:(CGPoint)origin {
    double __x = polar.radius*cos(polar.theta);
    double __y = polar.radius*sin(polar.theta);
    __x += origin.x;
    __y += origin.y;
    return CGPointMake(__x, __y);
}

+ (CGPoint)polarToCartesian:(CWPolarPoint)polar {
    double __x = polar.radius*cos(polar.theta);
    double __y = polar.radius*sin(polar.theta);
    return CGPointMake(__x, __y);
}

CWPolarPoint CWPolarPointMake (double theta, double radius) {
    CWPolarPoint thispoint;
    thispoint.theta=theta;
    thispoint.radius=radius;
    return thispoint;
}


@end
