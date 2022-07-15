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
    
    NSString *urlHotels = @"https://priceline-com-provider.p.rapidapi .com/v1/hotels/search?sort_order=HDR&location_id=3000035821&date_checkout=2022-11-16&date_checkin=2022-11-15&star_rating_ids=3.0%2C3.5%2C4.0%2C4.5%2C5.0&rooms_number=1&amenities_ids=FINTRNT%2CFBRKFST";
    
    NSMutableString *urlHotelsMutable = (NSMutableString *)urlHotels;
    
    // switch checkout date
    [urlHotelsMutable replaceCharactersInRange: [urlHotelsMutable rangeOfString: @"date_checkout=2022-11-16"] withString:[NSString stringWithFormat:@"date_checkout=%@", self.hotelUserInformation]];
    
    // switch check in date
    [urlHotelsMutable replaceCharactersInRange: [urlHotelsMutable rangeOfString: @"date_checkin=2022-11-15"] withString:[NSString stringWithFormat:@"date_checkin=%@", self.hotelUserInformation]];
    
    // switch location_id
    [urlHotelsMutable replaceCharactersInRange: [urlHotelsMutable rangeOfString: @"location_id=3000035821"] withString:[NSString stringWithFormat:@"location_id=%@", self.hotelUserInformation]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlHotelsMutable] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
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

    NSString *urlFlights = @"https://priceline-com-provider.p.rapidapi.com/v2/flight/roundTrip?departure_date=2021-12-21%2C2021-12-25&adults=1&sid=iSiX639&destination_airport_code=JFK%2CYWG&origin_airport_code=YWG%2CJFK";
    
    NSMutableString *urlFlightsMutable = (NSMutableString *)urlFlights;
    
    // switch departure date
    [urlFlightsMutable replaceCharactersInRange: [urlFlightsMutable rangeOfString: @"departure_date=2021-12-21"] withString:[NSString stringWithFormat:@"departure_date=%@", self.flightUserInformation]];
    
    // switch destination_airport_code
    [urlFlightsMutable replaceCharactersInRange: [urlFlightsMutable rangeOfString:@"destination_airport_code=JFK%2CYWG"] withString:[NSString stringWithFormat:@"destination_airport_code=%@", self.flightUserInformation]];
    
    // switch origin_airport_code
    [urlFlightsMutable replaceCharactersInRange: [urlFlightsMutable rangeOfString: @"origin_airport_code=YWG%2CJFK"] withString:[NSString stringWithFormat:@"destination_airport_code=%@", self.flightUserInformation]];
    
    NSMutableURLRequest *requestRoundTrip = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlFlightsMutable] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
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
    
    NSString *urlFlightsOneWay = @"https://priceline-com-provider.p.rapidapi.com/v2/flight/departures?sid=iSiX639&departure_date=2022-06-21&adults=1&origin_airport_code=YWG&destination_airport_code=JFK";
    
    NSMutableString *urlFlightsOneWayMutable = (NSMutableString *)urlFlightsOneWay;
    
    // switch departure date
    [urlFlightsOneWayMutable replaceCharactersInRange: [urlFlightsOneWayMutable rangeOfString:@"departure_date=2022-06-21"] withString:[NSString stringWithFormat:@"departure_date=%@", self.flightUserInformation]];
    
    // switch destination_airport_code
    [urlFlightsOneWayMutable replaceCharactersInRange: [urlFlightsOneWayMutable rangeOfString:@"destination_airport_code=JFK"] withString:[NSString stringWithFormat:@"destination_airport_code=%@", self.flightUserInformation]];
    
    // switch origin_airport_code
    [urlFlightsOneWayMutable replaceCharactersInRange: [urlFlightsOneWayMutable rangeOfString:@"origin_airport_code=YWG"] withString:[NSString stringWithFormat:@"origin_airport_code=%@", self.flightUserInformation]];
    
    NSMutableURLRequest *requestOneWayFlights = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlFlightsOneWayMutable] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
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
    
    NSString *urlCars = @"https://priceline-com-provider.p.rapidapi.com/v2/cars/resultsRequest?dropoff_time=10%3A00&dropoff_date=04%2F02%2F2022&pickup_time=10%3A01&pickup_date=04%2F01%2F2022&dropoff_city_id=800049480&dropoff_city_string=New%20York&pickup_airport_code=JFK";
    
    NSMutableString *urlCarsMutable = (NSMutableString *)urlCars;
    
    // switch drop off time
    [urlCarsMutable replaceCharactersInRange: [urlCarsMutable rangeOfString: @"dropoff_time=10%3A00"] withString:[NSString stringWithFormat:@"dropoff_time=%@", self.carUserInformation]];
    
    // switch dropoff date
    [urlCarsMutable replaceCharactersInRange: [urlCarsMutable rangeOfString: @"dropoff_date=04%2F02%2F2022"] withString:[NSString stringWithFormat:@"dropoff_date=%@", self.carUserInformation]];
    
    // switch pick up time
    [urlCarsMutable replaceCharactersInRange: [urlCarsMutable rangeOfString: @"pickup_time=10%3A01"] withString:[NSString stringWithFormat:@"pickup_time=%@", self.carUserInformation]];
    
    // switch pick up date
    [urlCarsMutable replaceCharactersInRange: [urlCarsMutable rangeOfString: @"pickup_date=04%2F01%2F2022"] withString:[NSString stringWithFormat:@"pickup_date=%@", self.carUserInformation]];
    
    // switch dropoff_city_id
    [urlCarsMutable replaceCharactersInRange: [urlCarsMutable rangeOfString: @"dropoff_city_id=800049480"] withString:[NSString stringWithFormat:@"dropoff_city_id=%@", self.carUserInformation]];
    
    // switch dropoff_city_string
    [urlCarsMutable replaceCharactersInRange: [urlCarsMutable rangeOfString: @"dropoff_city_string=New%20York"] withString:[NSString stringWithFormat:@"dropoff_city_string=%@", self.carUserInformation]];
    
    // switch pickup_airport_code
    [urlCarsMutable replaceCharactersInRange: [urlCarsMutable rangeOfString: @"pickup_airport_code=JFK"] withString:[NSString stringWithFormat:@"pickup_airport_code=%@", self.carUserInformation]];
    
    NSMutableURLRequest *requestCars = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlCarsMutable] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
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
