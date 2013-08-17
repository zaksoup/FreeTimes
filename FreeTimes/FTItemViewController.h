//
//  FTItemViewController.h
//  FreeTimes
//
//  Created by Zak Auerbach on 8/16/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTListItem.h"

@class FTItemViewController;

@protocol FTItemViewControllerDelegate <NSObject>

- (void)itemViewControllerDidCancel:(FTItemViewController *)controller;
- (void)itemViewController:(FTItemViewController *)controller didFinishAddingItem:(FTListItem *)item;
- (void)itemViewController:(FTItemViewController *)controller didFinishEditingItem:(FTListItem *)item;

@end

@interface FTItemViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <FTItemViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *itemName;

//Time number is required for how I'm dealing with stops on the slider
@property (strong, nonatomic) IBOutlet UISlider *itemTime;
@property (strong, nonatomic) NSNumber *timeNumber;

@property (strong, nonatomic) IBOutlet UIButton *doneBarButton;
@property (strong, nonatomic) FTListItem *itemToEdit;

@end
