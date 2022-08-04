//
//  CarRequirmentsViewController.m
//  Pods
//
//  Created by Farida Abdelmoneum on 7/8/22.
//
#import "CarRequirmentsViewController.h"
#import "ResultsViewController.h"
#import "Cars_Information.h"
#import "FlightRequirmentsViewController.h"
#import "Flights_Information.h"

@interface CarRequirmentsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *location;
@property (strong, nonatomic) IBOutlet UIDatePicker *pickUpDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *dropOffDate;
@end
@implementation CarRequirmentsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)callCarAPILocation: (NSString *)location action:(id)sender{
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"c151066f31mshf429fe6db920209p199187jsnaf96ca6dffe5",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };

    
    NSString *urlT = [NSString stringWithFormat:@"https://priceline-com-provider.p.rapidapi.com/v1/cars-rentals/locations?name=%@", location];
    NSString* url = [urlT stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSMutableArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                        NSMutableDictionary *firstElem = [resDict firstObject];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            self.location.text = [firstElem objectForKey:@"id"];
                                                            [self performSegueWithIdentifier:@"carToResults" sender:sender];
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}

- (IBAction)saveInfo:(id)sender {
    [self callCarAPILocation:self.location.text action:sender];
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
        if(self.location.text && self.pickUpDate.date &&self.dropOffDate.date){
            carInfo.location = self.location.text;
            NSDate *tempArrival = self.pickUpDate.date;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            carInfo.pickUpDate = [formatter stringFromDate:tempArrival];
            NSDate *tempDrop = self.dropOffDate.date;
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            carInfo.dropOffDate = [formatter2 stringFromDate:tempDrop];
        } else {
            [self showAlert];
        }
        self.carInfoSaved = carInfo;
        ResultsViewController *resultsView = [segue destinationViewController];
        resultsView.flightUserInfo = self.flightInfoSaved;
        resultsView.hotelUserInfo = self.hotelInfoSaved;
        resultsView.carUserInfo = carInfo;
        resultsView.itinCount = self.itinCount; 
        resultsView.savedItineraries = self.savedItineraries;
        resultsView.flightStatus = self.flightStatus;
        resultsView.carStatus = self.carStatus;
        resultsView.hotelStatus = self.hotelStatus;
        resultsView.userLocal = self.userLocal; 
    }
}
@end
