//
//  SelectServicesViewController.m
//  
//
//  Created by Farida Abdelmoneum on 7/6/22.
//

#import "SelectServicesViewController.h"

@interface SelectServicesViewController ()
-(void)changeColorOfButton:(UIButton *) Button checkState:(BOOL)state;
@property (nonatomic) BOOL isHotelSelected;
@property (nonatomic) BOOL isFlightSelected;
@property (nonatomic) BOOL isCarSelected;
@property (strong, nonatomic) IBOutlet UIButton *carsButton;
@property (strong, nonatomic) IBOutlet UIButton *flightsButton;
@property (strong, nonatomic) IBOutlet UIButton *hotelsButton;
- (IBAction)carsButtonTapped:(id)sender;
- (IBAction)flightsButtonTapped:(id)sender;
- (IBAction)hotelsButtonTapped:(id)sender;

@end

@implementation SelectServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _hotelsButton.backgroundColor = [UIColor whiteColor];
    _flightsButton.backgroundColor = [UIColor whiteColor];
    _carsButton.backgroundColor = [UIColor whiteColor];
}

-(void)changeColorOfButton:(UIButton *) Button checkState :(BOOL)state{
    Button.backgroundColor = Button ? [UIColor redColor] : [UIColor whiteColor];
    state = !state;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)hotelsButtonTapped:(id)sender {
    //[changeColorOfButton Button:_hotelsButton checkState: _isHotelSelected];
    if(!_isHotelSelected){
        _hotelsButton.backgroundColor = [UIColor redColor];
        _isHotelSelected = YES;
    } else if(_isHotelSelected){
        _hotelsButton.backgroundColor = [UIColor whiteColor];
        _isHotelSelected = NO;
    }
}

- (IBAction)flightsButtonTapped:(id)sender {
    if(!_isFlightSelected){
        _flightsButton.backgroundColor = [UIColor redColor];
        _isFlightSelected = YES;
    } else if(_isFlightSelected){
        _flightsButton.backgroundColor = [UIColor whiteColor];
        _isFlightSelected = NO;
    }
}

- (IBAction)carsButtonTapped:(id)sender {
    if(!_isCarSelected){
        _carsButton.backgroundColor = [UIColor redColor];
        _isCarSelected = YES;
    } else if(_isCarSelected){
        _carsButton.backgroundColor = [UIColor whiteColor];
        _isCarSelected = NO;
    }
}
@end
