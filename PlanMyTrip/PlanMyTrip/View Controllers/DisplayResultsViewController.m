//
//  DisplayResultsViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/22/22.
//

#import "DisplayResultsViewController.h"
#import "ResultsViewController.h"
#import "HomeViewController.h"
#import "FlightFilterViewController.h"
#import "HotelFilterViewController.h"
#import "CarFilterViewController.h"
#import "Parse.h"
@interface DisplayResultsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *FirstTitle;
@property (strong, nonatomic) IBOutlet UILabel *SecondTitle;
@property (strong, nonatomic) IBOutlet UILabel *ThirdTitle;
@property (strong, nonatomic) IBOutlet UILabel *secondOutput;
@property (strong, nonatomic) IBOutlet UILabel *thirdOutput;
@property (strong, nonatomic) IBOutlet UILabel *fourthOutput;
@property (strong, nonatomic) IBOutlet UIButton *secondFilterTapped;
@property (strong, nonatomic) IBOutlet UILabel *fifthOutput;
@property (strong, nonatomic) IBOutlet UILabel *sixthOutput;
@property (strong, nonatomic) IBOutlet UILabel *seventhOutput;
@property (strong, nonatomic) IBOutlet UILabel *eighthOutput;
- (IBAction)firstFilterTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *ninthOutput;
@property (strong, nonatomic) IBOutlet UIButton *firstButton;
@property (strong, nonatomic) IBOutlet UIButton *secondButton;
@property (strong, nonatomic) IBOutlet UIButton *thirdButton;
@property (strong, nonatomic) IBOutlet UIButton *fourthButton;
@property (strong, nonatomic) IBOutlet UIButton *fifthButton;
- (IBAction)secondFilterTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sixthButton;
@property (strong, nonatomic) IBOutlet UIButton *seventhButton;
@property (strong, nonatomic) IBOutlet UIButton *eighthButton;
@property (strong, nonatomic) IBOutlet UIButton *ninthButton;
@property (strong, nonatomic) IBOutlet UIButton *secondFilter;
@property (strong, nonatomic) IBOutlet UIButton *firstFilter;
@property (strong, nonatomic) IBOutlet UIButton *thirdFilter;
- (IBAction)firstButtonTapped:(id)sender;
- (IBAction)secondButtonTapped:(id)sender;
- (IBAction)thirdButtonTapped:(id)sender;
- (IBAction)fourthButtonTapped:(id)sender;
- (IBAction)fifthButtonTapped:(id)sender;
- (IBAction)sixthButtonTapped:(id)sender;
- (IBAction)seventhButtonTapped:(id)sender;
- (IBAction)eigthButtonTapped:(id)sender;
- (IBAction)ninthButtonTapped:(id)sender;
@property (nonatomic) BOOL firstButtonState;
@property (nonatomic) BOOL secondButtonState;
@property (nonatomic) BOOL thirdButtonState;
@property (nonatomic) BOOL fourthButtonState;
@property (nonatomic) BOOL fifthButtonState;
@property (nonatomic) BOOL sixthButtonState;
@property (nonatomic) BOOL seventhButtonState;
@property (nonatomic) BOOL eigthButtonState;
@property (nonatomic) BOOL ninthButtonState;
- (IBAction)saveItinerary:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *firstOutput;
@property (strong, nonatomic) NSMutableDictionary *selectedServices;
@property (nonatomic) BOOL firstThird;
@property (nonatomic) BOOL secondThird;
@property (nonatomic) BOOL lastThird;
@end

