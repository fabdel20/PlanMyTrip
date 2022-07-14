//
//  CarRequirmentsViewController.m
//  Pods
//
//  Created by Farida Abdelmoneum on 7/8/22.
//

#import "CarRequirmentsViewController.h"
#import "Cars_Information.h"

@interface CarRequirmentsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *location;
@property (strong, nonatomic) IBOutlet UIDatePicker *pickUpDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *dropOffDate;
@property Cars_Information *carInfo;

@end

@implementation CarRequirmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _carInfo.location = (NSString *) _location;
    _carInfo.pickUpDate = (NSDate *) _pickUpDate.date;
    _carInfo.dropOffDate = (NSDate *) _dropOffDate.date;
}


@end