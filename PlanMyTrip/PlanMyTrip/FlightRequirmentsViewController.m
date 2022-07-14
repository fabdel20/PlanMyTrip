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
@property Flights_Information *flightsInfo;

@end

@implementation FlightRequirmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _flightsInfo.departureCity = (NSString *) _departureCity;
    _flightsInfo.arrivalCity = (NSString *) _arrivalCity;
    _flightsInfo.departureDate = (NSDate *) _departingDate.date;
    _flightsInfo.returnDate = (NSDate *) _returnDate.date;
    _flightsInfo.numberOfTravelers = (int) _numberOfTravelers;
    _flightsInfo.cabin = (NSString *) _cabin;
}


@end