@implementation DisplayResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.flightStatus){
        self.FirstTitle.text = @"Flight Recomendations";
    }
    if(!self.flightStatus && self.hotelStatus){
        self.FirstTitle.text = @"Hotel Recomendations";
    }
    if(!self.flightStatus && !self.hotelStatus && self.carStatus){
        self.FirstTitle.text = @"Car Recomendations";
    }
    self.firstThird = YES;
    self.firstButton.backgroundColor = [UIColor whiteColor];
    self.secondButton.backgroundColor = [UIColor whiteColor];
    self.thirdButton.backgroundColor = [UIColor whiteColor];
    self.firstFilter.backgroundColor = [UIColor whiteColor];
    [self.firstFilter setTitle:@"Filter Results" forState:UIControlStateNormal];
    
    if((self.flightStatus && self.hotelStatus) || (self.flightStatus && self.carStatus) || (self.hotelStatus && self.carStatus)){
        if(self.flightStatus && self.hotelStatus){
            self.SecondTitle.text = @"Hotel Recomendations";
        }
        if((self.flightStatus && !self.hotelStatus && self.carStatus) || (!self.flightStatus && self.hotelStatus && self.carStatus)){
            self.SecondTitle.text = @"Car Recomendations";
        }
        self.secondThird = YES;
        self.fourthButton.backgroundColor = [UIColor whiteColor];
        self.fifthButton.backgroundColor = [UIColor whiteColor];
        self.sixthButton.backgroundColor = [UIColor whiteColor];
        self.secondFilter.backgroundColor = [UIColor whiteColor];
        [self.secondFilter setTitle:@"Filter Results" forState:UIControlStateNormal];
    }
    
    if(self.flightStatus && self.carStatus && self.hotelStatus ){
        self.ThirdTitle.text = @"Car Recomendations";
        self.lastThird = YES;
        self.seventhButton.backgroundColor = [UIColor whiteColor];
        self.eighthButton.backgroundColor = [UIColor whiteColor];
        self.ninthButton.backgroundColor = [UIColor whiteColor];
        self.thirdFilter.backgroundColor = [UIColor whiteColor];
        [self.thirdFilter setTitle:@"Filter Results" forState:UIControlStateNormal];
    }
    
    if(self.hotelStatus){
        int count = 1;
        NSMutableDictionary *newItem =[[NSMutableDictionary alloc] init];
        for(id item in self.hotelResults){
            if(count < 4){
                NSString *name = [item objectForKey:@"name"];
                NSString *price = [item objectForKey:@"price"];
                NSString *rating = [item objectForKey:@"rating"];
                NSString *sentence = [NSString stringWithFormat:@"The first hotel recomendation is the %@. It costs %@ per night and is rated %@ stars.", name, price, rating];
                NSMutableDictionary *sub = [[NSMutableDictionary alloc] init];
                [sub setObject:name forKey:@"name"];
                [sub setObject:price forKey:@"price"];
                [sub setObject:rating forKey:@"rating"];
                if(count == 1){
                    if(!self.flightStatus){
                        self.firstOutput.text = sentence;
                    } else {
                        self.fourthOutput.text = sentence;
                    }
                    [newItem setObject:sub forKey:@"firstHotel"];
                }
                if(count == 2){
                    if(!self.flightStatus){
                        self.secondOutput.text = sentence;
                    } else {
                        self.fifthOutput.text = sentence;
                    }
                    [newItem setObject:sub forKey:@"secondHotel"];
                }
                if(count == 3){
                    if(!self.flightStatus){
                        self.thirdOutput.text = sentence;
                    } else {
                        self.sixthOutput.text = sentence;
                    }
                    [newItem setObject:sub forKey:@"thirdHotel"];
                    NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
                    [temp setObject:newItem forKey:@"hotels"];
                    if(_selectedServices != nil){
                        [_selectedServices setObject:newItem forKey:@"hotels"];
                    } else {
                        NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
                        [temp setObject:newItem forKey:@"hotels"];
                        _selectedServices = temp;
                    }
                }
                count++;
            }
        }
    }
    if(self.flightStatus){
        int count2 = 1;
        NSMutableDictionary *newItem =[[NSMutableDictionary alloc] init];
        for(id flight in self.flightResults){
            if(count2 < 4){
                NSString *ticketingAirline = [flight objectForKey:@"Ticketing_Airline"];
                NSString *name = ticketingAirline;
                if([ticketingAirline isEqualToString:@"AA"]){
                    name = @"American Airlines";
                }
                if([ticketingAirline isEqualToString:@"AS"]){
                    name = @"Alaskan Airlines";
                }
                if([ticketingAirline isEqualToString:@"DL"]){
                    name = @"Delta";
                }
                if([ticketingAirline isEqualToString:@"UA"]){
                    name = @"United Airlines";
                }
                NSString *sentence = [NSString stringWithFormat:@"The first flight recomendation is %@. It costs %@ and lasts %@ minutes.", name, [flight objectForKey:@"Price"], [flight objectForKey:@"Duration"]];
                NSMutableDictionary *sub = [[NSMutableDictionary alloc] init];
                [sub setObject:name forKey:@"name"];
                [sub setObject:[flight objectForKey:@"Price"] forKey:@"price"];
                [sub setObject:[flight objectForKey:@"Duration"] forKey:@"duration"];
                if(count2 == 1){
                    self.firstOutput.text = sentence;
                    [newItem setObject:sub forKey:@"firstFlight"];
                }
                if(count2 == 2){
                    self.secondOutput.text = sentence;
                    [newItem setObject:sub forKey:@"secondFlight"];
                }
                if(count2 == 3){
                    self.thirdOutput.text = sentence;
                    [newItem setObject:sub forKey:@"thirdFlight"];
                    NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
                    [temp setObject:newItem forKey:@"flights"];
                    if(_selectedServices != nil){
                        [_selectedServices setObject:newItem forKey:@"flights"];
                    } else {
                        NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
                        [temp setObject:newItem forKey:@"flights"];
                        _selectedServices = temp;
                    }
                }
                count2++;
            }
        }
    }
    if(self.carStatus){
        int count3 = 1;
        NSMutableDictionary *newItem =[[NSMutableDictionary alloc] init];
        for(id car in self.carResults){
            NSString *name = [car objectForKey:@"id"];
            NSString *description = [car objectForKey:@"description"];
            NSString *price = [car objectForKey:@"price"];
            NSString *capacity = [car objectForKey:@"number_of_passengers"];
            NSString *textOuput = [NSString stringWithFormat:@"The first car is a %@. %@. It costs %@ and can take up to %@ people.", name, description, price, capacity];
            if(count3 == 1){
                [newItem setObject:car forKey:@"firstCar"];
                if(!self.flightStatus && !self.hotelStatus){
                    self.firstOutput.text = textOuput;
                }
                if((self.flightStatus && !self.hotelStatus) || (!self.flightStatus && self.hotelStatus)){
                    self.fourthOutput.text = textOuput;
                }
                if(self.flightStatus && self.hotelStatus){
                    self.seventhOutput.text = textOuput;
                }
            }
            if(count3 == 2){
                [newItem setObject:car forKey:@"secondCar"];
                if(!self.flightStatus && !self.hotelStatus){
                    self.secondOutput.text = textOuput;
                }
                if((self.flightStatus && !self.hotelStatus) || (!self.flightStatus && self.hotelStatus)){
                    self.fifthOutput.text = textOuput;
                }
                if(self.flightStatus && self.hotelStatus){
                    self.eighthOutput.text = textOuput;
                }
            }
            if(count3 == 3){
                [newItem setObject:car forKey:@"thirdCar"];
                if(!self.flightStatus && !self.hotelStatus){
                    self.thirdOutput.text = textOuput;
                }
                if((self.flightStatus && !self.hotelStatus) || (!self.flightStatus && self.hotelStatus)){
                    self.fourthOutput.text = textOuput;
                }
                if(self.flightStatus && self.hotelStatus){
                    self.fifthOutput.text = textOuput;
                }
                NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
                [temp setObject:newItem forKey:@"cars"];
                if(_selectedServices != nil){
                    [_selectedServices setObject:newItem forKey:@"cars"];
                } else {
                    NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
                    [temp setObject:newItem forKey:@"cars"];
                    _selectedServices = temp;
                }
            }
            count3++;
        }
    }
}

