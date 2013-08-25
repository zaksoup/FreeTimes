//
//  FTColorConverter.m
//  FreeTimes
//
//  Created by James Quintana on 8/24/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import "FTColorConverter.h"

@implementation FTColorConverter

UIColor* UIColorFromHexCode(unsigned int hexCode) {
    int r = ((hexCode >> 16) & 0xFF);
    int g = ((hexCode >> 8) & 0xFF);
    int b = ((hexCode >> 0) & 0xFF);
    int a = 255;
    
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
}

@end
