//
//  FTItemViewController.m
//  FreeTimes
//
//  Created by Zak Auerbach on 8/16/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import "FTItemViewController.h"

@interface FTItemViewController ()

@end

@implementation FTItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (!self.itemToEdit) {
        self.doneBarButton.enabled = NO;
    } else {
        self.itemName.text = self.itemToEdit.name;
    }
    
    self.stops = [[NSMutableArray alloc] initWithCapacity:12];
    
    for (int i = 1; i <= 12; i++) {
        [self.stops addObject:[NSNumber numberWithInt:(i*5)]];
    }
    
    self.timeSlider.continuous = YES;
    
    [self.timeSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.itemName becomeFirstResponder];
}

- (void)valueChanged:(UISlider*)sender
{
    NSUInteger index = (NSUInteger)(self.timeSlider.value + 0.5); // Round the number.
    //[self.timeSlider setValue:index animated:NO];
    //NSLog(@"index: %i", index);
    
    NSNumber *number = [self.stops objectAtIndex:index]; // <-- This is the number you want.
    NSLog(@"number: %@", number);
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@", number];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel {
    [self.delegate itemViewControllerDidCancel:self];
}


//This entire function needs to be refactored like nothing else. boy oh boy
- (IBAction)done {
    if (!self.itemToEdit) {
        self.itemToEdit = [[FTListItem alloc] init];
        self.itemToEdit.name = self.itemName.text;
        self.itemToEdit.time = self.timeNumber;
        [self.delegate itemViewController:self didFinishAddingItem:self.itemToEdit];
    } else {
        self.itemToEdit.name = self.itemName.text;
        self.itemToEdit.time = self.timeNumber;
        [self.delegate itemViewController:self didFinishEditingItem:self.itemToEdit];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    //NSLog(@"test");
    self.doneBarButton.enabled = newText.length > 0;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self done];
    return YES;
}

@end
