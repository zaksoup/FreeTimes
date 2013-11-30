//
//  FTListItem.h
//  FreeTimes
//
//  Created by Zak Auerbach on 8/16/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTList.h"

@class FTList;

@interface FTListItem : NSObject

- (void)toggleActive;
- (NSComparisonResult)compares:(FTListItem *)other;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, strong) NSNumber *time;
@property (nonatomic, weak) FTList *owner;
@property (nonatomic, strong) NSNumber *score;

@end
