//
//  CarRequirmentsViewController.h
//  Pods
//
//  Created by Farida Abdelmoneum on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "Cars_Information.h"
#import "Flights_Information.h"
#import "Hotels_Information.h"
NS_ASSUME_NONNULL_BEGIN

@interface CarRequirmentsViewController : UIViewController
@property (strong, nonatomic) Cars_Information *carInfoSaved;
@property (strong, nonatomic) Flights_Information *flightInfoSaved;
@property (strong, nonatomic) Hotels_Information *hotelInfoSaved;
@end

NS_ASSUME_NONNULL_END
