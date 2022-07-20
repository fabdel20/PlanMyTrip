//
//  ResultsViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/11/22.
//

#import "ResultsViewController.h"
#import "CarRequirmentsViewController.h"
#import "FlightRequirmentsViewController.h"
#import "Flights_Information.h"
#import "HotelRequirementsViewController.h"
#import "Hotels_Information.h"
#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ResultsViewController ()
@property (strong, nonnull) NSDictionary *flightSearchInformation;
@property (nonatomic) NSMutableDictionary *flightUserInformation;
@property (strong, nonatomic) IBOutlet UILabel *JSONLabel;
@property (strong, nonnull) NSDictionary *carSearchInformation;
@property (nonatomic) NSMutableDictionary *carUserInformation;
@property (strong, nonatomic) NSMutableDictionary *hotelUserInformation;
@property (strong, nonatomic) NSMutableArray *hotelResults;
@property (strong, nonatomic) NSMutableArray *flightsResults;
@property (strong, nonatomic) NSMutableArray *carResults;
@property (strong, nonnull) NSHTTPURLResponse *hotelsAPIOutpt;
@property (strong, nonnull) NSHTTPURLResponse *flightsAPIOutpt;
@property (strong, nonnull) NSHTTPURLResponse *carsAPIOutpt;

@end

@implementation ResultsViewController

-(void) fillFlightUserInformation: (Flights_Information *) flightInfo fillDict: (NSMutableDictionary *)flightUserInfo{
    [flightUserInfo setObject:@"departure_date" forKey: flightInfo.departureDate];
    [flightUserInfo setObject:@"return_date" forKey: flightInfo.returnDate];
    [flightUserInfo setObject:@"arrival_city" forKey: flightInfo.arrivalCity];
    [flightUserInfo setObject:@"departure_city" forKey: flightInfo.departureCity];
    [flightUserInfo setObject:@"cabin" forKey: flightInfo.cabin];
}


-(void) fillHotelUserInformation: (Hotels_Information *) hotelInfo fillDict: (NSMutableDictionary *)hotelUserInfo{
    [hotelUserInfo setObject:@"departure_date" forKey: hotelInfo.departureDate];
    [hotelUserInfo setObject:@"destination" forKey: hotelInfo.destination];
    [hotelUserInfo setObject:@"arrival_date" forKey: hotelInfo.arrivalDate];
}

