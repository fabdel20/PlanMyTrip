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
#import "DisplayResultsViewController.h"
#import "AFNetworking.h"

@interface ResultsViewController ()
@property (nonatomic) NSMutableDictionary *flightUserInformation;
@property (nonatomic) NSMutableDictionary *carUserInformation;
@property (strong, nonatomic) NSMutableDictionary *hotelUserInformation;
@property (strong, nonnull) NSHTTPURLResponse *hotelsAPIOutpt;
@property (strong, nonnull) NSHTTPURLResponse *flightsAPIOutpt;
- (IBAction)saveInfo:(id)sender;
@property (strong, nonnull) NSHTTPURLResponse *carsAPIOutpt;
@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)callHotelAPI:(id)sender{
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"c151066f31mshf429fe6db920209p199187jsnaf96ca6dffe5",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };
    
    
    NSString *urlHotel = [NSString stringWithFormat:@"https://priceline-com-provider.p.rapidapi.com/v1/hotels/search?sort_order=HDR&location_id=%@&date_checkout=%@&date_checkin=%@&star_rating_ids=%@&rooms_number=1&amenities_ids=%@",self.hotelUserInfo.destination,self.hotelUserInfo.departureDate,self.hotelUserInfo.arrivalDate,@"3.0,3.5,4.0,4.5,5.0",@"FINTRNT,FBRKFST"];
    
    NSString* webStringURL = [urlHotel stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webStringURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        self.hotelSearchInformation = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            self.hotelResults = [[NSMutableArray alloc] init];
                                                            [self searchHotelResultsDictionary:self.hotelSearchInformation returnArray: self.hotelResults];
                                                            if(self.carStatus == 1){
                                                                [self callCarsAPI:sender];
                                                            } else {
                                                                [self performSegueWithIdentifier:@"resultsToDisplay" sender:sender];
                                                            }
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}

-(void)callFlightsAPI:(id)sender{
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"c151066f31mshf429fe6db920209p199187jsnaf96ca6dffe5",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };
    
    NSString *dates = [NSString stringWithFormat:@"%@,%@", self.flightUserInfo.departureDate, self.flightUserInfo.returnDate];
    NSString *loc1 = [NSString stringWithFormat:@"%@,%@", self.flightUserInfo.arrivalCity, self.flightUserInfo.departureCity];
    NSString *loc2 = [NSString stringWithFormat:@"%@,%@", self.flightUserInfo.departureCity, self.flightUserInfo.arrivalCity];
    
    NSString *urlFlight = [NSString stringWithFormat:@"https://priceline-com-provider.p.rapidapi.com/v2/flight/roundTrip?departure_date=%@&adults=1&sid=iSiX639&destination_airport_code=%@&origin_airport_code=%@",dates,loc1,loc2];
    
    NSString* webStringURL = [urlFlight stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webStringURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        self.flightSearchInformation = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            self.flightResults = [[NSMutableArray alloc] init];
                                                            [self searchFlightResultsDictionary:self.flightSearchInformation returnArray:self.flightResults];
                                                            if(self.hotelStatus == 1){
                                                                [self callHotelAPI:sender];
                                                            }
                                                            if(self.hotelStatus == 0 && self.carStatus == 1){
                                                                [self callCarsAPI:sender];
                                                            }
                                                            if(self.hotelStatus == 0 && self.carStatus == 0){
                                                                [self performSegueWithIdentifier:@"resultsToDisplay" sender:sender];
                                                            }
                                                        });
                                                    }
                                                }];
    [dataTask resume];
    
}

-(void)callCarsAPI:(id)sender{
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"c151066f31mshf429fe6db920209p199187jsnaf96ca6dffe5",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };
    NSString *dateAndTimePickUp = [NSString stringWithFormat:@"%@ 13:00:00", self.carUserInfo.pickUpDate];
    NSString *dateAndTimeDroppOff = [NSString stringWithFormat:@"%@ 13:00:00", self.carUserInfo.dropOffDate];
    
    NSString *urlCar = [NSString stringWithFormat:@"https://priceline-com-provider.p.rapidapi.com/v1/cars-rentals/search?location_pickup=%@&date_time_return=%@&date_time_pickup=%@&location_return=%@", self.carUserInfo.location,dateAndTimeDroppOff, dateAndTimePickUp,self.carUserInfo.location];
    
    NSString* webStringURL = [urlCar stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webStringURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        self.carSearchInformation = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            self.carResults = [[NSMutableArray alloc] init];
                                                            [self searchCarResultsDictionary:self.carSearchInformation returnArray:self.carResults];
                                                            [self performSegueWithIdentifier:@"resultsToDisplay" sender:sender];
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}

