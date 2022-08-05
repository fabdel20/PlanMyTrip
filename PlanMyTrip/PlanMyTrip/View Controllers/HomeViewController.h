//
//  HomeViewController.h
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/6/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController <UITableViewDataSource>
@property (nonatomic, strong) NSMutableDictionary *savedItineraries;
@property (nonatomic, strong) NSString *itinCount;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic, strong) PFUser *userLocal;
@property (nonatomic, strong) NSString *tripName;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString *tripType; 
@end

NS_ASSUME_NONNULL_END
