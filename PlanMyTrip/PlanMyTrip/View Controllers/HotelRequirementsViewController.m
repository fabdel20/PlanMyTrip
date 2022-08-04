//
//  HotelRequirementsViewController.m
//  Pods
//
//  Created by Farida Abdelmoneum on 7/8/22.
//

#import "HotelRequirementsViewController.h"
#import "CarRequirmentsViewController.h"
#import "ResultsViewController.h"
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
}

-(void)callAPI:(NSString *)location action:(id)sender{
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"c151066f31mshf429fe6db920209p199187jsnaf96ca6dffe5",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };

    NSString *urlT = [NSString stringWithFormat:@"https://priceline-com-provider.p.rapidapi.com/v1/hotels/locations?name=%@&search_type=ALL", location];
    
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
                                                        self.destination.text = [firstElem objectForKey:@"id"];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            if(self.carStatus == 1){
                                                                [self performSegueWithIdentifier:@"hotelToCars" sender:sender];
                                                            } else {
                                                                [self performSegueWithIdentifier:@"hotelToResults" sender:sender];
                                                            }
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}

- (IBAction)saveData:(id)sender {
    [self callAPI:self.destination.text action:sender];
}

-(void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing Field(s)" message:@"Enter the required fields" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:tryAgain];
    [self presentViewController:alert animated:YES completion:^{}];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Hotels_Information *hotelsInfo = [[Hotels_Information alloc] init];
    if(self.destination.text && self.arrivalDate.date != self.departureDate.date && self.numberOfGuests.text){
        hotelsInfo.destination = self.destination.text;
        NSDate *tempArrival = self.arrivalDate.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        hotelsInfo.arrivalDate = [formatter stringFromDate:tempArrival];
        NSDate *tempDeparture = self.departureDate.date;
        NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
        [formatter2 setDateFormat:@"yyyy-MM-dd"];
        hotelsInfo.departureDate = [formatter2 stringFromDate:tempDeparture];
        hotelsInfo.numberOfGuests = self.numberOfGuests.text;
    } else {
        [self showAlert];
    }
    
    if(self.carStatus == 1){
        CarRequirmentsViewController *carsView = [segue destinationViewController];
        carsView.flightInfoSaved = self.flightInfoSaved2;
        carsView.hotelInfoSaved = hotelsInfo;
        carsView.flightStatus = self.flightStatus;
        carsView.hotelStatus = self.hotelStatus;
        carsView.carStatus = self.carStatus;
        carsView.itinCount = self.itinCount;
        carsView.savedItineraries = self.savedItineraries;
        carsView.userLocal = self.userLocal;
        
    } else {
        ResultsViewController *resView = [segue destinationViewController];
        resView.hotelUserInfo = hotelsInfo;
        resView.flightStatus = self.flightStatus;
        resView.hotelStatus = self.hotelStatus;
        resView.carStatus = self.carStatus;
        resView.itinCount = self.itinCount;
        resView.savedItineraries = self.savedItineraries;
        resView.userLocal = self.userLocal;
    }
}
@end
