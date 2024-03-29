//
//  FlightRequirmentsViewController.h
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "Flights_Information.h"
#import "Parse/Parse.h"
NS_ASSUME_NONNULL_BEGIN

@interface FlightRequirmentsViewController : UIViewController

@property (nonatomic)Flights_Information *flightsInfoSaved;
@property (nonatomic, strong) NSMutableDictionary *savedItineraries;
@property (nonatomic, strong) NSString *itinCount;
@property (nonatomic, assign) BOOL flightStatus;
@property (nonatomic, assign) BOOL hotelStatus;
@property (nonatomic, assign) BOOL carStatus;
@property (nonatomic, strong) PFUser *userLocal;
@property (nonatomic, strong) NSString *tripName;
@property (nonatomic, strong) NSString *tripType; 
@end

NS_ASSUME_NONNULL_END