-(void) fillCarUserInformation: (Cars_Information *) carInfo fillDict: (NSMutableDictionary *)carUserInfo{
    [carUserInfo setObject:@"pickup_date" forKey: carInfo.pickUpDate];
    [carUserInfo setObject:@"drop_of_date" forKey: carInfo.dropOffDate];
    [carUserInfo setObject:@"location" forKey: carInfo.location];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"SIGN-UP-FOR-KEY",
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
                                                        self.hotelSearchInformation = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                        NSLog(@"%@", self.hotelSearchInformation);
                                                    }
                                                }];
    [dataTask resume];
    
    /*
    // search hotels
    
    [self fillCarUserInformation: self.carUserInfo fillDict:_carUserInformation];
    [self fillHotelUserInformation: self.hotelUserInfo fillDict:_hotelUserInformation];
    [self fillFlightUserInformation: self.flightUserInfo fillDict:_flightUserInformation];
    
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };
    
    NSString *urlHotels = @"https://priceline-com-provider.p.rapidapi .com/v1/hotels/search?sort_order=HDR&location_id=3000035821&date_checkout=2022-11-16&date_checkin=2022-11-15&star_rating_ids=3.0%2C3.5%2C4.0%2C4.5%2C5.0&rooms_number=1&amenities_ids=FINTRNT%2CFBRKFST";
    
    NSMutableString *urlHotelsMutable = (NSMutableString *)urlHotels;
    

    // switch checkout date
    [urlHotelsMutable replaceCharactersInRange: [urlHotelsMutable rangeOfString: @"date_checkout=2022-11-16"] withString:[NSString stringWithFormat:@"date_checkout=%@", self.hotelUserInfo.departureDate]];
    
    // switch check in date
    [urlHotelsMutable replaceCharactersInRange: [urlHotelsMutable rangeOfString: @"date_checkin=2022-11-15"] withString:[NSString stringWithFormat:@"date_checkin=%@", self.hotelUserInfo.arrivalDate]];
    
    // switch location_id
    [urlHotelsMutable replaceCharactersInRange: [urlHotelsMutable rangeOfString: @"location_id=3000035821"] withString:[NSString stringWithFormat:@"location_id=%@", self.hotelUserInfo.destination]];
   
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://priceline-com-provider.p.rapidapi .com/v1/hotels/search?sort_order=HDR&location_id=3000035821&date_checkout=2022-11-16&date_checkin=2022-11-15&star_rating_ids=3.0%2C3.5%2C4.0%2C4.5%2C5.0&rooms_number=1&amenities_ids=FINTRNT%2CFBRKFST"]
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
                                                        self.hotelSearchInformation = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                        NSLog(@"%@", self.hotelSearchInformation);
                                                    }
                                                }];
    [dataTask resume];
    
    // search roundtrip flights
     
     NSDictionary *headers = @{ @"X-RapidAPI-Key": @"2ebe338c7fmsha84e37a2c76338dp16b94djsn34264f5722a0",
                                @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };

     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://priceline-com-provider.p.rapidapi.com/v2/flight/roundTrip?departure_date=2022-12-21%2C2022-12-25&adults=1&sid=iSiX639&destination_airport_code=JFK%2CYWG&origin_airport_code=YWG%2CJFK"]
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
    ==================================================== above is API call i want to use
    NSDictionary *headersRoundTrip = @{ @"X-RapidAPI-Key": @"",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };

    NSString *urlFlights = @"https://priceline-com-provider.p.rapidapi.com/v2/flight/roundTrip?departure_date=2021-12-21%2C2021-12-25&adults=1&sid=iSiX639&destination_airport_code=JFK%2CYWG&origin_airport_code=YWG%2CJFK";
    
    NSMutableString *urlFlightsMutable = (NSMutableString *)urlFlights;
    
    // switch departure date
    [urlFlightsMutable replaceCharactersInRange: [urlFlightsMutable rangeOfString: @"departure_date=2021-12-21"] withString:[NSString stringWithFormat:@"departure_date=%@", self.flightUserInfo.departureDate]];
    
    // switch destination_airport_code
    [urlFlightsMutable replaceCharactersInRange: [urlFlightsMutable rangeOfString:@"destination_airport_code=JFK%2CYWG"] withString:[NSString stringWithFormat:@"destination_airport_code=%@", self.flightUserInfo.arrivalCity]];
    
    // switch origin_airport_code
    [urlFlightsMutable replaceCharactersInRange: [urlFlightsMutable rangeOfString: @"origin_airport_code=YWG%2CJFK"] withString:[NSString stringWithFormat:@"origin_airport_code=%@", self.flightUserInfo.departureCity]];
    
    NSMutableURLRequest *requestRoundTrip = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlFlightsMutable] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [requestRoundTrip setHTTPMethod:@"GET"];
    [requestRoundTrip setAllHTTPHeaderFields:headersRoundTrip];

    NSURLSession *sessionRoundTrip = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTaskRoundTrip = [sessionRoundTrip dataTaskWithRequest:requestRoundTrip
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        self.flightSearchInformation = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                        NSLog(@"%@", self.flightSearchInformation);
                                                    }
                                                }];
    [dataTaskRoundTrip resume];
    
    // search one way flights
    NSDictionary *headersOneWayFlights = @{ @"X-RapidAPI-Key": @"",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };
    
    NSString *urlFlightsOneWay = @"https://priceline-com-provider.p.rapidapi.com/v2/flight/departures?sid=iSiX639&departure_date=2022-06-21&adults=1&origin_airport_code=YWG&destination_airport_code=JFK";
    
    NSMutableString *urlFlightsOneWayMutable = (NSMutableString *)urlFlightsOneWay;
    
    // switch departure date
    [urlFlightsOneWayMutable replaceCharactersInRange: [urlFlightsOneWayMutable rangeOfString:@"departure_date=2022-06-21"] withString:[NSString stringWithFormat:@"departure_date=%@", self.flightUserInfo.departureDate]];
    
    // switch destination_airport_code
    [urlFlightsOneWayMutable replaceCharactersInRange: [urlFlightsOneWayMutable rangeOfString:@"destination_airport_code=JFK"] withString:[NSString stringWithFormat:@"destination_airport_code=%@", self.flightUserInfo.arrivalCity]];
    
    // switch origin_airport_code
    [urlFlightsOneWayMutable replaceCharactersInRange: [urlFlightsOneWayMutable rangeOfString:@"origin_airport_code=YWG"] withString:[NSString stringWithFormat:@"origin_airport_code=%@", self.flightUserInfo.departureCity]];
    
    NSMutableURLRequest *requestOneWayFlights = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlFlightsOneWayMutable] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    [requestOneWayFlights setHTTPMethod:@"GET"];
    [requestOneWayFlights setAllHTTPHeaderFields:headersOneWayFlights];

    NSURLSession *sessionOneWayFlights = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTaskOneWayFlights = [sessionOneWayFlights dataTaskWithRequest:requestOneWayFlights
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        self.flightSearchInformation = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                        NSLog(@"%@", self.flightSearchInformation);
                                                    }
                                                }];
    [dataTaskOneWayFlights resume];
    
    // search car results
    NSDictionary *headersCars = @{ @"X-RapidAPI-Key": @"",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };
    
    NSString *urlCars = @"https://priceline-com-provider.p.rapidapi.com/v2/cars/resultsRequest?dropoff_time=10%3A00&dropoff_date=04%2F02%2F2022&pickup_time=10%3A01&pickup_date=04%2F01%2F2022&dropoff_city_id=800049480&dropoff_city_string=New%20York&pickup_airport_code=JFK";
    
    NSMutableString *urlCarsMutable = (NSMutableString *)urlCars;
    
    // switch dropoff date
    [urlCarsMutable replaceCharactersInRange: [urlCarsMutable rangeOfString: @"dropoff_date=04%2F02%2F2022"] withString:[NSString stringWithFormat:@"dropoff_date=%@", self.carUserInfo.dropOffDate]];
    
    // switch pick up date
    [urlCarsMutable replaceCharactersInRange: [urlCarsMutable rangeOfString: @"pickup_date=04%2F01%2F2022"] withString:[NSString stringWithFormat:@"pickup_date=%@", self.carUserInfo.pickUpDate]];
    
    // switch dropoff_city_id
    [urlCarsMutable replaceCharactersInRange: [urlCarsMutable rangeOfString: @"dropoff_city_id=800049480"] withString:[NSString stringWithFormat:@"dropoff_city_id=%@", self.carUserInfo.location]];
    
    // switch dropoff_city_string
    [urlCarsMutable replaceCharactersInRange: [urlCarsMutable rangeOfString: @"dropoff_city_string=New%20York"] withString:[NSString stringWithFormat:@"dropoff_city_string=%@", self.carUserInfo.location]];
    
    // switch pickup_airport_code
    [urlCarsMutable replaceCharactersInRange: [urlCarsMutable rangeOfString: @"pickup_airport_code=JFK"] withString:[NSString stringWithFormat:@"pickup_airport_code=%@", self.carUserInfo.location]];
    
    NSMutableURLRequest *requestCars = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlCarsMutable] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    [requestCars setHTTPMethod:@"GET"];
    [requestCars setAllHTTPHeaderFields:headersCars];

    NSURLSession *sessionCars = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTaskCars = [sessionCars dataTaskWithRequest:requestCars
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        self.carSearchInformation = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                        NSLog(@"%@", self.carSearchInformation);
                                                    }
                                                }];
    [dataTaskCars resume];
    [self searchHotelResultsDictionary: _hotelSearchInformation userHotelRequirmentsDictionary:_hotelUserInformation returnArray:_hotelResults];
     
    */
}