-(void)searchHotelResultsDictionary: (NSDictionary *)hotelSearchInformation returnArray: (NSMutableArray *)hotelResults{
    NSArray *hotelValues = [hotelSearchInformation objectForKey:@"hotels"];
    double minPrice = INT_MAX;
    
    for(NSMutableDictionary *hotel in hotelValues){
        NSMutableDictionary *rateSummary = [hotel objectForKey:@"ratesSummary"];
        NSString *price = [rateSummary objectForKey:@"minPrice"];
        if([price intValue] < minPrice){
            minPrice = [price intValue];
        }
    }
    
    int count = 0;
    for(NSMutableDictionary *hotel in hotelValues){
        if(count < 5){
            NSString *hotelName = [hotel objectForKey:@"name"];
            NSString *rating = [hotel objectForKey:@"starRating"];
            if([rating intValue] >= 3.0){
                NSMutableDictionary *rateSummary = [hotel objectForKey:@"ratesSummary"];
                NSString *price = [rateSummary objectForKey:@"minPrice"];
                if((minPrice = [price intValue]) || ([price intValue] <= minPrice + 200)){
                    NSMutableDictionary *newAdd = [[NSMutableDictionary alloc]init];
                    if(hotelName && rating && price){
                        [newAdd setObject:hotelName forKey:@"name"];
                        [newAdd setObject:rating forKey:@"rating"];
                        [newAdd setObject:price forKey:@"price"];
                        [hotelResults addObject:newAdd];
                        count++;
                    }
                }
            }
        }
    }
}

-(void)searchFlightResultsDictionary: (NSDictionary *)flightSearchInformation returnArray: (NSMutableArray *)flightResults{
    NSMutableDictionary *rDict = [flightSearchInformation objectForKey:@"getAirFlightRoundTrip"];
    NSDictionary *sResults = [rDict objectForKey:@"results"];
    NSDictionary *spec = [sResults objectForKey:@"air_search_rsp"];
    NSDictionary *importantResultInfo = [spec objectForKey:@"filtered_trip_summary"];
    NSString *minPrice = [importantResultInfo objectForKey:@"minTotalFareWithTaxesAndFees"];
    NSString *minDuration = [importantResultInfo objectForKey:@"minDuration"];
    NSString *maxDuration = [importantResultInfo objectForKey:@"maxDuration"];
    
    NSDictionary *priced_itinerary = [spec objectForKey:@"priced_itinerary"];
    int count = 0;
    
    for(id itinerary in priced_itinerary){
        if(count < 5){
            NSDictionary *value = [priced_itinerary objectForKey:itinerary];
            NSDictionary *pricingInfo = [value objectForKey:@"pricing_info"];
            NSString *ticketingAirline = [pricingInfo objectForKey:@"ticketing_airline"];
            NSString *price = [pricingInfo objectForKey:@"total_fare"];
            NSString *duration = [value objectForKey:@"total_trip_duration_in_hours"];
            
            if(([minDuration intValue] <= ([duration intValue] * 60))){
                if(([duration intValue]) <= ([minDuration intValue] + [maxDuration intValue])/2){
                    if(([minPrice intValue] <= [price intValue]) && ([price intValue] <= [minPrice intValue] + 100)){
                        if(ticketingAirline && price && duration){
                            NSMutableDictionary *newAdd = [[NSMutableDictionary alloc]init];
                            [newAdd setObject:ticketingAirline forKey:@"Ticketing_Airline"];
                            [newAdd setObject:price forKey:@"Price"];
                            [newAdd setObject:duration forKey:@"Duration"];
                            NSDictionary *itin_ref = [pricingInfo objectForKey:@"itinerary_reference"];
                            NSString *group_id = [itin_ref objectForKey:@"group_id"];
                            NSString *ref_id = [itin_ref objectForKey:@"ref_id"];
                            NSString *ref_key = [itin_ref objectForKey:@"ref_key"];
                            NSString *token = [itin_ref objectForKey:@"token"];
                            if(group_id && ref_id && ref_key && token){
                                [newAdd setObject:group_id forKey:@"group_id"];
                                [newAdd setObject:ref_id forKey:@"ref_id"];
                                [newAdd setObject:ref_key forKey:@"ref_key"];
                                [newAdd setObject:token forKey:@"token"];
                                [flightResults addObject:newAdd];
                                count++;
                            }
                        }
                    }
                }
            }
        }
    }
}

