//
//  SelectServicesViewController.h
//  
//
//  Created by Farida Abdelmoneum on 7/6/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
NS_ASSUME_NONNULL_BEGIN

@interface SelectServicesViewController : UIViewController
@property (nonatomic, strong) NSMutableDictionary *savedItineraries;
@property (nonatomic, strong) NSString *itinCount;
@property (nonatomic, strong) PFUser *userLocal;
@property (nonatomic, strong) NSString *tripName;
@property (nonatomic, strong) NSString *tripType;
@end

NS_ASSUME_NONNULL_END
