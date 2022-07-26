//
//  TripTypeViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/6/22.
//

#import "TripTypeViewController.h"
#import "SelectServicesViewController.h"

@interface TripTypeViewController ()
- (IBAction)buisnessTripButton:(id)sender;
- (IBAction)personalTripButton:(id)sender;

@end

@implementation TripTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SelectServicesViewController *newView = [segue destinationViewController];
    newView.itinCount = self.itinCount;
    newView.savedItineraries = self.savedItineraries; 
}

- (IBAction)personalTripButton:(id)sender {
    [self performSegueWithIdentifier:@"tripTypeToServices" sender:sender];
}

- (IBAction)buisnessTripButton:(id)sender {
    [self performSegueWithIdentifier:@"tripTypeToServices" sender:sender];
}
@end
