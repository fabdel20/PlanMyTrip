//
//  SelectServicesViewController.m
//  
//
//  Created by Farida Abdelmoneum on 7/6/22.
//

#import "SelectServicesViewController.h"
#import "FlightRequirmentsViewController.h"
#import "CarRequirmentsViewController.h"
#import "HotelRequirementsViewController.h"

@interface SelectServicesViewController ()
@property (strong, nonatomic) IBOutlet UIButton *carsButton;
@property (strong, nonatomic) IBOutlet UIButton *flightsButton;
@property (strong, nonatomic) IBOutlet UIButton *hotelsButton;
@property (assign) BOOL isHotelSelected;
@property (assign) BOOL isFlightSelected;
@property (assign) BOOL isCarSelected;
@property (nonatomic, strong) NSArray *buttons;
- (IBAction)carsButtonTapped:(id)sender;
- (IBAction)flightsButtonTapped:(id)sender;
- (IBAction)hotelsButtonTapped:(id)sender;
- (IBAction)nextButton:(id)sender;

@end

@implementation SelectServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hotelsButton.backgroundColor = [UIColor whiteColor];
    self.flightsButton.backgroundColor = [UIColor whiteColor];
    self.carsButton.backgroundColor = [UIColor whiteColor];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if(self.isFlightSelected){
        FlightRequirmentsViewController *flightReqsView = [segue destinationViewController];
        flightReqsView.flightStatus = _isFlightSelected;
        flightReqsView.hotelStatus = _isHotelSelected;
        flightReqsView.carStatus = _isCarSelected;
        flightReqsView.itinCount = self.itinCount;
        flightReqsView.savedItineraries = self.savedItineraries;
        flightReqsView.userLocal = self.userLocal;
        flightReqsView.tripType = self.tripType;
        flightReqsView.tripName = self.tripName;
    }
    if(!self.isFlightSelected && self.isHotelSelected){
        HotelRequirementsViewController *hotelReq = [segue destinationViewController];
        hotelReq.flightStatus = _isFlightSelected;
        hotelReq.hotelStatus = _isHotelSelected;
        hotelReq.carStatus = _isCarSelected;
        hotelReq.itinCount = self.itinCount;
        hotelReq.savedItineraries = self.savedItineraries;
        hotelReq.userLocal = self.userLocal;
        hotelReq.tripType = self.tripType;
        hotelReq.tripName = self.tripName;
    }
    if(!self.isFlightSelected && !self.isHotelSelected&& self.isCarSelected){
        CarRequirmentsViewController *carReqsView = [segue destinationViewController];
        carReqsView.flightStatus = _isFlightSelected;
        carReqsView.hotelStatus = _isHotelSelected;
        carReqsView.carStatus = _isCarSelected;
        carReqsView.itinCount = self.itinCount;
        carReqsView.savedItineraries = self.savedItineraries;
        carReqsView.userLocal = self.userLocal;
        carReqsView.tripType = self.tripType;
        carReqsView.tripName = self.tripName;
    }
}
- (IBAction)nextButton:(id)sender {
    if(self.isFlightSelected){
        [self performSegueWithIdentifier:@"servicesToFlightReq" sender:sender];
    }
    if(!self.isFlightSelected && self.isHotelSelected){
        [self performSegueWithIdentifier:@"servicesToHotel" sender:sender];
    }
    if(!self.isFlightSelected && !self.isHotelSelected && self.isCarSelected){
        [self performSegueWithIdentifier:@"servicesToCar" sender:sender];
    }
}
- (IBAction)hotelsButtonTapped:(id)sender {
    _hotelsButton.backgroundColor = _isHotelSelected ? UIColor.whiteColor : UIColor.redColor;
    _isHotelSelected = !_isHotelSelected;
}
- (IBAction)flightsButtonTapped:(id)sender {
    _flightsButton.backgroundColor = _isFlightSelected ? UIColor.whiteColor : UIColor.redColor;
    _isFlightSelected = !_isFlightSelected;
}
- (IBAction)carsButtonTapped:(id)sender {
    _carsButton.backgroundColor = _isCarSelected ? UIColor.whiteColor : UIColor.redColor;
    _isCarSelected = !_isCarSelected;
}
@end
