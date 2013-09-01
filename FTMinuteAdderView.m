//
//  FTMinuteAdderView.m
//  FreeTimes
//
//  Created by James Quintana on 8/26/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import "FTMinuteAdderView.h"
#import "FTColorConverter.h"

@implementation FTMinuteAdderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.minutes = 5;
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:(self) action:@selector(pan:)];
        [self addGestureRecognizer:panRecognizer];
        [self setNeedsDisplay];
    }
    return self;
}

- (void)pan:(UIGestureRecognizer *)sender {
    CGPoint tapPoint = [sender locationInView:self];
    self.minutes = (((tapPoint.y-30)/(double)self.frame.size.height)*60);
    if (self.minutes > 60) self.minutes=60;
    [self setNeedsDisplay];
    [self.delegate minuteAdderWasDragged:self.minutes];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *bars = [UIBezierPath bezierPath];
    UIBezierPath *newBar = [UIBezierPath bezierPath];
    [newBar setLineWidth:7];
    unsigned int currentColor = 0xfbfbfb-0x030906;
    for (int c = 0; c < self.minutes; c++) {
        [newBar moveToPoint:CGPointMake(0, 30+c*12)];
        [newBar addLineToPoint:(CGPointMake(self.frame.size.width, 5+c*12))];
        [UIColorFromHexCode(currentColor) setStroke];
        [newBar stroke];
        [bars appendPath:newBar];
        currentColor -= 0x010302;
        [newBar removeAllPoints];
    }
}


@end
