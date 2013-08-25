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
    double x = cartesian.x-origin.x;
    double y = cartesian.y-origin.y;
    double theta = atan2(y, x);
    double radius = sqrt(x*x+y*y);
    return CWPolarPointMake(theta, radius);
}

+ (CGPoint)polarToCartesian:(CWPolarPoint)polar origin:(CGPoint)origin {
    double x = polar.radius*cos(polar.theta);
    double y = polar.radius*sin(polar.theta);
    x += origin.x;
    y += origin.y;
    return CGPointMake(x, y);
}

+ (CGPoint)polarToCartesian:(CWPolarPoint)polar {
    double x = polar.radius*cos(polar.theta);
    double y = polar.radius*sin(polar.theta);
    return CGPointMake(x, y);
}

CWPolarPoint CWPolarPointMake (double theta, double radius) {
    CWPolarPoint thispoint;
    thispoint.theta=theta;
    thispoint.radius=radius;
    return thispoint;
}


@end