// I can't make a generic recomendation system, i have to make three different functions because for each service there is a specifc tag I want to check that is unique to the service
-(NSArray *)searchHotelResultsDictionary: (NSDictionary *)hotelSearchInformation returnArray: (NSMutableArray *)hotelResults{
    NSArray *hotelValues = [hotelSearchInformation objectForKey:@"hotels"];
    
    double minPrice = INT_MAX;
    
    for(NSDictionary *hotel in hotelValues){
        NSDictionary *rateSummary = [hotel objectForKey:@"ratesSummary"];
        double price = (int64_t)[rateSummary objectForKey:@"minPrice"];
        if(price < minPrice){
            minPrice = price;
        }
    }
    
    int count = 0;
    for(NSDictionary *hotel in hotelValues){
        if(count < 5){
            NSString *hotelName = [hotel objectForKey:@"name"];
            double rating = (int64_t)[hotel objectForKey:@"starRating"];
            if(rating >= 3.0){
                NSDictionary *rateSummary = [hotel objectForKey:@"ratesSummary"];
                double price = (int64_t)[rateSummary objectForKey:@"minPrice"];
                if((minPrice = price) || (price <= minPrice + 100)){
                        NSMutableDictionary *newAdd = [NSMutableDictionary alloc];
                        [newAdd setObject:@"name" forKey:hotelName];
                        NSNumber *ratingdDub = [NSNumber numberWithDouble:rating];
                        [newAdd setObject:@"rating" forKey:[ratingdDub stringValue]];
                        NSNumber *priceDub = [NSNumber numberWithDouble:price];
                        [newAdd setObject:@"price" forKey:[priceDub stringValue]];
                        [hotelResults addObject:newAdd];
                        count++;
                }
            }
        }
    }
    
    return hotelResults;
}

