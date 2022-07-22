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
@end

NS_ASSUME_NONNULL_END
