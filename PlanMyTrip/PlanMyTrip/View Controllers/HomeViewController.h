//
//  HomeViewController.h
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/6/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController
@property (nonatomic, strong) NSMutableDictionary *savedItineraries;
@property (nonatomic, strong) NSString *itinCount;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic, strong) PFUser *userLocal;
@end

NS_ASSUME_NONNULL_END
