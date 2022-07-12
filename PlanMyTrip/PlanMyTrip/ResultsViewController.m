//
//  ResultsViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/11/22.
//

#import "ResultsViewController.h"
#import "CarRequirmentsViewController.h"
#import "FlightRequirmentsViewController.h"
#import "HotelRequirementsViewController.h"
#import <Foundation/Foundation.h>

@interface ResultsViewController ()
@property (nonatomic) NSDictionary *flightSearchInformation;
@property (nonatomic) NSDictionary *flightUserInformation;
@property (nonatomic) NSDictionary *carSearchInformation;
@property (nonatomic) NSDictionary *carUserInformation;
@property (nonatomic) NSDictionary *hotelSearchInformation;
@property (nonatomic) NSDictionary *hotelUserInformation;
@property (strong, nonatomic) NSMutableArray *hotelResults;
@property (strong, nonatomic) NSMutableArray *flightsResults;
@property (strong, nonatomic) NSMutableArray *carResults;


@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
    // to get a list of hotels from a search
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"2ebe338c7fmsha84e37a2c76338dp16b94djsn34264f5722a0",
                               @"X-RapidAPI-Host": @"priceline-com.p.rapidapi.com" };

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://priceline-com.p.rapidapi.com/hotels/3000002244?checkin_date=2021-01-22&checkout_date=2021-01-23&rooms=1&offset=0&currency=USD"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                    }
                                                }];
    [dataTask resume];
    
    // roundtrip flights
    NSDictionary *headersFlightsRound = @{ @"X-RapidAPI-Key": @"2ebe338c7fmsha84e37a2c76338dp16b94djsn34264f5722a0",
                                           @"X-RapidAPI-Host": @"priceline-com.p.rapidapi.com" };

    NSMutableURLRequest *requestFlightsRound = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://priceline-com.p.rapidapi.com/flights/SFO/LAX/2021-02-15/2021-02-25?adults=1"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [requestFlightsRound setHTTPMethod:@"GET"];
    [requestFlightsRound setAllHTTPHeaderFields:headersFlightsRound];
    
    NSURLSession *sessionFlightsRound = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTaskFlightsRound = [sessionFlightsRound  dataTaskWithRequest:requestFlightsRound completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSLog(@"%@", httpResponse);
            
        }
        
    }];
    
    [dataTaskFlightsRound resume];

    
    // one way flights
    NSDictionary *headersFlightsOneWay = @{ @"X-RapidAPI-Key": @"2ebe338c7fmsha84e37a2c76338dp16b94djsn34264f5722a0", @"X-RapidAPI-Host": @"priceline-com.p.rapidapi.com" };

    NSMutableURLRequest *requestFlightsOneWay = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://priceline-com.p.rapidapi.com/flights/LAX/SFO/2021-02-17?adults=1"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [requestFlightsOneWay setHTTPMethod:@"GET"];
    [requestFlightsOneWay setAllHTTPHeaderFields:headersFlightsOneWay];

    NSURLSession *sessionFlightsOneWay = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTaskFlightsOneWay = [sessionFlightsOneWay dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                    }
                                                }];
    [dataTaskFlightsOneWay resume];
    
    // car Rental Prices
    NSDictionary *headersCars = @{ @"X-RapidAPI-Key": @"2ebe338c7fmsha84e37a2c76338dp16b94djsn34264f5722a0",
                               @"X-RapidAPI-Host": @"priceline-com.p.rapidapi.com" };

    NSMutableURLRequest *requestCars = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://priceline-com.p.rapidapi.com/cars/SEA?pickup_date=2021-01-31T12%3A00&return_date=2021-02-10T12%3A00"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [requestCars setHTTPMethod:@"GET"];
    [requestCars setAllHTTPHeaderFields:headersCars];

    NSURLSession *sessionCars = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTaskCars = [sessionCars dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                    }
                                                }];
    [dataTaskCars resume];
    */
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"3fcc55202fmshc1444290b76fd80p1efcafjsn78fcd8f96c9b",
                               @"X-RapidAPI-Host": @"booking-com.p.rapidapi.com" };

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://booking-com.p.rapidapi.com/3fcc55202fmshc1444290b76fd80p1efcafjsn78fcd8f96c9b/v1/metadata/exchange-rates?currency=AED&locale=en-gb"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                    }
                                                }];
    [dataTask resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// I can't make a generic recomendation system, i have to make three different functions because for each service there is a specifc tag I want to check that is unique to the service
-(NSArray *)searchHotelResultsDictionary: (NSDictionary *)hotelSearchInformation userHotelRequirmentsDictionary: (NSDictionary *)hotelUserInformation returnArray: (NSMutableArray *)hotelResults{
    int count = 0;
    int minCount = 0;
    for(id key in hotelSearchInformation){
        if([hotelSearchInformation objectForKey:key] == [hotelUserInformation objectForKey:key]){
            count = count + 1;
        }
    }
    if(count < minCount){
        minCount = count;
        count = 0;
        NSString *hotelName = [hotelSearchInformation objectForKey:@"hotel_id"];
        [hotelResults addObject:(id)hotelName];
    }
    return hotelResults;
}

-(NSArray *)searchFlightResultsDictionary: (NSDictionary *)flightSearchInformation userFlightRequirmentsDictionary: (NSDictionary *)flightUserInformation returnArray: (NSMutableArray *)flightResults{
    int count = 0;
    int minCount = 0;
    for(id key in flightSearchInformation){
        if([flightSearchInformation objectForKey:key] == [flightUserInformation objectForKey:key]){
            count = count + 1;
        }
    }
    if(count < minCount){
        minCount = count;
        count = 0;
        NSString *airlineName = [flightSearchInformation objectForKey:@"flight_id"];
        [flightResults addObject:(id)airlineName];
    }
    return flightResults;
}
@end
