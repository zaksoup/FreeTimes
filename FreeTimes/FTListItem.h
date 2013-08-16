//
//  FTListItem.h
//  FreeTimes
//
//  Created by Zak Auerbach on 8/16/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTListItem : NSObject

- (void)toggleHidden;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, assign) int time;

@end
