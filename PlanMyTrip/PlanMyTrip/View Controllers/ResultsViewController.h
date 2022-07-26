//
//  ResultsViewController.h
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/11/22.
//

#import <UIKit/UIKit.h>
#import "Flights_Information.h"
#import "Hotels_Information.h"
#import "Cars_Information.h"
NS_ASSUME_NONNULL_BEGIN

@interface ResultsViewController : UIViewController
@property (nonatomic, strong) Flights_Information *flightUserInfo;
@property (nonatomic, strong) Hotels_Information *hotelUserInfo;
@property (nonatomic, strong) Cars_Information *carUserInfo;
@property (nonatomic, strong) NSDictionary *hotelSearchInformation;
@property (strong, nonatomic) NSMutableArray *hotelResults;
@property (strong, nonnull) NSDictionary *carSearchInformation;
@property (strong, nonatomic) NSMutableArray *carResults;
@property (strong, nonnull) NSDictionary *flightSearchInformation;
@property (strong, nonatomic) NSMutableArray *flightResults;
@property (strong, nonnull) NSString *locationID;
@property (nonatomic, assign) BOOL flightStatus;
@property (nonatomic, assign) BOOL hotelStatus;
@property (nonatomic, assign) BOOL carStatus;
@property (nonatomic, strong) NSMutableDictionary *savedItineraries;
@property (nonatomic, strong) NSString *itinCount;
@end

NS_ASSUME_NONNULL_END
