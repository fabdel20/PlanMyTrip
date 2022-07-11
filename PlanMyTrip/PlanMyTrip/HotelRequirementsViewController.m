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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