- (IBAction)saveItinerary:(id)sender {
    [self performSegueWithIdentifier:@"saveToHomePage" sender:sender];
}

- (IBAction)ninthButtonTapped:(id)sender {
    if(self.lastThird){
        self.ninthButton.backgroundColor = self.ninthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.ninthButtonState = !self.ninthButtonState;
        if(self.eigthButtonState || self.seventhButtonState){
            self.eighthButton.backgroundColor = [UIColor whiteColor];
            self.eigthButtonState = 0;
            self.seventhButton.backgroundColor = [UIColor whiteColor];
            self.seventhButtonState = 0;
        }
    }
}

- (IBAction)eigthButtonTapped:(id)sender {
    if(self.lastThird){
        self.eighthButton.backgroundColor = self.eigthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.eigthButtonState = !self.eigthButtonState;
        if(self.ninthButtonState || self.seventhButtonState){
            self.ninthButton.backgroundColor = [UIColor whiteColor];
            self.ninthButtonState = 0;
            self.seventhButton.backgroundColor = [UIColor whiteColor];
            self.seventhButtonState = 0;
        }
    }
}

- (IBAction)seventhButtonTapped:(id)sender {
    if(self.lastThird){
        self.seventhButton.backgroundColor = self.seventhButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.seventhButtonState = !self.seventhButtonState;
        if(self.eigthButtonState || self.ninthButtonState){
            self.eighthButton.backgroundColor = [UIColor whiteColor];
            self.eigthButtonState = 0;
            self.ninthButton.backgroundColor = [UIColor whiteColor];
            self.ninthButtonState = 0;
        }
    }
}

