//
//  FTItemViewController.h
//  FreeTimes
//
//  Created by Zak Auerbach on 8/16/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FTItemViewController;

@protocol FTItemViewControllerDelegate <NSObject>

- (void)itemViewControllerDidCancel:(FTItemViewController *)controller;

@end

@interface FTItemViewController : UIViewController

@property (nonatomic, weak) id <FTItemViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *itemName;
@property (strong, nonatomic) IBOutlet UISlider *itemTime;

@end
