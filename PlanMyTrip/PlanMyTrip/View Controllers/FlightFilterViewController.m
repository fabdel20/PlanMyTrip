//
//  FlightFilterViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/31/22.
//

#import "FlightFilterViewController.h"
#import "DisplayResultsViewController.h"
#import "FlightRequirmentsViewController.h"
#import "Flights_Information.h"

@interface FlightFilterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *minPrice;
@property (strong, nonatomic) IBOutlet UITextField *maxPrice;
@property (strong, nonatomic) IBOutlet UIButton *cancelStatus;
@property (strong, nonatomic) IBOutlet UIButton *seatStatus;
@property (strong, nonatomic) IBOutlet UIButton *airlineSelection;
@property (assign) BOOL isSeatSelected;
@property (assign) BOOL isCancelSelected;
- (IBAction)cancelButtonTapped:(id)sender;
- (IBAction)seatButtonTapped:(id)sender;

@end

@implementation FlightFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cancelStatus.backgroundColor = UIColor.whiteColor;
    self.seatStatus.backgroundColor = UIColor.whiteColor; 
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
                                                            [self performSegueWithIdentifier:@"flightFilteredResultsToDisplay" sender:sender];
                                                        });
                                                    }
                                                }];
    [dataTask resume];
    
}

-(void)searchFlightResultsDictionary: (NSDictionary *)flightSearchInformation returnArray: (NSMutableArray *)flightResults{
    NSMutableDictionary *rDict = [flightSearchInformation objectForKey:@"getAirFlightRoundTrip"];
    NSDictionary *sResults = [rDict objectForKey:@"results"];
    NSDictionary *spec = [sResults objectForKey:@"air_search_rsp"];
    NSDictionary *importantResultInfo = [spec objectForKey:@"filtered_trip_summary"];
    NSString *minDuration = [importantResultInfo objectForKey:@"minDuration"];
    NSString *maxDuration = [importantResultInfo objectForKey:@"maxDuration"];
    NSDictionary *priced_itinerary = [spec objectForKey:@"priced_itinerary"];
    int count = 0;
    
    int minPrice = INT_MIN;
    int maxPrice = INT_MAX;
    
    if(self.minPrice.text != nil){
        minPrice = [self.minPrice.text intValue];
    }
    if(self.maxPrice.text != nil){
        maxPrice = [self.maxPrice.text intValue];
    }
    for(id itinerary in priced_itinerary){
        if(count < 5){
            NSDictionary *value = [priced_itinerary objectForKey:itinerary];
            NSDictionary *pricingInfo = [value objectForKey:@"pricing_info"];
            NSString *ticketingAirline = [pricingInfo objectForKey:@"ticketing_airline"];
            NSString *price = [pricingInfo objectForKey:@"total_fare"];
            NSString *duration = [value objectForKey:@"total_trip_duration_in_hours"];
            NSString *cancelStatus = [value objectForKey:@"changes_allowed"];
            if(([minDuration intValue] <= ([duration intValue] * 60))){
                if(([duration intValue]) <= ([minDuration intValue] + [maxDuration intValue])/2){
                    if((minPrice <= [price intValue]) && ([price intValue] <= maxPrice)){
                        if([cancelStatus intValue] == self.isCancelSelected && ticketingAirline && price && duration){
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
- (IBAction)generateFlightResults:(id)sender {
    [self callFlightsAPI:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DisplayResultsViewController *displayView = [segue destinationViewController];
    displayView.flightResults = self.flightResults;
    displayView.carResults = self.carResults;
    displayView.hotelResults = self.hotelResults;
    displayView.ittinObjects = self.ittinObjects;
    displayView.flightStatus = self.flightStatus;
    displayView.hotelStatus = self.hotelStatus;
    displayView.carStatus = self.carStatus;
    displayView.savedItineraries = self.savedItineraries;
    displayView.itinCount = self.itinCount;
    displayView.userLocal = self.userLocal;
    displayView.flightUserInfo = self.flightUserInfo;
    displayView.hotelUserInfo = self.hotelUserInfo;
    displayView.carUserInfo = self.carUserInfo;
}

- (IBAction)seatButtonTapped:(id)sender {
    self.seatStatus.backgroundColor = self.isSeatSelected ? UIColor.whiteColor : UIColor.redColor;
    self.isSeatSelected = !self.isSeatSelected;
}

- (IBAction)cancelButtonTapped:(id)sender {
    self.cancelStatus.backgroundColor = self.isCancelSelected ? UIColor.whiteColor : UIColor.redColor;
    self.isCancelSelected = !self.isCancelSelected;
}
@end
