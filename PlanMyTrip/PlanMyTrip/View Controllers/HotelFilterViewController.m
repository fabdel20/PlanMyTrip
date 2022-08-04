//
//  HotelFilterViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/31/22.
//

#import "HotelFilterViewController.h"
#import "DisplayResultsViewController.h"
#import "FlightRequirmentsViewController.h"
#import "Flights_Information.h"
#import "HotelRequirementsViewController.h"
@interface HotelFilterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *minPrice;
@property (strong, nonatomic) IBOutlet UITextField *maxPrice;
- (IBAction)breakfastButtonTapped:(id)sender;
@property (assign) BOOL isBreakfastButtonTapped;
- (IBAction)fitnessButtonTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *breakfastButton;
@property (strong, nonatomic) IBOutlet UIButton *fitnessButton;
@property (strong, nonatomic) IBOutlet UIButton *anyRatingButton;
- (IBAction)anyRattingButtonTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *fourPointFiveButton;
- (IBAction)fourPointFiveButtonTapped:(id)sender;
@property (assign) BOOL isFourPointFiveButtonTapped;
- (IBAction)fourButtonTapped:(id)sender;
@property (assign) BOOL isFourButtonTapped;
@property (strong, nonatomic) IBOutlet UIButton *threePointFiveButton;
- (IBAction)threePointFiveButtonTapped:(id)sender;
@property (assign) BOOL isThreePointFiveButtonTapped;
@property (assign) BOOL isAnyButtonTapped;
@property (strong, nonatomic) IBOutlet UIButton *fourButton;
@property (strong, nonatomic) IBOutlet UIButton *threeButton;
- (IBAction)threeButtonTapped:(id)sender;
@property (assign) BOOL isThreeButtonTapped;
@property (assign) BOOL isFitnessCenterButtonTapped;
- (IBAction)generateResults:(id)sender;
@property (strong, nonatomic) NSString *rating;
@property (strong,nonatomic) NSString *ameneties;
@end

@implementation HotelFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.breakfastButton.backgroundColor = [UIColor whiteColor];
    self.fitnessButton.backgroundColor = [UIColor whiteColor];
    self.anyRatingButton.backgroundColor = [UIColor whiteColor];
    self.fourPointFiveButton.backgroundColor = [UIColor whiteColor];
    self.fourButton.backgroundColor = [UIColor whiteColor];
    self.threePointFiveButton.backgroundColor = [UIColor whiteColor];
    self.threeButton.backgroundColor = [UIColor whiteColor];
}


-(void)callHotelAPI:(id)sender{
    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"c151066f31mshf429fe6db920209p199187jsnaf96ca6dffe5",
                               @"X-RapidAPI-Host": @"priceline-com-provider.p.rapidapi.com" };
    
    if(self.isFitnessCenterButtonTapped == 1 && self.isBreakfastButtonTapped == 1){
        self.ameneties = @"&amenities_ids=FINTRNT,FBRKFST";
    }
    
    if(self.isFitnessCenterButtonTapped == 0 && self.isBreakfastButtonTapped == 1){
        self.ameneties = @"&amenities_ids=FBRKFST";
    }
    
    if(self.isFitnessCenterButtonTapped == 1 && self.isBreakfastButtonTapped == 0){
        self.ameneties = @"&amenities_ids=FINTRNT";
    }
    
    if(self.isFitnessCenterButtonTapped == 0 && self.isBreakfastButtonTapped == 0){
        self.ameneties = @"";
    }
    
    if(self.rating == nil){
        self.rating = @"3.0,3.5,4.0,4.5,5.0";
    }
    
    NSString *urlHotel = [NSString stringWithFormat:@"https://priceline-com-provider.p.rapidapi.com/v1/hotels/search?sort_order=HDR&location_id=%@&date_checkout=%@&date_checkin=%@&star_rating_ids=%@&rooms_number=1%@",self.hotelUserInfo.destination,self.hotelUserInfo.departureDate,self.hotelUserInfo.arrivalDate,self.rating,self.ameneties];
    
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
                                                            [self performSegueWithIdentifier:@"HotelFilterToDisplay" sender:sender];
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}

