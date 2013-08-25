//
//  FTMainViewController.m
//  FreeTimes
//
//  Created by Zak Auerbach on 8/3/13.
//  Copyright (c) 2013 Zak Auerbach. All rights reserved.
//

#import "FTMainViewController.h"

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
    CGRect allbounds = [[UIScreen mainScreen] bounds];
    CGRect clockbounds = CGRectMake(allbounds.origin.x, allbounds.origin.y + allbounds.size.height/3.0 - 120, allbounds.size.width, allbounds.size.width);
    self.clock = [[CWClockView alloc] initWithFrame:clockbounds];
    [self.clock setBackgroundColor:[UIColor whiteColor]];
    self.clock.delegate = self;
    [self.view addSubview:self.clock];

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

- (void)clockViewWasTapped:(UIGestureRecognizer *)sender {
    NSLog(@"tapped");
    if (self.clock.lockedAndFilling) {
        self.clockCountingTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self.clock selector:@selector(timerFired:) userInfo:nil repeats:YES];
    }
}

@end
