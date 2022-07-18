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

@end

@implementation HotelRequirementsViewController 


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hotelsInfo.destination = (NSString *) _destination;
    self.hotelsInfo.arrivalDate = (NSDate *) _arrivalDate.date;
    self.hotelsInfo.departureDate = (NSDate *) _departureDate.date;
    self.hotelsInfo.numberOfGuests = (int) _numberOfGuests;
    
}


@end