-(void)searchHotelResultsDictionary: (NSDictionary *)hotelSearchInformation returnArray: (NSMutableArray *)hotelResults{
    NSArray *hotelValues = [hotelSearchInformation objectForKey:@"hotels"];
    
    NSString *ratingReq = @"1.0";
    
    if(self.isFourPointFiveButtonTapped == 1){
        ratingReq = @"4.5";
    }
    if(self.isFourButtonTapped == 1){
        ratingReq = @"4.0";
    }
    if(self.isThreePointFiveButtonTapped == 1){
        ratingReq = @"3.5";
    }
    if(self.isThreeButtonTapped == 1){
        ratingReq = @"3.0";
    }
    
    int minPrice = INT_MIN;
    int maxPrice = INT_MAX;
    
    if(self.minPrice.text != nil){
        minPrice = [self.minPrice.text intValue];
    }
    if(self.maxPrice.text != nil){
        maxPrice = [self.maxPrice.text intValue];
    }
    int count = 0;
    for(NSMutableDictionary *hotel in hotelValues){
        if(count < 5){
            NSString *hotelName = [hotel objectForKey:@"name"];
            NSString *rating = [hotel objectForKey:@"starRating"];
            if([rating intValue] >= [ratingReq intValue]){
                NSMutableDictionary *rateSummary = [hotel objectForKey:@"ratesSummary"];
                NSString *price = [rateSummary objectForKey:@"minPrice"];
                if((minPrice <= [price intValue]) && ([price intValue] <= maxPrice)){
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

- (IBAction)fitnessButtonTapped:(id)sender {
    self.fitnessButton.backgroundColor = self.isFitnessCenterButtonTapped ? UIColor.whiteColor : UIColor.redColor;
    self.isFitnessCenterButtonTapped = !self.isFitnessCenterButtonTapped;
}

- (IBAction)breakfastButtonTapped:(id)sender {
    self.breakfastButton.backgroundColor = self.isBreakfastButtonTapped ? UIColor.whiteColor : UIColor.redColor;
    self.isBreakfastButtonTapped = !self.isBreakfastButtonTapped;
}
- (IBAction)anyRattingButtonTapped:(id)sender {
    self.anyRatingButton.backgroundColor = self.isAnyButtonTapped ? UIColor.whiteColor : UIColor.redColor;
    self.isAnyButtonTapped = !self.isAnyButtonTapped;
    self.rating = @"1.0,2.0,3.0,3.5,4.0,4.5,5.0";
    if(self.isThreeButtonTapped == 1){
        self.isThreeButtonTapped = 0;
        self.threeButton.backgroundColor = [UIColor whiteColor];
    }
    if(self.isThreePointFiveButtonTapped == 1){
        self.isThreePointFiveButtonTapped = 0;
        self.threePointFiveButton.backgroundColor = [UIColor whiteColor];
    }
    
    if(self.isFourButtonTapped == 1){
        self.isFourButtonTapped = 0;
        self.fourButton.backgroundColor = 0;
    }
    if(self.isFourPointFiveButtonTapped == 1){
        self.isFourPointFiveButtonTapped = 0;
        self.fourPointFiveButton.backgroundColor = [UIColor whiteColor];
    }
}
- (IBAction)fourPointFiveButtonTapped:(id)sender {
    self.fourPointFiveButton.backgroundColor = self.isFourPointFiveButtonTapped ? UIColor.whiteColor : UIColor.redColor;
    self.isFourPointFiveButtonTapped = !self.isFourPointFiveButtonTapped;
    self.rating = @"4.5,5.0";
    if(self.isThreeButtonTapped == 1){
        self.isThreeButtonTapped = 0;
        self.threeButton.backgroundColor = [UIColor whiteColor];
    }
    if(self.isThreePointFiveButtonTapped == 1){
        self.isThreePointFiveButtonTapped = 0;
        self.threePointFiveButton.backgroundColor = [UIColor whiteColor];
    }
    
    if(self.isFourButtonTapped == 1){
        self.isFourButtonTapped = 0;
        self.fourButton.backgroundColor = [UIColor whiteColor];
    }
    if(self.isAnyButtonTapped == 1){
        self.isAnyButtonTapped = 0;
        self.anyRatingButton.backgroundColor = [UIColor whiteColor];
    }
}
- (IBAction)fourButtonTapped:(id)sender {
    self.fourButton.backgroundColor = self.isFourButtonTapped ? UIColor.whiteColor : UIColor.redColor;
    self.isFourButtonTapped = !self.isFourButtonTapped;
    self.rating = @"4.0,4.5,5.0";
    if(self.isThreeButtonTapped == 1){
        self.isThreeButtonTapped = 0;
        self.threeButton.backgroundColor = [UIColor whiteColor];
    }
    if(self.isThreePointFiveButtonTapped == 1){
        self.isThreePointFiveButtonTapped = 0;
        self.threePointFiveButton.backgroundColor = [UIColor whiteColor];
    }
    
    if(self.isFourPointFiveButtonTapped == 1){
        self.isFourPointFiveButtonTapped = 0;
        self.fourPointFiveButton.backgroundColor = [UIColor whiteColor];
    }
    if(self.isAnyButtonTapped == 1){
        self.isAnyButtonTapped = 0;
        self.anyRatingButton.backgroundColor = [UIColor whiteColor];
    }
}
- (IBAction)threePointFiveButtonTapped:(id)sender {
    self.threePointFiveButton.backgroundColor = self.isThreePointFiveButtonTapped ? UIColor.whiteColor : UIColor.redColor;
    self.isThreePointFiveButtonTapped = !self.isThreePointFiveButtonTapped;
    self.rating = @"3.5,4.0,4.5,5.0";
    if(self.isThreeButtonTapped == 1){
        self.isThreeButtonTapped = 0;
        self.threeButton.backgroundColor = [UIColor whiteColor];
    }
    if(self.isFourButtonTapped == 1){
        self.isFourButtonTapped = 0;
        self.fourButton.backgroundColor = [UIColor whiteColor];
    }
    if(self.isFourPointFiveButtonTapped == 1){
        self.isFourPointFiveButtonTapped = 0;
        self.fourPointFiveButton.backgroundColor = [UIColor whiteColor];
    }
    if(self.isAnyButtonTapped == 1){
        self.isAnyButtonTapped = 0;
        self.anyRatingButton.backgroundColor = [UIColor whiteColor];
    }
}

- (IBAction)threeButtonTapped:(id)sender {
    self.threeButton.backgroundColor = self.isThreeButtonTapped ? UIColor.whiteColor : UIColor.redColor;
    self.isThreeButtonTapped = !self.isThreeButtonTapped;
    self.rating = @"3.0,3.5,4.0,4.5,5.0";
    if(self.isThreePointFiveButtonTapped == 1){
        self.isThreePointFiveButtonTapped = 0;
        self.threePointFiveButton.backgroundColor = [UIColor whiteColor]; 
    }
    if(self.isFourButtonTapped == 1){
        self.isFourButtonTapped = 0;
        self.fourButton.backgroundColor = [UIColor whiteColor];
    }
    if(self.isFourPointFiveButtonTapped == 1){
        self.isFourPointFiveButtonTapped = 0;
        self.fourPointFiveButton.backgroundColor = [UIColor whiteColor];
    }
    if(self.isAnyButtonTapped == 1){
        self.isAnyButtonTapped = 0;
        self.anyRatingButton.backgroundColor = [UIColor whiteColor];
    }
}
- (IBAction)generateResults:(id)sender {
    [self callHotelAPI:sender];
}

@end
