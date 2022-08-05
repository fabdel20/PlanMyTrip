//
//  CarFilterViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/31/22.
//

#import "CarFilterViewController.h"
#import "DisplayResultsViewController.h"
@interface CarFilterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *minPrice;
@property (strong, nonatomic) IBOutlet UITextField *maxPrice;
@property (strong, nonatomic) IBOutlet UITextField *numberOfPassengers;
@property (strong, nonatomic) IBOutlet UIButton *cancellationButton;
- (IBAction)cancelButtonTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *luxuryCarButton;
- (IBAction)luxuryCarButtonTapped:(id)sender;
@property (assign) BOOL isLuxuryCarButtonTapped;
@property (strong, nonatomic) IBOutlet UIButton *fullSizeSuvButton;
@property (assign) BOOL isCancelButtonTapped;
- (IBAction)fullSizeSuvButtonTapped:(id)sender;
@property (assign) BOOL isfullSizeSuvButtonTapped;
@property (strong, nonatomic) IBOutlet UIButton *EconomyCarButton;
- (IBAction)EconomyCarButtonTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *minivanButton;
- (IBAction)minivanButtonTapped:(id)sender;
@property (assign) BOOL isminivanButtonTapped;
@property (strong, nonatomic) IBOutlet UIButton *premiumCarsButton;
- (IBAction)premiumCarsButtonTapped:(id)sender;
@property (assign) BOOL ispremiumCarsButtonTapped;
@property (strong, nonatomic) IBOutlet UIButton *MidSizeSuvButton;
- (IBAction)MidSizeSuvButtonTapped:(id)sender;
@property (assign) BOOL isMidSizeSuvButton;
- (IBAction)MidSizeCarButtonTapped:(id)sender;
@property (assign) BOOL isEconomyCarButtonTapped;
@property (assign) BOOL isMidSizeCarButton;
@property (strong, nonatomic) IBOutlet UIButton *MidSizeCarButton;
@property (strong, nonatomic) IBOutlet UIButton *standardSizePickup;
- (IBAction)standardSizePickupTapped:(id)sender;
- (IBAction)generateResults:(id)sender;
@property (assign) BOOL isstandardSizePickupTapped;
@end

@implementation CarFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cancellationButton.backgroundColor = UIColor.whiteColor;
    self.luxuryCarButton.backgroundColor = UIColor.whiteColor;
    self.fullSizeSuvButton.backgroundColor = UIColor.whiteColor;
    self.MidSizeSuvButton.backgroundColor = UIColor.whiteColor;
    self.MidSizeCarButton.backgroundColor = UIColor.whiteColor;
    self.EconomyCarButton.backgroundColor = UIColor.whiteColor;
    self.standardSizePickup.backgroundColor = UIColor.whiteColor;
    self.premiumCarsButton.backgroundColor = UIColor.whiteColor;
    self.minivanButton.backgroundColor = UIColor.whiteColor; 
}

