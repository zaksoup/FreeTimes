//
//  CWClockView.h
//  Clockwork8
//
//  Created by James Quintana on 8/4/13.
//  Copyright (c) 2013 Soupy Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWPolarConverter.h"

@protocol CWClockViewDelegate <NSObject>

- (void)clockViewWasTapped:(UIGestureRecognizer *)sender;

@end

@interface CWClockView : UIView

@property (nonatomic, assign) int minute;
@property (nonatomic, assign) double secondsElapsed;
@property (nonatomic, assign) double minuteReal;
@property (nonatomic, assign) CWPolarPoint hand;
@property (nonatomic, strong) UILabel *minuteLabel;
@property (nonatomic, strong) id <CWClockViewDelegate> delegate;

@property (nonatomic, assign) BOOL lockedAndFilling;
@property (nonatomic, assign) double portionFilled;
@property (nonatomic, strong) UIColor *countColor;

- (void)handlePan:(CGPoint)loc;
- (void)updateMinuteLabel;
- (void)pan:(UIGestureRecognizer *)sender;
- (void)tap:(UIGestureRecognizer *)sender;
- (void)timerFired:(NSTimer *)t;


@end
