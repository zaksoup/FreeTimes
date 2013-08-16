//
//  FTList.h
//  FreeTimes
//
//  Created by Zak Auerbach on 8/16/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTListItem.h"

@interface FTList : NSObject

- (NSUInteger)addItem:(FTListItem *)item;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSNumber *glyph;

@end
