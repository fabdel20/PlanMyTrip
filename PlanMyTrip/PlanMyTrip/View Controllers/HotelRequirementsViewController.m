//
//  HotelRequirementsViewController.m
//  Pods
//
//  Created by Farida Abdelmoneum on 7/8/22.
//

#import "HotelRequirementsViewController.h"
#import "CarRequirmentsViewController.h"
#import "Hotels_Information.h"

@interface HotelRequirementsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *destination;
@property (strong, nonatomic) IBOutlet UIDatePicker *arrivalDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *departureDate;
@property (strong, nonatomic) IBOutlet UITextField *numberOfGuests;
- (IBAction)saveData:(id)sender;

@end

@implementation HotelRequirementsViewController 


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)saveData:(id)sender {
}

-(void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing Field(s)" message:@"Enter the required fields" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:tryAgain];
    [self presentViewController:alert animated:YES completion:^{}];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"hotelToCars"]){
        Hotels_Information *hotelsInfo = [[Hotels_Information alloc] init];
        if(self.destination.text){
            hotelsInfo.destination = self.destination.text;
        } else {
            [self showAlert];
        }
        
        if(self.arrivalDate.date == self.departureDate.date){
            [self showAlert];
        } else {
            hotelsInfo.arrivalDate = self.arrivalDate.date;
            hotelsInfo.departureDate = self.departureDate.date;
        }
        
        if(self.numberOfGuests.text){
            hotelsInfo.numberOfGuests = self.numberOfGuests.text;
        } else {
            [self showAlert];
        }
        
        CarRequirmentsViewController *carsView = [segue destinationViewController];
        carsView.flightInfoSaved = self.flightInfoSaved2;
        carsView.hotelInfoSaved = hotelsInfo;
        
    }
}

@end
