//
//  FlightRequirmentsViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/8/22.
//

#import "FlightRequirmentsViewController.h"
#import "HotelRequirementsViewController.h"
#import "Flights_Information.h"
@interface FlightRequirmentsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *departureCity;
@property (strong, nonatomic) IBOutlet UITextField *arrivalCity;
@property (strong, nonatomic) IBOutlet UIDatePicker *departingDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *returnDate;
@property (strong, nonatomic) IBOutlet UITextField *numberOfTravelers;
@property (strong, nonatomic) IBOutlet UIButton *cabin;
- (IBAction)saveInfo:(id)sender;


@end

@implementation FlightRequirmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (IBAction)saveInfo:(id)sender {
}

-(void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing Field(s)" message:@"Enter the required fields" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:tryAgain];
    [self presentViewController:alert animated:YES completion:^{}];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"flightToHotel"]){
        HotelRequirementsViewController *hotelsView = [segue destinationViewController];
        Flights_Information *flightsInfo = [[Flights_Information alloc] init];
        if(self.departureCity.text){
            flightsInfo.departureCity = self.departureCity.text;
        } else {
            [self showAlert];
        }
        
        if(self.arrivalCity.text){
            flightsInfo.arrivalCity = self.arrivalCity.text;
        } else {
            [self showAlert];
        }
        
        if(self.departingDate.date == self.returnDate.date){
            [self showAlert];
        } else {
            flightsInfo.departureDate = self.departingDate.date;
            flightsInfo.returnDate = self.returnDate.date;
        }
        
        if(self.numberOfTravelers.text){
            flightsInfo.numberOfTravelers = self.numberOfTravelers.text;
        } else {
            [self showAlert];
        }
        hotelsView.flightInfoSaved2 = flightsInfo;
    }
}
@end
