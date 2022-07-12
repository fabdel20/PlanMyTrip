//
//  HotelRequirementsViewController.m
//  Pods
//
//  Created by Farida Abdelmoneum on 7/8/22.
//

#import "HotelRequirementsViewController.h"
#import "Hotels_Information.h"

@interface HotelRequirementsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *destination;
@property (strong, nonatomic) IBOutlet UIDatePicker *arrivalDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *departureDate;
@property (strong, nonatomic) IBOutlet UITextField *numberOfGuests;
@property Hotels_Information *hotelsInfo;
@end

@implementation HotelRequirementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _hotelsInfo.destination = (NSString *) _destination;
    _hotelsInfo.arrivalDate = (NSDate *) _arrivalDate.date;
    _hotelsInfo.departureDate = (NSDate *) _departureDate.date;
    _hotelsInfo.numberOfGuests = (int) _numberOfGuests;
    
}


@end
