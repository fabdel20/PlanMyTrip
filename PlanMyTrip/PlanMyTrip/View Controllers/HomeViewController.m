//
//  HomeViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/6/22.
//

#import "HomeViewController.h"
#import "TripTypeViewController.h"
#import "Parse/Parse.h"

@interface HomeViewController ()
- (IBAction)planNewTrip:(id)sender;

@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TripTypeViewController *newView = [segue destinationViewController];
    newView.itinCount = self.itinCount;
    newView.savedItineraries = self.savedItineraries;
    newView.userLocal = self.userLocal;
}

- (IBAction)planNewTrip:(id)sender {
    [self performSegueWithIdentifier:@"homeToTripType" sender:sender];
}
@end
