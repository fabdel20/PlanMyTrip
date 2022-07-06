//
//  SelectServicesViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/6/22.
//

#import "SelectServicesViewController.h"

@interface SelectServicesViewController ()
@property (nonatomic) BOOL checkedH;
@property (nonatomic) BOOL checkedF;
@property (nonatomic) BOOL checkedC;
@property (weak, nonatomic) IBOutlet UIButton *carsB;
@property (weak, nonatomic) IBOutlet UIButton *flightsB;
@property (strong, nonatomic) IBOutlet UIButton *hotelsB;
- (IBAction)carsCheck:(id)sender;
- (IBAction)flightsCheck:(id)sender;
- (IBAction)hotelsCheck:(id)sender;

@end

@implementation SelectServicesViewController

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

- (IBAction)hotelsCheck:(id)sender {
    if(!_checkedH){
            _hotelsB.backgroundColor = [UIColor redColor];
            _checkedH = YES;
        } else if(_checkedH){
            _hotelsB.backgroundColor = [UIColor whiteColor];
            _checkedH = NO;
        }
}

- (IBAction)flightsCheck:(id)sender {
    if(!_checkedF){
        _flightsB.backgroundColor = [UIColor redColor];
            _checkedF = YES;
        }
        else if(_checkedF){
            _flightsB.backgroundColor = [UIColor whiteColor];
            _checkedF = NO;
        }
}

- (IBAction)carsCheck:(id)sender {
    if(!_checkedC){
        _carsB.backgroundColor = [UIColor redColor];
            _checkedC = YES;
        }
        else if(_checkedC){
            _carsB.backgroundColor = [UIColor whiteColor];
            _checkedC = NO;
        }
}
@end
