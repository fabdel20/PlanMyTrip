//
//  FlightRequirmentsViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/8/22.
//

#import "FlightRequirmentsViewController.h"
#import "Flights_Information.h"
@interface FlightRequirmentsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *departureCity;
@property (strong, nonatomic) IBOutlet UITextField *arrivalCity;
@property (strong, nonatomic) IBOutlet UIDatePicker *departingDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *returnDate;
@property (strong, nonatomic) IBOutlet UITextField *numberOfTravelers;
@property (strong, nonatomic) IBOutlet UIButton *cabin;


@end

@implementation FlightRequirmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.flightsInfo.departureCity = (NSString *) _departureCity;
    self.flightsInfo.arrivalCity = (NSString *) _arrivalCity;
    self.flightsInfo.departureDate = (NSDate *) _departingDate.date;
    self.flightsInfo.returnDate = (NSDate *) _returnDate.date;
    self.flightsInfo.numberOfTravelers = (int) _numberOfTravelers;
    self.flightsInfo.cabin = (NSString *) _cabin;
}


@end
