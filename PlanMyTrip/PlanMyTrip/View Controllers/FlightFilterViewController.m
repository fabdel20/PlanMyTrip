//
//  FlightFilterViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/31/22.
//

#import "FlightFilterViewController.h"
#import "DisplayResultsViewController.h"
#import "FlightRequirmentsViewController.h"
#import "Flights_Information.h"

@interface FlightFilterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *minPrice;
@property (strong, nonatomic) IBOutlet UITextField *maxPrice;
@property (strong, nonatomic) IBOutlet UIButton *cancelStatus;
@property (strong, nonatomic) IBOutlet UIButton *seatStatus;
@property (assign) BOOL isSeatSelected;
@property (assign) BOOL isCancelSelected;
- (IBAction)cancelButtonTapped:(id)sender;
- (IBAction)seatButtonTapped:(id)sender;

@end

@implementation FlightFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)generateFlightResults:(id)sender {
    [self performSegueWithIdentifier:@"flightFilteredResultsToDisplay" sender:sender];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

- (IBAction)seatButtonTapped:(id)sender {
    self.seatStatus.backgroundColor = self.isSeatSelected ? UIColor.whiteColor : UIColor.redColor;
    self.isSeatSelected = !self.isSeatSelected;
}

- (IBAction)cancelButtonTapped:(id)sender {
    self.cancelStatus.backgroundColor = self.isCancelSelected ? UIColor.whiteColor : UIColor.redColor;
    self.isCancelSelected = !self.isCancelSelected;
}
@end
