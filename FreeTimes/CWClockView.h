//
//  CWClockView.h
//  Clockwork8
//
//  Created by James Quintana on 8/4/13.
//  Copyright (c) 2013 Soupy Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWPolarConverter.h"

@interface CWClockView : UIView

@property (nonatomic) int minute;
@property (nonatomic) CWPolarPoint hand;
@property (nonatomic) UILabel *minuteLabel;

- (void)handlePan:(CGPoint)loc;
- (void)updateMinuteLabel;
- (void)pan:(UIGestureRecognizer *)sender;
- (void)tap:(UIGestureRecognizer *)sender;


@end
