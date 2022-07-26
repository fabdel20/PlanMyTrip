//
//  DisplayResultsViewController.h
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/22/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DisplayResultsViewController : UIViewController
@property (strong, nonatomic) NSArray *flightResults;
@property (strong, nonatomic) NSArray *carResults;
@property (strong, nonatomic) NSArray *hotelResults;
@property (strong, nonatomic) NSArray *ittinObjects;
@property (nonatomic, assign) BOOL flightStatus;
@property (nonatomic, assign) BOOL hotelStatus;
@property (nonatomic, assign) BOOL carStatus;
@property (nonatomic, strong) NSMutableDictionary *savedItineraries;
@property (nonatomic, strong) NSString *itinCount;
@end

NS_ASSUME_NONNULL_END
