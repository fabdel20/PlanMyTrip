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
    if(self.flightStatus == 1){
        self.FirstTitle.text = @"Flight Recomendations";
    }
    if(self.flightStatus == 0 && self.hotelStatus == 1){
        self.FirstTitle.text = @"Hotel Recomendations";
    }
    if(self.flightStatus == 0 && self.hotelStatus == 0 && self.carStatus == 1){
        self.FirstTitle.text = @"Car Recomendations";
    }
    self.firstThird = YES;
    self.firstButton.backgroundColor = [UIColor whiteColor];
    self.secondButton.backgroundColor = [UIColor whiteColor];
    self.thirdButton.backgroundColor = [UIColor whiteColor];
    self.firstFilter.backgroundColor = [UIColor whiteColor];
    [self.firstFilter setTitle:@"Filter Results" forState:UIControlStateNormal];
    
    if((self.flightStatus == 1 && self.hotelStatus == 1) || (self.flightStatus == 1 && self.carStatus == 1) || (self.hotelStatus == 1 && self.carStatus == 1)){
        if(self.flightStatus == 1 && self.hotelStatus == 1){
            self.SecondTitle.text = @"Hotel Recomendations";
        }
        if((self.flightStatus == 1 && self.hotelStatus == 0 && self.carStatus == 1) || (self.flightStatus == 0 && self.hotelStatus == 1 && self.carStatus == 1)){
            self.SecondTitle.text = @"Car Recomendations";
        }
        self.secondThird = YES;
        self.fourthButton.backgroundColor = [UIColor whiteColor];
        self.fifthButton.backgroundColor = [UIColor whiteColor];
        self.sixthButton.backgroundColor = [UIColor whiteColor];
        self.secondFilter.backgroundColor = [UIColor whiteColor];
        [self.secondFilter setTitle:@"Filter Results" forState:UIControlStateNormal];
    }
    
    if(self.flightStatus == 1 && self.carStatus == 1 && self.hotelStatus == 1){
        self.ThirdTitle.text = @"Car Recomendations";
        self.lastThird = YES;
        self.seventhButton.backgroundColor = [UIColor whiteColor];
        self.eighthButton.backgroundColor = [UIColor whiteColor];
        self.ninthButton.backgroundColor = [UIColor whiteColor];
        self.thirdFilter.backgroundColor = [UIColor whiteColor];
        [self.thirdFilter setTitle:@"Filter Results" forState:UIControlStateNormal];
    }
    
    if(self.hotelStatus == 1){
        int count = 1;
        NSMutableDictionary *newItem =[[NSMutableDictionary alloc] init];
        for(id item in self.hotelResults){
            if(count < 4){
                NSString *name = [item objectForKey:@"name"];
                NSString *price = [item objectForKey:@"price"];
                NSString *rating = [item objectForKey:@"rating"];
                
                if(count == 1){
                    NSString *sentence1 = [NSString stringWithFormat:@"The first hotel recomendation is the %@. It costs %@ per night and is rated %@ stars.", name, price, rating];
                    if(self.flightStatus == 0){
                        self.firstOutput.text = sentence1;
                    }
                    if(self.flightStatus == 1) {
                        self.fourthOutput.text = sentence1;
                    }
                    NSMutableDictionary *sub = [[NSMutableDictionary alloc] init];
                    [sub setObject:name forKey:@"name"];
                    [sub setObject:price forKey:@"price"];
                    [sub setObject:rating forKey:@"rating"];
                    [newItem setObject:sub forKey:@"firstHotel"];
                }
                if(count == 2){
                    NSString *sentence2 = [NSString stringWithFormat:@"The second hotel recomendation is the %@. It costs %@ per night and is rated %@ stars.", name, price, rating];
                    if(self.flightStatus == 0){
                        self.secondOutput.text = sentence2;
                    }
                    if(self.flightStatus == 1){
                        self.fifthOutput.text = sentence2;
                    }
                    NSMutableDictionary *sub = [[NSMutableDictionary alloc] init];
                    [sub setObject:name forKey:@"name"];
                    [sub setObject:price forKey:@"price"];
                    [sub setObject:rating forKey:@"rating"];
                    [newItem setObject:sub forKey:@"secondHotel"];
                }
                if(count == 3){
                    NSString *sentence3 = [NSString stringWithFormat:@"The third hotel recomendation is the %@. It costs %@ per night and is rated %@ stars.", name, price, rating];
                    if(self.flightStatus == 0){
                        self.thirdOutput.text = sentence3;
                    }
                    if(self.flightStatus == 1){
                        self.sixthOutput.text = sentence3;
                    }
                    NSMutableDictionary *sub = [[NSMutableDictionary alloc] init];
                    [sub setObject:name forKey:@"name"];
                    [sub setObject:price forKey:@"price"];
                    [sub setObject:rating forKey:@"rating"];
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
    
    if(self.flightStatus == 1){
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
                if(count2 == 1){
                    NSString *sentence1 = [NSString stringWithFormat:@"The first flight recomendation is %@. It costs %@ and lasts %@ minutes.", name, [flight objectForKey:@"Price"], [flight objectForKey:@"Duration"]];
                    self.firstOutput.text = sentence1;
                    NSMutableDictionary *sub = [[NSMutableDictionary alloc] init];
                    [sub setObject:name forKey:@"name"];
                    [sub setObject:[flight objectForKey:@"Price"] forKey:@"price"];
                    [sub setObject:[flight objectForKey:@"Duration"] forKey:@"duration"];
                    [newItem setObject:sub forKey:@"firstFlight"];
                }
                if(count2 == 2){
                    NSString *sentence2 = [NSString stringWithFormat:@"The second flight recomendation is %@. It costs %@ and lasts %@ minutes.", name, [flight objectForKey:@"Price"], [flight objectForKey:@"Duration"]];
                    self.secondOutput.text = sentence2;
                    NSMutableDictionary *sub = [[NSMutableDictionary alloc] init];
                    [sub setObject:name forKey:@"name"];
                    [sub setObject:[flight objectForKey:@"Price"] forKey:@"price"];
                    [sub setObject:[flight objectForKey:@"Duration"] forKey:@"duration"];
                    [newItem setObject:sub forKey:@"secondFlight"];
                }
                if(count2 == 3){
                    NSString *sentence3 = [NSString stringWithFormat:@"The third flight recomendation is %@. It costs %@ and lasts %@ minutes.", name, [flight objectForKey:@"Price"], [flight objectForKey:@"Duration"]];
                    self.thirdOutput.text = sentence3;
                    NSMutableDictionary *sub = [[NSMutableDictionary alloc] init];
                    [sub setObject:name forKey:@"name"];
                    [sub setObject:[flight objectForKey:@"Price"] forKey:@"price"];
                    [sub setObject:[flight objectForKey:@"Duration"] forKey:@"duration"];
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
    
    if(self.carStatus == 1){
        int count3 = 1;
        NSMutableDictionary *newItem =[[NSMutableDictionary alloc] init];
        for(id car in self.carResults){
            NSString *name = [car objectForKey:@"id"];
            NSString *description = [car objectForKey:@"description"];
            NSString *price = [car objectForKey:@"price"];
            NSString *capacity = [car objectForKey:@"number_of_passengers"];
            if(count3 == 1){
                [newItem setObject:car forKey:@"firstCar"];
                if(self.flightStatus == 0 && self.hotelStatus == 0){
                    // first position
                    NSString *textOuput = [NSString stringWithFormat:@"The first car is a %@. %@. It costs %@ and can take up to %@ people.", name, description, price, capacity];
                    self.firstOutput.text = textOuput;
                }
                
                if((self.flightStatus == 1 && self.hotelStatus == 0) || (self.flightStatus == 0 && self.hotelStatus == 1)){
                    //second position
                    NSString *textOuput = [NSString stringWithFormat:@"The first car is a %@. %@. It costs %@ and can take up to %@ people.", name, description, price, capacity];
                    self.fourthOutput.text = textOuput;
                }
                
                if(self.flightStatus == 1 && self.hotelStatus == 1){
                    // last position
                    NSString *textOuput = [NSString stringWithFormat:@"The first car is a %@. %@. It costs %@ and can take up to %@ people.", name, description, price, capacity];
                    self.seventhOutput.text = textOuput;
                }
            }
            if(count3 == 2){
                [newItem setObject:car forKey:@"secondCar"];
                if(self.flightStatus == 0 && self.hotelStatus == 0){
                    // first position
                    NSString *textOuput = [NSString stringWithFormat:@"The first car is a %@. %@. It costs %@ and can take up to %@ people.", name, description, price, capacity];
                    self.secondOutput.text = textOuput;
                }
                
                if((self.flightStatus == 1 && self.hotelStatus == 0) || (self.flightStatus == 0 && self.hotelStatus == 1)){
                    //second position
                    NSString *textOuput = [NSString stringWithFormat:@"The first car is a %@. %@. It costs %@ and can take up to %@ people.", name, description, price, capacity];
                    self.fifthOutput.text = textOuput;
                }
                
                if(self.flightStatus == 1 && self.hotelStatus == 1){
                    // last position
                    NSString *textOuput = [NSString stringWithFormat:@"The first car is a %@. %@. It costs %@ and can take up to %@ people.", name, description, price, capacity];
                    self.eighthOutput.text = textOuput;
                }
            }
            if(count3 == 3){
                [newItem setObject:car forKey:@"thirdCar"];
                if(self.flightStatus == 0 && self.hotelStatus == 0){
                    // first position
                    NSString *textOuput = [NSString stringWithFormat:@"The first car is a %@. %@. It costs %@ and can take up to %@ people.", name, description, price, capacity];
                    self.thirdOutput.text = textOuput;
                }
                
                if((self.flightStatus == 1 && self.hotelStatus == 0) || (self.flightStatus == 0 && self.hotelStatus == 1)){
                    //second position
                    NSString *textOuput = [NSString stringWithFormat:@"The first car is a %@. %@. It costs %@ and can take up to %@ people.", name, description, price, capacity];
                    self.fourthOutput.text = textOuput;
                }
                
                if(self.flightStatus == 1 && self.hotelStatus == 1){
                    // last position
                    NSString *textOuput = [NSString stringWithFormat:@"The first car is a %@. %@. It costs %@ and can take up to %@ people.", name, description, price, capacity];
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
    if(self.lastThird == 1){
        self.ninthButton.backgroundColor = self.ninthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.ninthButtonState = !self.ninthButtonState;
        if(self.eigthButtonState == 1 || self.seventhButtonState == 1){
            self.eighthButton.backgroundColor = [UIColor whiteColor];
            self.eigthButtonState = 0;
            self.seventhButton.backgroundColor = [UIColor whiteColor];
            self.seventhButtonState = 0;
        }
    }
}

- (IBAction)eigthButtonTapped:(id)sender {
    if(self.lastThird == 1){
        self.eighthButton.backgroundColor = self.eigthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.eigthButtonState = !self.eigthButtonState;
        if(self.ninthButtonState == 1 || self.seventhButtonState == 1){
            self.ninthButton.backgroundColor = [UIColor whiteColor];
            self.ninthButtonState = 0;
            self.seventhButton.backgroundColor = [UIColor whiteColor];
            self.seventhButtonState = 0;
        }
    }
}

- (IBAction)seventhButtonTapped:(id)sender {
    if(self.lastThird == 1){
        self.seventhButton.backgroundColor = self.seventhButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.seventhButtonState = !self.seventhButtonState;
        if(self.eigthButtonState == 1 || self.ninthButtonState == 1){
            self.eighthButton.backgroundColor = [UIColor whiteColor];
            self.eigthButtonState = 0;
            self.ninthButton.backgroundColor = [UIColor whiteColor];
            self.ninthButtonState = 0;
        }
    }
}

- (IBAction)sixthButtonTapped:(id)sender {
    if(self.secondThird == 1){
        self.sixthButton.backgroundColor = self.sixthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.sixthButtonState = !self.sixthButtonState;
        if(self.fifthButtonState == 1 || self.fourthButtonState == 1){
            self.fifthButton.backgroundColor = [UIColor whiteColor];
            self.fifthButtonState = 0;
            self.fourthButton.backgroundColor = [UIColor whiteColor];
            self.fourthButtonState = 0;
        }
    }
}

- (IBAction)fifthButtonTapped:(id)sender {
    if(self.secondThird == 1){
        self.fifthButton.backgroundColor = self.fifthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.fifthButtonState = !self.fifthButtonState;
        if(self.sixthButtonState == 1 || self.fourthButtonState == 1){
            self.sixthButton.backgroundColor = [UIColor whiteColor];
            self.sixthButtonState = 0;
            self.fourthButton.backgroundColor = [UIColor whiteColor];
            self.fourthButtonState = 0;
        }
    }
}

- (IBAction)fourthButtonTapped:(id)sender {
    if(self.secondThird == 1){
        self.fourthButton.backgroundColor = self.fourthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.fourthButtonState = !self.fourthButtonState;
        if(self.sixthButtonState == 1 || self.fifthButtonState == 1){
            self.sixthButton.backgroundColor = [UIColor whiteColor];
            self.sixthButtonState = 0;
            self.fifthButton.backgroundColor = [UIColor whiteColor];
            self.fifthButtonState = 0;
        }
    }
}

- (IBAction)thirdButtonTapped:(id)sender {
    if(self.firstThird == 1){
        self.thirdButton.backgroundColor = self.thirdButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.thirdButtonState = !self.thirdButtonState;
        if(self.firstButtonState == 1 || self.secondButtonState == 1){
            self.firstButton.backgroundColor = [UIColor whiteColor];
            self.firstButtonState = 0;
            self.secondButton.backgroundColor = [UIColor whiteColor];
            self.secondButtonState = 0;
        }
    }
}

- (IBAction)secondButtonTapped:(id)sender {
    if(self.firstThird == 1){
        self.secondButton.backgroundColor = self.secondButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.secondButtonState = !self.secondButtonState;
        if(self.firstButtonState == 1 || self.thirdButtonState == 1){
            self.firstButton.backgroundColor = [UIColor whiteColor];
            self.firstButtonState = 0;
            self.thirdButton.backgroundColor = [UIColor whiteColor];
            self.thirdButtonState = 0;
        }
    }
}

- (IBAction)firstButtonTapped:(id)sender {
    if(self.firstThird == 1){
        self.firstButton.backgroundColor = self.firstButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.firstButtonState = !self.firstButtonState;
        if(self.secondButtonState == 1 || self.thirdButtonState == 1){
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
        if(self.flightStatus == 1){
            if(self.firstButtonState == 1){
                NSMutableDictionary *val = [self.selectedServices objectForKey:@"flights"];
                NSMutableDictionary *selectedFlight = [val objectForKey:@"firstFlight"];
                [newAdd setObject:selectedFlight forKey:@"flights"];
            }
            if(self.secondButtonState == 1){
                NSMutableDictionary *val = [self.selectedServices objectForKey:@"flights"];
                NSMutableDictionary *selectedFlight = [val objectForKey:@"secondFlight"];
                [newAdd setObject:selectedFlight forKey:@"flights"];
            }
            if(self.thirdButtonState == 1){
                NSMutableDictionary *val = [self.selectedServices objectForKey:@"flights"];
                NSMutableDictionary *selectedFlight = [val objectForKey:@"thirdFlight"];
                [newAdd setObject:selectedFlight forKey:@"flights"];
            }
        }
        
        if(self.hotelStatus == 1){
            if(self.flightStatus == 1){
                if(self.fourthButtonState == 1){
                    NSMutableDictionary *val = [_selectedServices objectForKey:@"hotels"];
                    NSMutableDictionary *selectedHotel = [val objectForKey:@"firstHotel"];
                    [newAdd setObject:selectedHotel forKey:@"hotels"];
                }
                if(self.fifthButtonState == 1){
                    NSMutableDictionary *val = [_selectedServices objectForKey:@"hotels"];
                    NSMutableDictionary *selectedHotel = [val objectForKey:@"secondHotel"];
                    [newAdd setObject:selectedHotel forKey:@"hotels"];
                }
                if(self.sixthButtonState == 1){
                    NSMutableDictionary *val = [_selectedServices objectForKey:@"hotels"];
                    NSMutableDictionary *selectedHotel = [val objectForKey:@"thirdHotel"];
                    [newAdd setObject:selectedHotel forKey:@"hotels"];
                }
            } else {
                if(self.firstButtonState == 1){
                    NSMutableDictionary *val = [_selectedServices objectForKey:@"hotels"];
                    NSMutableDictionary *selectedHotel = [val objectForKey:@"firstHotel"];
                    [newAdd setObject:selectedHotel forKey:@"hotels"];
                }
                if(_secondButtonState == 1){
                    NSMutableDictionary *val = [_selectedServices objectForKey:@"hotels"];
                    NSMutableDictionary *selectedHotel = [val objectForKey:@"secondHotel"];
                    [newAdd setObject:selectedHotel forKey:@"hotels"];
                }
                if(self.thirdButtonState == 1){
                    NSMutableDictionary *val = [_selectedServices objectForKey:@"hotels"];
                    NSMutableDictionary *selectedHotel = [val objectForKey:@"thirdHotel"];
                    [newAdd setObject:selectedHotel forKey:@"hotels"];
                }
            }
        }
        
        if(self.carStatus == 1){
            if(self.flightStatus == 1){
                if(self.hotelStatus == 0){
                    if(self.fourthButtonState == 1){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"firstCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                    if(self.fifthButtonState == 1){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"secondCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                    if(self.sixthButtonState == 1){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"thirdCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                }
                if(self.hotelStatus == 1){
                    if(self.seventhButtonState == 1){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"firstCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                    if(self.eigthButtonState == 1){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"secondCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                    if(self.ninthButtonState == 1){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"thirdCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                }
            } else {
                if(self.hotelStatus == 0){
                    if(self.firstButtonState == 1){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCars = [val objectForKey:@"firstCar"];
                        [newAdd setObject:selectedCars forKey:@"cars"];
                    }
                    if(self.secondButtonState == 1){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"secondCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                    if(self.thirdButtonState == 1){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"thirdCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                } else {
                    if(self.fourthButtonState == 1){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCars = [val objectForKey:@"firstCar"];
                        [newAdd setObject:selectedCars forKey:@"cars"];
                    }
                    if(self.fifthButtonState == 1){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"secondCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                    if(self.sixthButtonState == 1){
                        NSMutableDictionary *val = [_selectedServices objectForKey:@"cars"];
                        NSMutableDictionary *selectedCar = [val objectForKey:@"thirdCar"];
                        [newAdd setObject:selectedCar forKey:@"cars"];
                    }
                }
            }
        }
        if(self.savedItineraries == nil){
            NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
            [temp setObject:newAdd forKey:self.itinCount];
            self.savedItineraries = temp;
        } else {
            [self.savedItineraries setObject:newAdd forKey:self.itinCount];
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
    }
}
- (IBAction)firstFilterTapped:(id)sender {
    if(self.flightStatus == 1){
        [self performSegueWithIdentifier:@"displayResultsToFlightFilter" sender:sender];
    }
    if(self.flightStatus == 0 && self.hotelStatus == 1){
        [self performSegueWithIdentifier:@"displayResultsToHotelFilter" sender:sender];
    }
    
    if(self.flightStatus == 0 && self.hotelStatus == 0 && self.carStatus == 1){
        [self performSegueWithIdentifier:@"displayResultsToCarFilter" sender:sender];
    }
}
- (IBAction)secondFilterTapped:(id)sender {
    if(self.flightStatus == 1 && self.hotelStatus == 1){
        [self performSegueWithIdentifier:@"displayResultsToHotelFilter" sender:sender];
    }
    
    if(self.flightStatus == 0 && self.hotelStatus == 1 && self.carStatus == 1){
        [self performSegueWithIdentifier:@"displayResultsToCarFilter" sender:sender];
    }
}
- (IBAction)thirdFilterTapped:(id)sender {
    if(self.flightStatus == 1 && self.hotelStatus == 1 && self.carStatus == 1){
        [self performSegueWithIdentifier:@"displayResultsToCarFilter" sender:sender];
    }
}
@end
