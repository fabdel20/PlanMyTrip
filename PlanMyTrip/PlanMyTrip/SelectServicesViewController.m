//
//  SelectServicesViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/6/22.
//

#import "SelectServicesViewController.h"

@interface SelectServicesViewController ()
@property (nonatomic) BOOL isHotelSelected;
@property (nonatomic) BOOL isFlightSelected;
@property (nonatomic) BOOL isCarSelected;
@property (weak, nonatomic) IBOutlet UIButton *carsB;
@property (weak, nonatomic) IBOutlet UIButton *flightsB;
@property (weak, nonatomic) IBOutlet UIButton *hotelsB;
- (IBAction)carsCheck:(id)sender;
- (IBAction)flightsCheck:(id)sender;
- (IBAction)hotelsCheck:(id)sender;

@end

@implementation SelectServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _hotelsB.backgroundColor = [UIColor whiteColor];
    _flightsB.backgroundColor = [UIColor whiteColor];
    _carsB.backgroundColor = [UIColor whiteColor];
}



- (IBAction)hotelsCheck:(id)sender {
    if(!_isHotelSelected){
            _hotelsB.backgroundColor = [UIColor redColor];
            _isHotelSelected = YES;
        } else if(_isHotelSelected) {
            _hotelsB.backgroundColor = [UIColor whiteColor];
            _isHotelSelected = NO;
        }
}

- (IBAction)flightsCheck:(id)sender {
    if(!_isFlightSelected){
        _flightsB.backgroundColor = [UIColor redColor];
        _isFlightSelected = YES;
        } else if(_isFlightSelected) {
            _flightsB.backgroundColor = [UIColor whiteColor];
            _isFlightSelected = NO;
        }
}

- (IBAction)carsCheck:(id)sender {
    if(!_isCarSelected){
        _carsB.backgroundColor = [UIColor redColor];
        _isCarSelected = YES;
        } else if(_isCarSelected) {
            _carsB.backgroundColor = [UIColor whiteColor];
            _isCarSelected= NO;
        }
}
@end
