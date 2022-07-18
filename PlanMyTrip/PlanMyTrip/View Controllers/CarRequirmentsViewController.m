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


@end

@implementation CarRequirmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.carInfo.location = (NSString *) _location;
    self.carInfo.pickUpDate = (NSDate *) _pickUpDate.date;
    self.carInfo.dropOffDate = (NSDate *) _dropOffDate.date;
}


@end