- (IBAction)sixthButtonTapped:(id)sender {
    if(self.secondThird){
        self.sixthButton.backgroundColor = self.sixthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.sixthButtonState = !self.sixthButtonState;
        if(self.fifthButtonState || self.fourthButtonState){
            self.fifthButton.backgroundColor = [UIColor whiteColor];
            self.fifthButtonState = 0;
            self.fourthButton.backgroundColor = [UIColor whiteColor];
            self.fourthButtonState = 0;
        }
    }
}

- (IBAction)fifthButtonTapped:(id)sender {
    if(self.secondThird){
        self.fifthButton.backgroundColor = self.fifthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.fifthButtonState = !self.fifthButtonState;
        if(self.sixthButtonState || self.fourthButtonState){
            self.sixthButton.backgroundColor = [UIColor whiteColor];
            self.sixthButtonState = 0;
            self.fourthButton.backgroundColor = [UIColor whiteColor];
            self.fourthButtonState = 0;
        }
    }
}

- (IBAction)fourthButtonTapped:(id)sender {
    if(self.secondThird){
        self.fourthButton.backgroundColor = self.fourthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.fourthButtonState = !self.fourthButtonState;
        if(self.sixthButtonState || self.fifthButtonState){
            self.sixthButton.backgroundColor = [UIColor whiteColor];
            self.sixthButtonState = 0;
            self.fifthButton.backgroundColor = [UIColor whiteColor];
            self.fifthButtonState = 0;
        }
    }
}

- (IBAction)thirdButtonTapped:(id)sender {
    if(self.firstThird){
        self.thirdButton.backgroundColor = self.thirdButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.thirdButtonState = !self.thirdButtonState;
        if(self.firstButtonState || self.secondButtonState){
            self.firstButton.backgroundColor = [UIColor whiteColor];
            self.firstButtonState = 0;
            self.secondButton.backgroundColor = [UIColor whiteColor];
            self.secondButtonState = 0;
        }
    }
}

- (IBAction)secondButtonTapped:(id)sender {
    if(self.firstThird){
        self.secondButton.backgroundColor = self.secondButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.secondButtonState = !self.secondButtonState;
        if(self.firstButtonState || self.thirdButtonState){
            self.firstButton.backgroundColor = [UIColor whiteColor];
            self.firstButtonState = 0;
            self.thirdButton.backgroundColor = [UIColor whiteColor];
            self.thirdButtonState = 0;
        }
    }
}

