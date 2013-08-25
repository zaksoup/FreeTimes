//
//  FTColorConverter.h
//  FreeTimes
//
//  Created by James Quintana on 8/24/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>

@interface FTColorConverter : NSObject

UIColor* UIColorFromHexCode(unsigned int hexCode);

@end
