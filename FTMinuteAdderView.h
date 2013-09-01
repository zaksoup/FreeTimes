//
//  FTMinuteAdderView.h
//  FreeTimes
//
//  Created by James Quintana on 8/26/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FTMinuteAdderViewDelegate <NSObject>

- (void)minuteAdderWasDragged:(int)minutesResult;

@end

@interface FTMinuteAdderView : UIView

@property (nonatomic, assign) int minutes;
@property (nonatomic, strong) id <FTMinuteAdderViewDelegate> delegate;

- (void)pan:(UIGestureRecognizer *)sender;

@end
