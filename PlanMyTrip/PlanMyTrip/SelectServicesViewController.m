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
-(void)changeColorOfButton:(UIButton *) Button checkState:(BOOL)state;
@property (nonatomic) BOOL isHotelSelected;
@property (nonatomic) BOOL isFlightSelected;
@property (nonatomic) BOOL isCarSelected;
@property (strong, nonatomic) IBOutlet UIButton *carsButton;
@property (strong, nonatomic) IBOutlet UIButton *flightsButton;
@property (strong, nonatomic) IBOutlet UIButton *hotelsButton;
- (IBAction)carsButtonTapped:(id)sender;
- (IBAction)flightsButtonTapped:(id)sender;
- (IBAction)hotelsButtonTapped:(id)sender;
- (IBAction)nextButton:(id)sender;

@end

@implementation SelectServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _hotelsButton.backgroundColor = [UIColor whiteColor];
    _flightsButton.backgroundColor = [UIColor whiteColor];
    _carsButton.backgroundColor = [UIColor whiteColor];
}

-(void)changeColorOfButton:(UIButton *) Button checkState :(BOOL)state{
    Button.backgroundColor = Button ? [UIColor redColor] : [UIColor whiteColor];
    state = !state;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if(_isFlightSelected == 1){
        FlightRequirmentsViewController *flightReqsView = [segue destinationViewController];
        flightReqsView.flightStatus = _isFlightSelected;
        flightReqsView.hotelStatus = _isHotelSelected;
        flightReqsView.carStatus = _isCarSelected;
        flightReqsView.itinCount = self.itinCount;
        flightReqsView.savedItineraries = self.savedItineraries;
    }
    if(_isFlightSelected == 0 && _isHotelSelected == 1){
        HotelRequirementsViewController *hotelReq = [segue destinationViewController];
        hotelReq.flightStatus = _isFlightSelected;
        hotelReq.hotelStatus = _isHotelSelected;
        hotelReq.carStatus = _isCarSelected;
        hotelReq.itinCount = self.itinCount;
        hotelReq.savedItineraries = self.savedItineraries;
    }
    if(_isFlightSelected == 0 && _isCarSelected == 1 && _isHotelSelected == 0){
        CarRequirmentsViewController *carReqsView = [segue destinationViewController];
        carReqsView.flightStatus = _isFlightSelected;
        carReqsView.hotelStatus = _isHotelSelected;
        carReqsView.carStatus = _isCarSelected;
        carReqsView.itinCount = self.itinCount;
        carReqsView.savedItineraries = self.savedItineraries; 
    }
}


- (IBAction)nextButton:(id)sender {
    if(_isFlightSelected == 1){
        [self performSegueWithIdentifier:@"servicesToFlightReq" sender:sender];
    }
    if(_isFlightSelected == 0 && _isHotelSelected == 1){
        [self performSegueWithIdentifier:@"servicesToHotel" sender:sender];
    }
    if(_isFlightSelected == 0 && _isHotelSelected == 0 && _isCarSelected == 1){
        [self performSegueWithIdentifier:@"servicesToCar" sender:sender];
    }
}

- (IBAction)hotelsButtonTapped:(id)sender {
    //[changeColorOfButton Button:_hotelsButton checkState: _isHotelSelected];
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
