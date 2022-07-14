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
#import "Hotels_Information.h"
#import <Foundation/Foundation.h>

@interface ResultsViewController ()
@property (strong, nonnull) NSDictionary *flightSearchInformation;
@property (nonatomic) NSDictionary *flightUserInformation;
@property (strong, nonnull) NSDictionary *carSearchInformation;
@property (nonatomic) NSDictionary *carUserInformation;
@property (strong, nonnull) NSDictionary *hotelSearchInformation;
@property (strong, nonatomic) NSDictionary *hotelUserInformation;
@property (strong, nonatomic) NSMutableArray *hotelResults;
@property (strong, nonatomic) NSMutableArray *flightsResults;
@property (strong, nonatomic) NSMutableArray *carResults;
@property (strong, nonnull) NSHTTPURLResponse *hotelsAPIOutpt;
@property (strong, nonnull) NSHTTPURLResponse *flightsAPIOutpt;
@property (strong, nonnull) NSHTTPURLResponse *carsAPIOutpt;


@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // search hotels
    
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"2ebe338c7fmsha84e37a2c76338dp16b94djsn34264f5722a0",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://priceline-com-provider.p.rapidapi.com/v1/hotels/search?sort_order=HDR&location_id=3000035821&date_checkout=2022-11-16&date_checkin=2022-11-15&star_rating_ids=3.0%2C3.5%2C4.0%2C4.5%2C5.0&rooms_number=1&amenities_ids=FINTRNT%2CFBRKFST"]
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
                                                        self.hotelsAPIOutpt = (NSHTTPURLResponse *) response;
                                                        self.hotelSearchInformation = self.hotelsAPIOutpt.allHeaderFields;
                                                        NSLog(@"%@", self.hotelSearchInformation);
                                                    }
                                                }];
    [dataTask resume];
    
    // search roundtrip flights
    NSDictionary *headersRoundTrip = @{ @"X-RapidAPI-Key": @"2ebe338c7fmsha84e37a2c76338dp16b94djsn34264f5722a0",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };

    NSMutableURLRequest *requestRoundTrip = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://priceline-com-provider.p.rapidapi.com/v2/flight/roundTrip?departure_date=2021-12-21%2C2021-12-25&adults=1&sid=iSiX639&destination_airport_code=JFK%2CYWG&origin_airport_code=YWG%2CJFK"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [requestRoundTrip setHTTPMethod:@"GET"];
    [requestRoundTrip setAllHTTPHeaderFields:headersRoundTrip];

    NSURLSession *sessionRoundTrip = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTaskRoundTrip = [sessionRoundTrip dataTaskWithRequest:requestRoundTrip
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        self.flightsAPIOutpt = (NSHTTPURLResponse *) response;
                                                        self.flightSearchInformation = self.flightsAPIOutpt.allHeaderFields;
                                                        NSLog(@"%@", self.flightSearchInformation);
                                                    }
                                                }];
    [dataTaskRoundTrip resume];
    
    // search one way flights
    NSDictionary *headersOneWayFlights = @{ @"X-RapidAPI-Key": @"2ebe338c7fmsha84e37a2c76338dp16b94djsn34264f5722a0",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };

    NSMutableURLRequest *requestOneWayFlights = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://priceline-com-provider.p.rapidapi.com/v2/flight/departures?sid=iSiX639&departure_date=2022-06-21&adults=1&origin_airport_code=YWG&destination_airport_code=JFK"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [requestOneWayFlights setHTTPMethod:@"GET"];
    [requestOneWayFlights setAllHTTPHeaderFields:headersOneWayFlights];

    NSURLSession *sessionOneWayFlights = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTaskOneWayFlights = [sessionOneWayFlights dataTaskWithRequest:requestOneWayFlights
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        self.flightsAPIOutpt = (NSHTTPURLResponse *) response;
                                                        self.flightSearchInformation = self.flightsAPIOutpt.allHeaderFields;
                                                        NSLog(@"%@", self.flightSearchInformation);
                                                    }
                                                }];
    [dataTaskOneWayFlights resume];
    
    // search car results
    NSDictionary *headersCars = @{ @"X-RapidAPI-Key": @"2ebe338c7fmsha84e37a2c76338dp16b94djsn34264f5722a0",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };

    NSMutableURLRequest *requestCars = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://priceline-com-provider.p.rapidapi.com/v2/cars/resultsRequest?dropoff_time=10%3A00&dropoff_date=04%2F02%2F2022&pickup_time=10%3A00&pickup_date=04%2F01%2F2022&dropoff_city_id=800049480&dropoff_city_string=New%20York&pickup_airport_code=JFK"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [requestCars setHTTPMethod:@"GET"];
    [requestCars setAllHTTPHeaderFields:headersCars];

    NSURLSession *sessionCars = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTaskCars = [sessionCars dataTaskWithRequest:requestCars
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        self.carsAPIOutpt = (NSHTTPURLResponse *) response;
                                                        self.carSearchInformation = self.carsAPIOutpt.allHeaderFields;
                                                        NSLog(@"%@", self.carSearchInformation);
                                                    }
                                                }];
    [dataTaskCars resume];
}



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
