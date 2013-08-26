//
//  CWClockView.m
//  Clockwork8
//
//  Created by James Quintana on 8/4/13.
//  Copyright (c) 2013 Soupy Apps. All rights reserved.
//

#import "CWClockView.h"
#import "FTColorConverter.h"

@implementation CWClockView

double secondsElapsed = 0;

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
        
        self.lockedAndFilling = NO;
        self.portionFilled = 0.0;
        self.countColor = UIColorFromHexCode(0xcb93db);
    }
    return self;
}

- (void)timerFired:(NSTimer *)t {
    secondsElapsed += 0.05;
    [self setNeedsDisplay];
    //NSLog(@"click");
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
    if (self.lockedAndFilling) {
        return; //later, handle this
    } else {
        self.lockedAndFilling = YES;
    }
    [self setNeedsDisplay];
    [self.delegate clockViewWasTapped:sender];
}

- (void)handlePan:(CGPoint)loc {
    if (self.lockedAndFilling) return;
    _hand.theta = [CWPolarConverter cartesianToPolar:loc origin:[self center]].theta;
    self.minuteReal = [CWClockView thetaToMinute:_hand.theta];
    self.minute = floor(self.minuteReal);
    if (self.minute < 5) self.minute = 5;
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
    [face setLineWidth:7];
    CWPolarPoint tempEnd;
    CGPoint tempEndCart;
    UIBezierPath *appendPath = [UIBezierPath bezierPath];
    [appendPath setLineWidth:7];
    unsigned int currentColor = 0xfbfbfb-0x030906;
    
    if (self.lockedAndFilling) {
        int fullMinutesElapsed = ((int)(floor(secondsElapsed)))/60;
        double partminutesElapsed = (secondsElapsed/60.0)-fullMinutesElapsed;
        currentColor -= 0x010302*fullMinutesElapsed;
        
        tempEnd = CWPolarPointMake([CWClockView minuteToTheta:fullMinutesElapsed], 20);
        tempEndCart = [CWPolarConverter polarToCartesian:tempEnd origin:drawCenter];
        [face moveToPoint:tempEndCart];
        tempEnd.radius = _hand.radius - (partminutesElapsed*(_hand.radius-20));
        tempEndCart = [CWPolarConverter polarToCartesian:tempEnd origin:drawCenter];
        [face addLineToPoint:tempEndCart];
        [face moveToPoint:[face currentPoint]];
        [UIColorFromHexCode(currentColor) setStroke];
        [face stroke];
        [appendPath appendPath:face];
        
        for (int thisminute = fullMinutesElapsed+1; thisminute<[self minute]; thisminute++) {
            //draw each "petal"
            [face removeAllPoints];
            tempEnd = CWPolarPointMake([CWClockView minuteToTheta:thisminute], 20);
            tempEndCart = [CWPolarConverter polarToCartesian:tempEnd origin:drawCenter];
            [face moveToPoint:tempEndCart];
            tempEnd.radius = _hand.radius;
            tempEndCart = [CWPolarConverter polarToCartesian:tempEnd origin:drawCenter];
            [face addLineToPoint:tempEndCart];
            [face moveToPoint:[face currentPoint]];
            currentColor -= 0x010302;
            [UIColorFromHexCode(currentColor) setStroke];
            [face stroke];
            [appendPath appendPath:face];
        }
        
    } else {
        int thisminute = 0;
        for (int thisminute = 0; thisminute<[self minute]; thisminute++) {
            //draw each "petal"
            [face removeAllPoints];
            tempEnd = CWPolarPointMake([CWClockView minuteToTheta:thisminute], 20);
            tempEndCart = [CWPolarConverter polarToCartesian:tempEnd origin:drawCenter];
            [face moveToPoint:tempEndCart];
            tempEnd.radius = _hand.radius;
            tempEndCart = [CWPolarConverter polarToCartesian:tempEnd origin:drawCenter];
            [face addLineToPoint:tempEndCart];
            [face moveToPoint:[face currentPoint]];
            [UIColorFromHexCode(currentColor) setStroke];
            [face stroke];
            [appendPath appendPath:face];
            currentColor -= 0x010302;
        }
        /* this block was an attempt to have new lines grow in instead of appear instantly full as you drag
         
        thisminute++;
        tempEnd = CWPolarPointMake([CWClockView minuteToTheta:thisminute], 20);
        tempEndCart = [CWPolarConverter polarToCartesian:tempEnd origin:drawCenter];
        [face moveToPoint:tempEndCart];
        tempEnd.radius = 20+(_hand.radius-20)*(self.minuteReal-self.minute);
        tempEndCart = [CWPolarConverter polarToCartesian:tempEnd origin:drawCenter];
        [face addLineToPoint:tempEndCart];
        [face moveToPoint:[face currentPoint]];
         */
        
    }
    [face stroke];
//    CGPoint drawCenter;
//    drawCenter.x = [self center].x-[self frame].origin.x;
//    drawCenter.y = [self center].y- [self frame].origin.y;
//    UIBezierPath *face = [UIBezierPath bezierPath];
//    [face setLineWidth:7];
//    [face moveToPoint:CGPointMake(drawCenter.x, drawCenter.y-self.hand.radius)];
//    [face addArcWithCenter:drawCenter radius:self.hand.radius startAngle:(-M_PI/2.0) endAngle:self.hand.theta clockwise:YES];
//    CWPolarPoint end = CWPolarPointMake(self.hand.theta, 20);
//    [face addLineToPoint:[CWPolarConverter polarToCartesian:end origin:drawCenter]];
//    [face moveToPoint:drawCenter];
//    [[UIColor blackColor] setStroke];
//    [[UIColor whiteColor] setFill];
//    [face fill];
//    [face stroke];
}

+ (double)minuteToTheta:(int)minute {
    double theta = minute;
    theta -= 1.5;
    theta *= 6;
    theta += 15;
    theta *= -1;
    theta += 90;
    return theta * M_PI/-180.0;
}

+ (double)thetaToMinute:(double)theta {
    theta = theta*-180.0/M_PI;
    if (theta > 90) theta -= 360.0;
    return (floor(((90-theta)-15)/6))+3;
}


@end
