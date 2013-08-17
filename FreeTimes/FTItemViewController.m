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
    [self.itemName becomeFirstResponder];
    if (!self.itemToEdit) {
        self.doneBarButton.enabled = NO;
    }
    
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
    self.doneBarButton.enabled = newText.length > 0;
    return YES;
}

@end
