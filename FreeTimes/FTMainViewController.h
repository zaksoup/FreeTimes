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

@class CWClockView;

@interface FTMainViewController : UIViewController <FTListViewControllerDelegate, CWClockViewDelegate>

- (void)clockViewWasTapped:(FTListItem *)sender;
- (void)listViewControllerDidDone:(FTListViewController *)controller;
- (IBAction)goToList:(id)sender;
- (IBAction)toggleListOne:(id)sender;
- (IBAction)toggleListTwo:(id)sender;
- (IBAction)toggleListThree:(id)sender;
- (IBAction)toggleListKarma:(id)sender;

//Given that the max is 4 lists it seems like the simplest way to deal with this
//is to simply have four unique lists, rather than dealing with an NSArray.
//This is up to discussion.
@property (nonatomic, strong) FTList *karma;
@property (nonatomic, strong) FTList *listOne;
@property (nonatomic, strong) FTList *listTwo;
@property (nonatomic, strong) FTList *listThree;
@property (nonatomic, strong) FTListItem *activeTask;
@property (nonatomic, strong) CWClockView *clock;
@property (nonatomic, strong) IBOutlet UILabel *selectedTaskLabel;
@property (nonatomic, strong) NSMutableArray *toggledLists;
@property (nonatomic, strong) NSMutableArray *acceptableItemsThisTap;

@property (nonatomic, strong) NSTimer *clockCountingTimer;

@end