-(void)searchCarResultsDictionary: (NSDictionary *)carSearchInformation returnArray: (NSMutableArray *)carResults{
    NSMutableDictionary *vehicleRates = [carSearchInformation objectForKey:@"vehicleRates"];
    int count = 0;
    for(id car in vehicleRates){
        if(count < 5){
            NSMutableDictionary *vehicleInfo = [car objectForKey:@"vehicleInfo"];
            NSString *carType = [vehicleInfo objectForKey:@"description"];
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
            BOOL carTypeFlag = 0;
            
            int minPrice = INT_MIN;
            int maxPrice = INT_MAX;
            
            if(self.minPrice.text != nil){
                minPrice = [self.minPrice.text intValue];
            }
            if(self.maxPrice.text != nil){
                maxPrice = [self.maxPrice.text intValue];
            }
            
            if(self.isLuxuryCarButtonTapped == 1 && [carType isEqualToString:@"Luxury Car"]){
                carTypeFlag = 1;
            }
            
            if(self.isfullSizeSuvButtonTapped == 1 && [carType isEqualToString:@"Full-Size SUV"]){
                carTypeFlag = 1;
            }
            if(self.isMidSizeCarButton == 1 && [carType isEqualToString:@"Mid-Size Car"]){
                carTypeFlag = 1;
            }
            
            if(self.ispremiumCarsButtonTapped == 1 && [carType isEqualToString:@"Premium Suv"]){
                carTypeFlag = 1;
            }
            if(self.isEconomyCarButtonTapped == 1 && [carType isEqualToString:@"Economy Car"]){
                carTypeFlag = 1;
            }
            if(self.isMidSizeSuvButton == 1 && [carType isEqualToString:@"Mid-Size SUV"]){
                carTypeFlag = 1;
            }
            
            if(self.isstandardSizePickupTapped == 1 && [carType isEqualToString:@"Standard-Size Pickup"]){
                carTypeFlag = 1;
            }
            
            if(self.isminivanButtonTapped == 1 && [carType isEqualToString:@"Minivan"]){
                carTypeFlag = 1;
            }
            
            if(self.numberOfPassengers.text == nil){
                self.numberOfPassengers.text = @"1";
            }
            if(carTypeFlag == 1){
                if(minPrice <= [price intValue] && [price intValue] <= maxPrice){
                    if((self.isCancelButtonTapped == 1 &&[cancelation intValue] == 1) || self.isCancelButtonTapped == 0){
                        if([automatic intValue] == 1){
                            if([numPeople intValue] >= [self.numberOfPassengers.text intValue]) {
                                NSMutableDictionary *newAdd = [[NSMutableDictionary alloc]init];
                                if(idName){
                                    [newAdd setObject:idName forKey:@"id"];
                                } else {
                                    [newAdd setObject:@"NA" forKey:@"id"];
                                }
                                if(description){
                                    [newAdd setObject:description forKey:@"description"];
                                } else {
                                    [newAdd setObject:@"NA" forKey:@"description"];
                                }
                                if(cancelation){
                                    [newAdd setObject:cancelation forKey:@"cancellation_policy"];
                                } else{
                                    [newAdd setObject:@"NA" forKey:@"cancellation_policy"];
                                }
                                if(cancelationFee){
                                    [newAdd setObject:cancelationFee forKey:@"cancellation_fee"];
                                } else {
                                    [newAdd setObject:@"NA" forKey:@"cancellation_fee"];
                                }
                                if(automatic){
                                    [newAdd setObject:automatic forKey:@"automatic"];
                                } else {
                                    [newAdd setObject:@"NA" forKey:@"automatic"];
                                }
                                if(price){
                                    [newAdd setObject:price forKey:@"price"];
                                } else {
                                    [newAdd setObject:@"NA" forKey:@"price"];
                                }
                                if(numPeople){
                                    [newAdd setObject:numPeople forKey:@"number_of_passengers"];
                                } else {
                                    [newAdd setObject:@"NA" forKey:@"number_of_passengers"];
                                }
                                [carResults addObject:newAdd];
                                count++;
                            }
                        }
                    }
                }
            }
        }
    }
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
                                                            [self performSegueWithIdentifier:@"carFilterToDisplay" sender:sender];
                                                        });
                                                    }
                                                }];
    [dataTask resume];
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
    displayView.tripType = self.tripType;
    displayView.tripName = self.tripName; 
}

- (IBAction)cancelButtonTapped:(id)sender {
    self.cancellationButton.backgroundColor = self.isCancelButtonTapped ? UIColor.whiteColor : UIColor.redColor;
    self.isCancelButtonTapped = !self.isCancelButtonTapped;
}
- (IBAction)luxuryCarButtonTapped:(id)sender {
    self.luxuryCarButton.backgroundColor = self.isLuxuryCarButtonTapped ? UIColor.whiteColor : UIColor.redColor;
    self.isLuxuryCarButtonTapped = !self.isLuxuryCarButtonTapped;
}
- (IBAction)fullSizeSuvButtonTapped:(id)sender {
    self.fullSizeSuvButton.backgroundColor = self.isfullSizeSuvButtonTapped ? UIColor.whiteColor : UIColor.redColor;
    self.isfullSizeSuvButtonTapped = !self.isfullSizeSuvButtonTapped;
}
- (IBAction)EconomyCarButtonTapped:(id)sender {
    self.EconomyCarButton.backgroundColor = self.isEconomyCarButtonTapped ? UIColor.whiteColor : UIColor.redColor;
    self.isEconomyCarButtonTapped = !self.isEconomyCarButtonTapped;
}
- (IBAction)minivanButtonTapped:(id)sender {
    self.minivanButton.backgroundColor = self.isminivanButtonTapped ? UIColor.whiteColor : UIColor.redColor;
    self.isminivanButtonTapped = !self.isminivanButtonTapped;
}
- (IBAction)premiumCarsButtonTapped:(id)sender {
    self.premiumCarsButton.backgroundColor = self.ispremiumCarsButtonTapped ? UIColor.whiteColor : UIColor.redColor;
    self.ispremiumCarsButtonTapped = !self.ispremiumCarsButtonTapped;
}
- (IBAction)MidSizeSuvButtonTapped:(id)sender {
    self.MidSizeSuvButton.backgroundColor = self.isMidSizeSuvButton ? UIColor.whiteColor : UIColor.redColor;
    self.isMidSizeSuvButton = !self.isMidSizeSuvButton;
}
- (IBAction)MidSizeCarButtonTapped:(id)sender {
    self.MidSizeCarButton.backgroundColor = self.isMidSizeCarButton ? UIColor.whiteColor : UIColor.redColor;
    self.isMidSizeCarButton = !self.isMidSizeCarButton;
}
- (IBAction)generateResults:(id)sender {
    [self callCarsAPI:sender];
}

- (IBAction)standardSizePickupTapped:(id)sender {
    self.standardSizePickup.backgroundColor = self.isstandardSizePickupTapped ? UIColor.whiteColor : UIColor.redColor;
    self.isstandardSizePickupTapped = !self.isstandardSizePickupTapped;
}
@end
