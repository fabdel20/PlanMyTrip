//
//  HotelRequirementsViewController.h
//  Pods
//
//  Created by Farida Abdelmoneum on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "Hotels_Information.h"
#import "Flights_Information.h"
NS_ASSUME_NONNULL_BEGIN

@interface HotelRequirementsViewController : UIViewController
@property (strong, nonatomic) Hotels_Information *hotelsInfoSaved;
@property (strong, nonatomic) Flights_Information *flightInfoSaved2;
@property (nonatomic, strong) NSMutableDictionary *savedItineraries;
@property (nonatomic, strong) NSString *itinCount;
@property (nonatomic, assign) BOOL flightStatus;
@property (nonatomic, assign) BOOL hotelStatus;
@property (nonatomic, assign) BOOL carStatus;
@end

NS_ASSUME_NONNULL_END