-(NSArray *)searchFlightResultsDictionary: (NSDictionary *)flightSearchInformation returnArray: (NSMutableArray *)flightResults{
    NSDictionary *sResults = [flightSearchInformation objectForKey:@"results"];
    NSDictionary *spec = [sResults objectForKey:@"air_search_rsp"];
    NSDictionary *importantResultInfo = [spec objectForKey:@"filtered_trip_summary"];
    double minPrice = (int64_t)[importantResultInfo objectForKey:@"minTotalFareWithTaxesAndFees"];
    double minDuration = (int64_t)[importantResultInfo objectForKey:@"minDuration"];
    double maxDuration = (int64_t)[importantResultInfo objectForKey:@"maxDuration"];
    
    NSDictionary *priced_itinerary = [spec objectForKey:@"priced_itinerary"];
    
    int count = 0;
    
    for(id itinerary in priced_itinerary){
        if(count < 5){
            NSDictionary *value = [priced_itinerary objectForKey:itinerary];
            NSDictionary *pricingInfo = [value objectForKey:@"pricing_info"];
            NSString *ticketingAirline = [pricingInfo objectForKey:@"ticketing_airline"];
            double price = (int64_t)[pricingInfo objectForKey:@"total_fare"];
            double duration = ((int64_t)[value objectForKey:@"total_trip_duration_in_hours"]) * 60;
            
            if((minDuration <= duration) && (duration <= (minDuration + maxDuration)/2)){
                if((minPrice <= price) && (price <= minPrice + 100)){
                        NSMutableDictionary *newAdd = [NSMutableDictionary alloc];
                        [newAdd setObject:@"Ticketing_Airline" forKey:ticketingAirline];
                        NSNumber *priceDub = [NSNumber numberWithDouble:price];
                        [newAdd setObject:@"Price" forKey:[priceDub stringValue]];
                        NSNumber *durDub = [NSNumber numberWithDouble:duration];
                        [newAdd setObject:@"Duration" forKey:[durDub stringValue]];
                        NSDictionary *itin_ref = [pricingInfo objectForKey:@"itinerary_reference"];
                        NSString *group_id = [itin_ref objectForKey:@"group_id"];
                        NSString *ref_id = [itin_ref objectForKey:@"ref_id"];
                        NSString *ref_key = [itin_ref objectForKey:@"ref_key"];
                        NSString *token = [itin_ref objectForKey:@"token"];
                        [newAdd setObject:@"group_id" forKey:group_id];
                        [newAdd setObject:@"ref_id" forKey:ref_id];
                        [newAdd setObject:@"ref_key" forKey:ref_key];
                        [newAdd setObject:@"token" forKey:token];
                        [flightResults addObject:newAdd];
                        count++;
                }
            }
        }
    }
    return flightResults;
}

-(NSArray *)searchCarResultsDictionary: (NSDictionary *)carSearchInformation returnArray: (NSMutableArray *)carResults{
    NSDictionary *vehicleRates = [carSearchInformation objectForKey:@"vehicleRates"];
    
    double minPrice = INT_MAX;
    
    for(id car in vehicleRates){
        NSDictionary *rates = [car objectForKey:@"rates"];
        NSDictionary *ratesInd = [rates objectForKey:@"USD"];
        double price = (int64_t)[ratesInd objectForKey:@"totalAllInclusivePrice"];
        if(price < minPrice){
            minPrice = price;
        }
    }
    int count = 0;
    for(id car in vehicleRates){
        if(count < 5){
            NSDictionary *rates = [car objectForKey:@"rates"];
            NSDictionary *ratesInd = [rates objectForKey:@"USD"];
            double price = (int64_t)[ratesInd objectForKey:@"totalAllInclusivePrice"];
            NSString *cancelation = [car objectForKey:@"cancellationAllowed"];
            NSString *cancelationFee = [car objectForKey:@"freeCancellation"];
            NSDictionary *carInfo = [car objectForKey:@"vehicleInfo"];
            NSString *automatic = [carInfo objectForKey:@"automatic"];
            double numPeople = (int64_t)[carInfo objectForKey:@"peopleCapacity"];
            NSString *description = [carInfo objectForKey:@"description"];
            NSString *idName = [car objectForKey:@"id"];

            if(minPrice <= price && price <= minPrice+100){
                if([cancelation  isEqual: @"true"] && [cancelationFee isEqual:@"true"]){
                    if([automatic isEqual:@"true"]){
                        if(numPeople >= 5.0){
                                NSMutableDictionary *newAdd = [NSMutableDictionary alloc];
                                [newAdd setObject:@"id" forKey:idName];
                                [newAdd setObject:@"description" forKey:description];
                                [newAdd setObject:@"cancellation_policy" forKey:cancelation];
                                [newAdd setObject:@"cancellation_fee" forKey:cancelationFee];
                                [newAdd setObject:@"automatic" forKey:automatic];
                                NSNumber *priceDub = [NSNumber numberWithDouble:price];
                                [newAdd setObject:@"price" forKey:[priceDub stringValue]];
                                NSNumber *pplDub = [NSNumber numberWithDouble:numPeople];
                                [newAdd setObject:@"number_of_passengers" forKey:[pplDub stringValue]];
                                [carResults addObject:newAdd];
                                count++;
                        }
                    }
                }
            }
        }
    }
    return carResults;
}
@end
