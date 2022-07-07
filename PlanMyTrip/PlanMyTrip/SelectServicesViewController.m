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
    _hotelsButton.backgroundColor = _isHotelSelected ? UIColor.whiteColor : UIColor.redColor;
    _isHotelSelected = !_isHotelSelected;
}

- (IBAction)flightsButtonTapped:(id)sender {
    _flightsButton.backgroundColor = _isFlightSelected ? UIColor.whiteColor : UIColor.redColor;
    _isFlightSelected = !_isFlightSelected;
}

- (IBAction)carsButtonTapped:(id)sender {
    _carsButton.backgroundColor = _isCarSelected ? UIColor.whiteColor : UIColor.redColor;
    _isCarSelected = !_isCarSelected;
}
@end
