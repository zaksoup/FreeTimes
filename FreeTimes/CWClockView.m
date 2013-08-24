//
//  CWClockView.m
//  Clockwork8
//
//  Created by James Quintana on 8/4/13.
//  Copyright (c) 2013 Soupy Apps. All rights reserved.
//

#import "CWClockView.h"

@implementation CWClockView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setMinute:15];
        CWPolarPoint end;
        end.theta=0;
        end.radius=self.frame.size.width/2.0 - 30;
        [self setHand:end];
        CGRect minuteLabelBounds = CGRectMake(frame.origin.x, self.center.y-frame.origin.y-10, frame.size.width, 20);
        self.minuteLabel = [[UILabel alloc] initWithFrame:minuteLabelBounds];
        [self.minuteLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.minuteLabel];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:(self) action:@selector(tap:)];
        [self addGestureRecognizer:tapRecognizer];
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:(self) action:@selector(pan:)];
        [self addGestureRecognizer:panRecognizer];
        [self updateMinuteLabel];
    }
    return self;
}




- (void)updateMinuteLabel {
    [self.minuteLabel setText:[NSString stringWithFormat:@"%d",[self minute]]];
}

- (void)pan:(UIGestureRecognizer *)sender {
    CGPoint tapPoint = [sender locationInView:self];
    tapPoint.x += self.frame.origin.x;
    tapPoint.y += self.frame.origin.y;
    [self handlePan:tapPoint];
    [self updateMinuteLabel];
}
- (void)tap:(UIGestureRecognizer *)sender {
    //do-something-here
    [self.delegate clockViewWasTapped:sender];
}

- (void)handlePan:(CGPoint)loc {
    _hand.theta = [CWPolarConverter cartesianToPolar:loc origin:[self center]].theta;
    NSLog(@"%f", _hand.theta);
    double degrees = _hand.theta*-180.0/M_PI;
    if (degrees > 90) degrees -= 360.0;
    [self setMinute:(5*floor(((90-degrees)-15)/30 + 1))];
    if ([self minute] == 0) {
        [self setMinute:(degrees>0?5:60)];
    }
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGPoint drawCenter;
    drawCenter.x = [self center].x-[self frame].origin.x;
    drawCenter.y = [self center].y- [self frame].origin.y;
    UIBezierPath *face = [UIBezierPath bezierPath];
    [face setLineWidth:9];
    [face moveToPoint:CGPointMake(drawCenter.x, drawCenter.y-self.hand.radius)];
    [face addArcWithCenter:drawCenter radius:self.hand.radius startAngle:(-M_PI/2.0) endAngle:self.hand.theta clockwise:YES];
    CWPolarPoint end = CWPolarPointMake(self.hand.theta, 20);
    [face addLineToPoint:[CWPolarConverter polarToCartesian:end origin:drawCenter]];
    [face moveToPoint:drawCenter];
    [[UIColor blackColor] setStroke];
    [[UIColor whiteColor] setFill];
    [face fill];
    [face stroke];
}


@end
