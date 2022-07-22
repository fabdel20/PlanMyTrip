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

-(void)parseDict:(NSMutableArray *)dict resHandle:(NSString *)res{
    NSMutableDictionary *firstElem = [dict firstObject];
    res = [firstElem objectForKey:@"id"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"c151066f31mshf429fe6db920209p199187jsnaf96ca6dffe5",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };
    
    NSString *urlT = [NSString stringWithFormat:@"https://priceline-com-provider.p.rapidapi.com/v1/hotels/locations?name=%@&search_type=ALL", self.hotelInfoSaved.destination];
    
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
                                                        self.hotelInfoSaved.destination = [firstElem objectForKey:@"id"];
                                                    }
                                                }];
    [dataTask resume];
    
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
            NSDate *tempArrival = self.pickUpDate.date;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            carInfo.pickUpDate = [formatter stringFromDate:tempArrival];
        } else {
            [self showAlert];
        }
        if(self.dropOffDate.date){
            NSDate *tempArrival = self.dropOffDate.date;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            carInfo.dropOffDate = [formatter stringFromDate:tempArrival];
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
