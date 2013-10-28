//
//  FTMainViewController.m
//  FreeTimes
//
//  Created by Zak Auerbach on 8/3/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import "FTMainViewController.h"
#import "FTListItem.h"

@interface FTMainViewController ()

@end

@implementation FTMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.lists = [NSArray alloc] ini
    self.karma = [[FTList alloc] initWithGlyph:0];
    self.listOne = [[FTList alloc] initWithGlyph:1];
    self.listTwo = [[FTList alloc] initWithGlyph:2];
    self.listThree = [[FTList alloc] initWithGlyph:3];
    self.toggledLists = [[NSMutableArray alloc] init];
    CGRect allbounds = [[UIScreen mainScreen] bounds];
    CGRect clockbounds = CGRectMake(allbounds.origin.x, allbounds.origin.y + allbounds.size.height/3.0 - 120, allbounds.size.width, allbounds.size.width);
    self.clock = [[CWClockView alloc] initWithFrame:clockbounds];
    [self.clock setBackgroundColor:[UIColor whiteColor]];
    self.clock.delegate = self;
    [self.view addSubview:self.clock];
    [self.view sendSubviewToBack:self.clock];
    
    //add swipe gesture to the thing
    UIPanGestureRecognizer *swiper = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(selectedStringDidPan:)];
    
    //self.selectedTaskLabel.userInteractionEnabled = self.clock.lockedAndFilling;
    
    [self.selectedTaskLabel addGestureRecognizer:swiper];
}

- (void)selectedStringDidPan:(id)sender {
    
    if ([sender state] == UIGestureRecognizerStateEnded) {
        [self selectedStringDidFinishPanning];
    } else {
    
    //NSLog(@"butts");
        NSLog(@"%f", [sender translationInView:self.view].x);
        self.selectedTaskLabel.frame = CGRectMake([sender translationInView:self.view].x, self.selectedTaskLabel.frame.origin.y, self.selectedTaskLabel.frame.size.width, self.selectedTaskLabel.frame.size.height);
        
    }
//    [self.selectedTaskLabel setNeedsDisplay];
//    [self.activeTask.owner removeItem:self.activeTask];
//    self.activeTask = [self getRandomAcceptableItemFromToggledLists];
//    [self.selectedTaskLabel setText:self.activeTask.name];
//    [self.activeTask toggleActive];
}

- (void)selectedStringDidFinishPanning {
    if (self.selectedTaskLabel.frame.origin.x > 80) {
        NSLog(@"Delete");
        [self.clock initializeWithTime:@(self.clock.minute - self.clock.secondsElapsed/60)];
        [self.clockCountingTimer invalidate];
        [self.clock setNeedsDisplay];
    } else if (self.selectedTaskLabel.frame.origin.x < -80) {
        NSLog(@"Swap Task");
    } else {
        self.selectedTaskLabel.frame = CGRectMake(0, self.selectedTaskLabel.frame.origin.y, self.selectedTaskLabel.frame.size.width, self.selectedTaskLabel.frame.size.height);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)test:(id)sender {
    UIButton *button = (UIButton *)sender;
    //NSLog(@"%d",[test tag]);
    [self performSegueWithIdentifier:@"showList" sender:button];
}

- (IBAction)toggleListOne:(id)sender {
    UISwitch *touched = (UISwitch *)sender;
    if (touched.isOn) {
        [self.toggledLists addObject:self.listOne];
    } else {
        [self.toggledLists removeObject:self.listOne];
    }
}

- (IBAction)toggleListTwo:(id)sender {
    UISwitch *touched = (UISwitch *)sender;
    if (touched.isOn) {
        [self.toggledLists addObject:self.listTwo];
    } else {
        [self.toggledLists removeObject:self.listTwo];
    }
}

- (IBAction)toggleListThree:(id)sender {
    UISwitch *touched = (UISwitch *)sender;
    if (touched.isOn) {
        [self.toggledLists addObject:self.listThree];
    } else {
        [self.toggledLists removeObject:self.listThree];
    }
}

- (IBAction)toggleListKarma:(id)sender {
    UISwitch *touched = (UISwitch *)sender;
    if (touched.isOn) {
        [self.toggledLists addObject:self.karma];
    } else {
        [self.toggledLists removeObject:self.karma];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *navigationController = segue.destinationViewController;
    FTListViewController *controller = (FTListViewController *)navigationController.topViewController;
    
    UIButton *button = (UIButton *)sender;
    
    controller.label = button.tag;
    controller.delegate = self;
    //I'm sure this is not the best way to do this.
    switch (button.tag) {
        case 1:
            controller.list = self.karma;
            break;
        case 2:
            controller.list = self.listOne;
            break;
        case 3:
            controller.list = self.listTwo;
            break;
        case 4:
            controller.list = self.listThree;
            break;
        default:
            controller.list = self.karma;
            break;
    }
}

- (void)listViewControllerDidDone:(FTListViewController *)controller {
    //NSLog(@"listviewcontroller done");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clockViewWasTapped:(FTListItem *)randomItem {
    NSLog(@"tapped");
    if (self.clock.lockedAndFilling) {
        self.activeTask = randomItem;
        self.selectedTaskLabel.text = self.activeTask.name;
        [self.activeTask toggleActive];
        self.clockCountingTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self.clock selector:@selector(timerFired:) userInfo:nil repeats:YES];
    }
    self.selectedTaskLabel.userInteractionEnabled=self.clock.lockedAndFilling;
}

- (FTListItem *)getRandomAcceptableItemFromToggledLists {
    NSMutableArray *acceptableItems = [[NSMutableArray alloc] init];
    for (FTList *onList in self.toggledLists) {
        for (FTListItem *selectedItem in onList.items) {
            if ([selectedItem.time intValue] <= self.clock.minute-self.clock.secondsElapsed && selectedItem.active) [acceptableItems addObject:selectedItem];
        }
    }
    if (acceptableItems.count == 0) return nil;
    FTListItem *ret = [acceptableItems objectAtIndex:(arc4random() % [acceptableItems count])];
    NSLog(@"called");
    return ret;
}

@end
