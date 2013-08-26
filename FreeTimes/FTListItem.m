//
//  FTListItem.m
//  FreeTimes
//
//  Created by Zak Auerbach on 8/16/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import "FTListItem.h"

@implementation FTListItem

- (id)init {
    self = [super init];
    return self;
}

- (void)toggleActive {
    self.active = !self.active;
}

@end
