//
//  FTListItem.h
//  FreeTimes
//
//  Created by Zak Auerbach on 8/16/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTListItem : NSObject

- (void)toggleActive;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, strong) NSNumber *time;

@end
