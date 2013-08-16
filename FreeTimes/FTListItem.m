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

- (id)initWithName:(NSString *)name andTime:(int)time {
    if ((self = [super init])) {
        self.name = name;
        self.time = time;
        self.hidden = NO;
    }
    
    return self;
}

- (void)toggleHidden {
    self.hidden = !self.hidden;
}

@end
