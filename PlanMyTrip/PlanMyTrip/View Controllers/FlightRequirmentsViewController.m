//
//  FlightRequirmentsViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/8/22.
//

#import "FlightRequirmentsViewController.h"
#import "HotelRequirementsViewController.h"
#import "CarRequirmentsViewController.h"
#import "ResultsViewController.h"
#import "Flights_Information.h"

@interface FlightRequirmentsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *departureCity;
@property (strong, nonatomic) IBOutlet UITextField *arrivalCity;
@property (strong, nonatomic) IBOutlet UIDatePicker *departingDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *returnDate;
@property (strong, nonatomic) IBOutlet UITextField *numberOfTravelers;
@property (strong, nonatomic) IBOutlet UIButton *cabin;
@property (strong, nonnull) Flights_Information *flightInfoLocal;
@property (nonatomic) BOOL arrivalCityAPICall;
@property (nonatomic) BOOL departureCityAPICall;
- (IBAction)saveInfo:(id)sender;


@end

@implementation FlightRequirmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



-(void)callAnotherAPI:(NSString *) locationInput action:(id)sender{
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"c151066f31mshf429fe6db920209p199187jsnaf96ca6dffe5",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };
    
    NSString *location = [NSString stringWithFormat:@"https://priceline-com-provider.p.rapidapi.com/v1/flights/locations?name=%@", locationInput];
    
    NSString* webStringURL = [location stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webStringURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSMutableArray *res = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSMutableDictionary *item = [res firstObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.arrivalCity.text = [item objectForKey:@"id"];
                if(self.hotelStatus){
                    [self performSegueWithIdentifier:@"flightsToHotel" sender:sender];
                }
                if(!self.hotelStatus && self.carStatus){
                    [self performSegueWithIdentifier:@"flightToCar" sender:sender];
                }
                if(!self.hotelStatus && !self.carStatus){
                    [self performSegueWithIdentifier:@"flightToResults" sender:sender];
                }
            });
            
        }
    }];
    [dataTask resume];
    
}
-(void)callAPI: (NSString *) locationInput action:(id)sender{
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"c151066f31mshf429fe6db920209p199187jsnaf96ca6dffe5",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };
    
    NSString *location = [NSString stringWithFormat:@"https://priceline-com-provider.p.rapidapi.com/v1/flights/locations?name=%@", locationInput];
    
    NSString* webStringURL = [location stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webStringURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSMutableArray *res = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSMutableDictionary *item = [res firstObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.departureCity.text = [item objectForKey:@"id"];
                if(self.hotelStatus){
                    [self callAnotherAPI:self.arrivalCity.text action:sender];
                }
                if(!self.hotelStatus && self.carStatus){
                    [self callAnotherAPI:self.arrivalCity.text action:sender];
                }
                if(!self.hotelStatus && !self.carStatus){
                    [self callAnotherAPI:self.arrivalCity.text action:sender];
                }
            });
            
        }
    }];
    [dataTask resume];
}

- (IBAction)saveInfo:(id)sender {
    if(self.hotelStatus){
        [self callAPI:self.departureCity.text action:sender];
    }
    if(!self.hotelStatus && self.carStatus){
        [self callAPI:self.departureCity.text action:sender];
    }
    if(!self.hotelStatus && !self.carStatus){
        [self callAPI:self.departureCity.text action:sender];
    }
}

-(void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing Field(s)" message:@"Enter the required fields" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:tryAgain];
    [self presentViewController:alert animated:YES completion:^{}];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Flights_Information *flightsInfo = [[Flights_Information alloc] init];
    if(self.departureCity.text && self.arrivalCity.text && self.departingDate.date != self.returnDate.date && self.numberOfTravelers.text){
        flightsInfo.departureCity = self.departureCity.text;
        flightsInfo.arrivalCity = self.arrivalCity.text;
        NSDate *tempArrival = self.departingDate.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        flightsInfo.departureDate = [formatter stringFromDate:tempArrival];
        NSDate *tempDeparture = self.returnDate.date;
        NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
        [formatter2 setDateFormat:@"yyyy-MM-dd"];
        flightsInfo.returnDate = [formatter2 stringFromDate:tempDeparture];
        flightsInfo.numberOfTravelers = self.numberOfTravelers.text;
        self.flightInfoLocal = flightsInfo;
    } else {
        [self showAlert];
    }
    
    if(self.hotelStatus){
        HotelRequirementsViewController *hotelsView = [segue destinationViewController];
        hotelsView.flightInfoSaved2 = flightsInfo;
        hotelsView.flightStatus = self.flightStatus;
        hotelsView.hotelStatus = self.hotelStatus;
        hotelsView.carStatus = self.carStatus;
        hotelsView.itinCount = self.itinCount;
        hotelsView.savedItineraries = self.savedItineraries;
        hotelsView.userLocal = self.userLocal;
        hotelsView.tripType = self.tripType;
        hotelsView.tripName = self.tripName;
    }
    if(!self.hotelStatus && self.carStatus){
        CarRequirmentsViewController *carReq = [segue destinationViewController];
        carReq.flightInfoSaved = flightsInfo;
        carReq.flightStatus = self.flightStatus;
        carReq.hotelStatus = self.hotelStatus;
        carReq.carStatus = self.carStatus;
        carReq.itinCount = self.itinCount;
        carReq.savedItineraries = self.savedItineraries;
        carReq.userLocal = self.userLocal;
        carReq.tripType = self.tripType;
        carReq.tripName = self.tripName;
    }
    if(!self.hotelStatus && !self.carStatus){
        ResultsViewController *resultsView = [segue destinationViewController];
        resultsView.flightUserInfo = flightsInfo;
        resultsView.flightStatus = self.flightStatus;
        resultsView.carStatus = self.carStatus;
        resultsView.hotelStatus = self.hotelStatus;
        resultsView.itinCount = self.itinCount;
        resultsView.savedItineraries = self.savedItineraries;
        resultsView.userLocal = self.userLocal;
        resultsView.tripName = self.tripName;
        resultsView.tripType = self.tripType; 
    }
}
@end