- (IBAction)firstButtonTapped:(id)sender {
    if(self.firstThird){
        self.firstButton.backgroundColor = self.firstButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.firstButtonState = !self.firstButtonState;
        if(self.secondButtonState || self.thirdButtonState){
            self.secondButton.backgroundColor = [UIColor whiteColor];
            self.secondButtonState = 0;
            self.thirdButton.backgroundColor = [UIColor whiteColor];
            self.thirdButtonState = 0;
        }
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"saveToHomePage"]){
        HomeViewController *newView = [segue destinationViewController];
        newView.userLocal = self.userLocal;
        int num = ([self.itinCount intValue] + 1);
        self.itinCount = [NSString stringWithFormat:@"%d", num];
        NSMutableDictionary *newAdd = [[NSMutableDictionary alloc] init];
        newView.itinCount = self.itinCount;
        if(self.flightStatus){
            if(self.firstButtonState){
                NSMutableDictionary *val = [self.selectedServices objectForKey:@"flights"];
                NSMutableDictionary *selectedFlight = [val objectForKey:@"firstFlight"];
                [newAdd setObject:selectedFlight forKey:@"flights"];
            }
            if(self.secondButtonState){
                NSMutableDictionary *val = [self.selectedServices objectForKey:@"flights"];
                NSMutableDictionary *selectedFlight = [val objectForKey:@"secondFlight"];
                [newAdd setObject:selectedFlight forKey:@"flights"];
            }
            if(self.thirdButtonState){
                NSMutableDictionary *val = [self.selectedServices objectForKey:@"flights"];
                NSMutableDictionary *selectedFlight = [val objectForKey:@"thirdFlight"];
                [newAdd setObject:selectedFlight forKey:@"flights"];
            }
        }
        
        if(self.hotelStatus){
            if(self.flightStatus){
                if(self.fourthButtonState){
                    NSMutableDictionary *val = [_selectedServices objectForKey:@"hotels"];
                    NSMutableDictionary *selectedHotel = [val objectForKey:@"firstHotel"];
                    [newAdd setObject:selectedHotel forKey:@"hotels"];
                }
                if(self.fifthButtonState){
                    NSMutableDictionary *val = [_selectedServices objectForKey:@"hotels"];
                    NSMutableDictionary *selectedHotel = [val objectForKey:@"secondHotel"];
                    [newAdd setObject:selectedHotel forKey:@"hotels"];
                }
                if(self.sixthButtonState){
                    NSMutableDictionary *val = [_selectedServices objectForKey:@"hotels"];
                    NSMutableDictionary *selectedHotel = [val objectForKey:@"thirdHotel"];
                    [newAdd setObject:selectedHotel forKey:@"hotels"];
                }
            } else {
                if(self.firstButtonState){
                    NSMutableDictionary *val = [_selectedServices objectForKey:@"hotels"];
                    NSMutableDictionary *selectedHotel = [val objectForKey:@"firstHotel"];
                    [newAdd setObject:selectedHotel forKey:@"hotels"];
                }
                if(_secondButtonState){
                    NSMutableDictionary *val = [_selectedServices objectForKey:@"hotels"];
                    NSMutableDictionary *selectedHotel = [val objectForKey:@"secondHotel"];
                    [newAdd setObject:selectedHotel forKey:@"hotels"];
                }
                if(self.thirdButtonState){
                    NSMutableDictionary *val = [_selectedServices objectForKey:@"hotels"];
                    NSMutableDictionary *selectedHotel = [val objectForKey:@"thirdHotel"];
                    [newAdd setObject:selectedHotel forKey:@"hotels"];
                }
            }
        }
        
        if(self.carStatus){
            if(self.flightStatus){
                if(!self.hotelStatus){
                    if(self.fourthButtonState){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"firstCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                    if(self.fifthButtonState){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"secondCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                    if(self.sixthButtonState){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"thirdCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                }
                if(self.hotelStatus){
                    if(self.seventhButtonState){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"firstCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                    if(self.eigthButtonState){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"secondCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                    if(self.ninthButtonState){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"thirdCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                }
            } else {
                if(!self.hotelStatus){
                    if(self.firstButtonState){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCars = [val objectForKey:@"firstCar"];
                        [newAdd setObject:selectedCars forKey:@"cars"];
                    }
                    if(self.secondButtonState){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"secondCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                    if(self.thirdButtonState){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"thirdCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                } else {
                    if(self.fourthButtonState){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCars = [val objectForKey:@"firstCar"];
                        [newAdd setObject:selectedCars forKey:@"cars"];
                    }
                    if(self.fifthButtonState){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"secondCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                    if(self.sixthButtonState){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"thirdCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                }
            }
        }
        if(self.savedItineraries == nil){
            NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
            [newAdd setObject:self.tripType forKey:@"type"];
            [temp setObject:newAdd forKey:self.tripName];
            self.savedItineraries = temp;
        } else {
            [newAdd setObject:self.tripType forKey:@"type"];
            [self.savedItineraries setObject:newAdd forKey:self.tripName];
        }
        newView.savedItineraries = self.savedItineraries;
        newView.userLocal.savedItineraries = self.savedItineraries;
        [newView.userLocal saveInBackground];
    }
    if([[segue identifier] isEqualToString:@"displayResultsToFlightFilter"]){
        FlightFilterViewController *flightFilterView = [segue destinationViewController];
        flightFilterView.flightResults = [[NSMutableArray alloc]init];
        flightFilterView.carResults = self.carResults;
        flightFilterView.hotelResults = self.hotelResults;
        flightFilterView.ittinObjects = self.ittinObjects;
        flightFilterView.flightStatus = self.flightStatus;
        flightFilterView.hotelStatus = self.hotelStatus;
        flightFilterView.carStatus = self.carStatus;
        flightFilterView.savedItineraries = self.savedItineraries;
        flightFilterView.itinCount = self.itinCount;
        flightFilterView.userLocal = self.userLocal;
        flightFilterView.flightUserInfo = self.flightUserInfo;
        flightFilterView.hotelUserInfo = self.hotelUserInfo;
        flightFilterView.carUserInfo = self.carUserInfo;
        flightFilterView.tripType = self.tripType;
        flightFilterView.tripName = self.tripName;
    }
    
    if([[segue identifier] isEqualToString:@"displayResultsToHotelFilter"]){
        HotelFilterViewController *hotelFilterView = [segue destinationViewController];
        hotelFilterView.flightResults = self.flightResults;
        hotelFilterView.carResults = self.carResults;
        hotelFilterView.hotelResults = [[NSMutableArray alloc]init];
        hotelFilterView.ittinObjects = self.ittinObjects;
        hotelFilterView.flightStatus = self.flightStatus;
        hotelFilterView.hotelStatus = self.hotelStatus;
        hotelFilterView.carStatus = self.carStatus;
        hotelFilterView.savedItineraries = self.savedItineraries;
        hotelFilterView.itinCount = self.itinCount;
        hotelFilterView.userLocal = self.userLocal;
        hotelFilterView.flightUserInfo = self.flightUserInfo;
        hotelFilterView.hotelUserInfo = self.hotelUserInfo;
        hotelFilterView.carUserInfo = self.carUserInfo;
        hotelFilterView.tripName = self.tripName;
        hotelFilterView.tripType = self.tripType;
    }
    if([[segue identifier] isEqualToString:@"displayResultsToCarFilter"]){
        CarFilterViewController *carFilterView = [segue destinationViewController];
        carFilterView.flightResults = self.flightResults;
        carFilterView.carResults = [[NSMutableArray alloc]init];
        carFilterView.hotelResults = self.hotelResults;
        carFilterView.ittinObjects = self.ittinObjects;
        carFilterView.flightStatus = self.flightStatus;
        carFilterView.hotelStatus = self.hotelStatus;
        carFilterView.carStatus = self.carStatus;
        carFilterView.savedItineraries = self.savedItineraries;
        carFilterView.itinCount = self.itinCount;
        carFilterView.userLocal = self.userLocal;
        carFilterView.flightUserInfo = self.flightUserInfo;
        carFilterView.hotelUserInfo = self.hotelUserInfo;
        carFilterView.carUserInfo = self.carUserInfo;
        carFilterView.tripType = self.tripType;
        carFilterView.tripName = self.tripName; 
    }
}
- (IBAction)firstFilterTapped:(id)sender {
    if(self.flightStatus){
        [self performSegueWithIdentifier:@"displayResultsToFlightFilter" sender:sender];
    }
    if(!self.flightStatus && self.hotelStatus){
        [self performSegueWithIdentifier:@"displayResultsToHotelFilter" sender:sender];
    }
    
    if(!self.flightStatus && !self.hotelStatus && self.carStatus){
        [self performSegueWithIdentifier:@"displayResultsToCarFilter" sender:sender];
    }
}
- (IBAction)secondFilterTapped:(id)sender {
    if(self.flightStatus && self.hotelStatus){
        [self performSegueWithIdentifier:@"displayResultsToHotelFilter" sender:sender];
    }
    
    if(!self.flightStatus && self.hotelStatus && self.carStatus){
        [self performSegueWithIdentifier:@"displayResultsToCarFilter" sender:sender];
    }
}
- (IBAction)thirdFilterTapped:(id)sender {
    if(self.flightStatus && self.hotelStatus && self.carStatus){
        [self performSegueWithIdentifier:@"displayResultsToCarFilter" sender:sender];
    }
}
@end
