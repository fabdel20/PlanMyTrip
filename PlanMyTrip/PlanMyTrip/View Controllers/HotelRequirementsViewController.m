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
@property (strong, nonnull) NSMutableArray *APIOutput;
- (IBAction)saveData:(id)sender;

@end

@implementation HotelRequirementsViewController 


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"2ebe338c7fmsha84e37a2c76338dp16b94djsn34264f5722a0",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };
    
    NSString *location = [NSString stringWithFormat:@"https://priceline-com-provider.p.rapidapi.com/v1/flights/locations?name=%@", self.flightInfoSaved2.departureCity];
    
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
                                                        self.flightInfoSaved2.departureCity = [item objectForKey:@"id"];
                                                    }
                                                }];
    [dataTask resume];
    
    NSDictionary *headers2 = @{ @"X-RapidAPI-Key": @"2ebe338c7fmsha84e37a2c76338dp16b94djsn34264f5722a0",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };
    
    NSString *location2 = [NSString stringWithFormat:@"https://priceline-com-provider.p.rapidapi.com/v1/flights/locations?name=%@", self.flightInfoSaved2.arrivalCity];
    
    NSString* webStringURL2 = [location2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webStringURL2] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request2 setHTTPMethod:@"GET"];
    [request2 setAllHTTPHeaderFields:headers2];

    NSURLSession *session2 = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask2 = [session2 dataTaskWithRequest:request2
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSMutableArray *res = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                        NSMutableDictionary *item = [res firstObject];
                                                        self.flightInfoSaved2.arrivalCity = [item objectForKey:@"id"];
                                                    }
                                                }];
    [dataTask2 resume];
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
            NSDate *tempArrival = self.arrivalDate.date;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            hotelsInfo.arrivalDate = [formatter stringFromDate:tempArrival];
            NSDate *tempDeparture = self.departureDate.date;
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            [formatter2 setDateFormat:@"yyyy-MM-dd"];
            hotelsInfo.departureDate = [formatter2 stringFromDate:tempDeparture];
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