-(void)searchCarResultsDictionary: (NSDictionary *)carSearchInformation returnArray: (NSMutableArray *)carResults{
    NSMutableDictionary *vehicleRates = [carSearchInformation objectForKey:@"vehicleRates"];
    double minPrice = INT_MAX;
    
    for(id car in vehicleRates){
        NSMutableDictionary *currCar = [vehicleRates objectForKey:car];
        NSMutableDictionary *rates = [currCar objectForKey:@"rates"];
        NSMutableDictionary *ratesInd = [rates objectForKey:@"USD"];
        NSString *price = [ratesInd objectForKey:@"totalAllInclusivePrice"];
        if([price intValue] < minPrice){
            minPrice = [price intValue];
        }
    }
    
    int count = 0;
    for(id car in vehicleRates){
        if(count < 5){
            NSMutableDictionary *currCar = [vehicleRates objectForKey:car];
            NSMutableDictionary *rates = [currCar objectForKey:@"rates"];
            NSMutableDictionary *ratesInd = [rates objectForKey:@"USD"];
            NSString *price = [ratesInd objectForKey:@"totalAllInclusivePrice"];
            NSString *cancelation = [currCar objectForKey:@"cancellationAllowed"];
            NSString *cancelationFee = [currCar objectForKey:@"freeCancellation"];
            NSMutableDictionary *carInfo = [currCar objectForKey:@"vehicleInfo"];
            NSString *automatic = [carInfo objectForKey:@"automatic"];
            NSString *numPeople = [carInfo objectForKey:@"peopleCapacity"];
            NSString *description = [carInfo objectForKey:@"description"];
            NSString *idName = [currCar objectForKey:@"id"];
             
            if((minPrice <= [price intValue] && [price intValue] <= minPrice+100) && ([cancelation intValue]|| [cancelationFee intValue])){
                if([automatic intValue] && ([numPeople intValue] >= 4.0)){
                    NSMutableDictionary *newAdd = [[NSMutableDictionary alloc]init];
                    if(idName && description && cancelation && cancelationFee && automatic && price && numPeople){
                        [newAdd setObject:idName forKey:@"id"];
                        [newAdd setObject:description forKey:@"description"];
                        [newAdd setObject:cancelation forKey:@"cancellation_policy"];
                        [newAdd setObject:cancelationFee forKey:@"cancellation_fee"];
                        [newAdd setObject:automatic forKey:@"automatic"];
                        [newAdd setObject:price forKey:@"price"];
                        [newAdd setObject:numPeople forKey:@"number_of_passengers"];
                        [carResults addObject:newAdd];
                    }
                    count++;
                }
            }
        }
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"resultsToDisplay"]){
        DisplayResultsViewController *resultsView = [segue destinationViewController];
        resultsView.flightStatus = self.flightStatus;
        resultsView.hotelStatus = self.hotelStatus;
        resultsView.carStatus = self.carStatus; 
        resultsView.flightResults = self.flightResults;
        resultsView.hotelResults = self.hotelResults;
        resultsView.itinCount = self.itinCount;
        resultsView.savedItineraries = self.savedItineraries; 
        resultsView.carResults = self.carResults;
        resultsView.userLocal = self.userLocal; 
        resultsView.flightUserInfo = self.flightUserInfo;
        resultsView.carUserInfo = self.carUserInfo;
        resultsView.hotelUserInfo = self.hotelUserInfo;
        resultsView.tripType = self.tripType;
        resultsView.tripName = self.tripName; 
    }
}

- (IBAction)saveInfo:(id)sender {
    if(self.flightStatus){
        [self callFlightsAPI:sender];
    }
    if(!self.flightStatus && self.hotelStatus){
        [self callHotelAPI:sender];
    }
    if(!self.flightStatus && !self.hotelStatus && self.carStatus){
        [self callCarsAPI:sender];
    }
}
@end
