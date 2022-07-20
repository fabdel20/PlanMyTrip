//
//  CarRequirmentsViewController.m
//  Pods
//
//  Created by Farida Abdelmoneum on 7/8/22.
//

#import "CarRequirmentsViewController.h"
#import "ResultsViewController.h"
#import "Cars_Information.h"

@interface CarRequirmentsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *location;
@property (strong, nonatomic) IBOutlet UIDatePicker *pickUpDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *dropOffDate;


@end

@implementation CarRequirmentsViewController

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
    if([segue.identifier isEqualToString:@"carToResults"]){
        Cars_Information *carInfo = [[Cars_Information alloc] init];
        
        if(self.location.text){
            carInfo.location = self.location.text;
        } else {
            [self showAlert];
        }
        
        if(self.pickUpDate.date){
            carInfo.pickUpDate = self.pickUpDate.date;
        } else {
            [self showAlert];
        }
        if(self.dropOffDate.date){
            carInfo.dropOffDate = self.dropOffDate.date;
        } else {
            [self showAlert];
        }
        self.carInfoSaved = carInfo;
        
         ResultsViewController *resultsView = [segue destinationViewController];
        resultsView.flightUserInfo = self.flightInfoSaved;
        resultsView.hotelUserInfo = self.hotelInfoSaved;
        resultsView.carUserInfo = carInfo; 
    }
}
@end
