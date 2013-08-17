//
//  FTListViewController.h
//  FreeTimes
//
//  Created by Zak Auerbach on 8/16/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTList.h"
#import "FTItemViewController.h"

@class FTListViewController;

@protocol FTListViewControllerDelegate <NSObject>

- (void) listViewControllerDidDone:(FTListViewController *)controller;

@end

@interface FTListViewController : UITableViewController <FTItemViewControllerDelegate>

- (IBAction)done;

@property (nonatomic, weak) id <FTListViewControllerDelegate> delegate;
@property (nonatomic, assign) int label;
@property (nonatomic, strong) FTList *list;

@end
