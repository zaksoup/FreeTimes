//
//  FTList.m
//  FreeTimes
//
//  Created by Zak Auerbach on 8/16/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import "FTList.h"

@implementation FTList

- (id)init {
    if ((self = [super init])) {
        self.items = [[NSMutableArray alloc] initWithCapacity:20];
    }
    
    return self;
}

- (id)initWithGlyph:(int)glyph {
    if ((self = [super init])) {
        self.glyph = glyph;
        self.items = [[NSMutableArray alloc] initWithCapacity:20];
    }
    
    return self;
}

- (void)addItem:(FTListItem *)item {
    [self.items addObject:item];
    
}

- (void)removeItem:(FTListItem *)item {
    [self.items removeObject:item];
}


@end
