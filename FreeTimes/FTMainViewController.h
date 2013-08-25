//
//  FTMainViewController.h
//  FreeTimes
//
//  Created by Zak Auerbach on 8/3/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTListViewController.h"
#import "FTList.h"
#import "CWClockView.h"

@interface FTMainViewController : UIViewController <FTListViewControllerDelegate, CWClockViewDelegate>

- (void)clockViewWasTapped:(UIGestureRecognizer *)sender;
- (void)listViewControllerDidDone:(FTListViewController *)controller;
- (IBAction)test:(id)sender;

//Given that the max is 4 lists it seems like the simplest way to deal with this
//is to simply have four unique lists, rather than dealing with an NSArray.
//This is up to discussion.
@property (nonatomic, strong) FTList *karma;
@property (nonatomic, strong) FTList *listOne;
@property (nonatomic, strong) FTList *listTwo;
@property (nonatomic, strong) FTList *listThree;
@property (nonatomic, strong) CWClockView *clock;

@property (nonatomic, strong) NSTimer *clockCountingTimer;

@end
