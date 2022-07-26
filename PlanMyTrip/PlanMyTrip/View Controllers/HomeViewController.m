//
//  HomeViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/6/22.
//

#import "HomeViewController.h"
#import "TripTypeViewController.h"
@interface HomeViewController ()
- (IBAction)planNewTrip:(id)sender;

@end

@implementation HomeViewController
//homeToTripType
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.savedItineraries);
    NSLog(@"%@", self.itinCount);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TripTypeViewController *newView = [segue destinationViewController];
    newView.itinCount = self.itinCount;
    newView.savedItineraries = self.savedItineraries;
}

- (IBAction)planNewTrip:(id)sender {
    [self performSegueWithIdentifier:@"homeToTripType" sender:sender];
}
@end
