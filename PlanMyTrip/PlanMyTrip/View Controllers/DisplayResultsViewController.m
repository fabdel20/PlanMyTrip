//
//  DisplayResultsViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/22/22.
//

#import "DisplayResultsViewController.h"
#import "ResultsViewController.h"
#import "HomeViewController.h"
@interface DisplayResultsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *FirstTitle;
@property (strong, nonatomic) IBOutlet UILabel *SecondTitle;
@property (strong, nonatomic) IBOutlet UILabel *ThirdTitle;
@property (strong, nonatomic) IBOutlet UILabel *secondOutput;
@property (strong, nonatomic) IBOutlet UILabel *thirdOutput;
@property (strong, nonatomic) IBOutlet UILabel *fourthOutput;
@property (strong, nonatomic) IBOutlet UILabel *fifthOutput;
@property (strong, nonatomic) IBOutlet UILabel *sixthOutput;
@property (strong, nonatomic) IBOutlet UILabel *seventhOutput;
@property (strong, nonatomic) IBOutlet UILabel *eighthOutput;
@property (strong, nonatomic) IBOutlet UILabel *ninthOutput;
@property (strong, nonatomic) IBOutlet UIButton *firstButton;
@property (strong, nonatomic) IBOutlet UIButton *secondButton;
@property (strong, nonatomic) IBOutlet UIButton *thirdButton;
@property (strong, nonatomic) IBOutlet UIButton *fourthButton;
@property (strong, nonatomic) IBOutlet UIButton *fifthButton;
@property (strong, nonatomic) IBOutlet UIButton *sixthButton;
@property (strong, nonatomic) IBOutlet UIButton *seventhButton;
@property (strong, nonatomic) IBOutlet UIButton *eighthButton;
@property (strong, nonatomic) IBOutlet UIButton *ninthButton;
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
        self.firstThird = YES;
        if(self.hotelStatus == 1){
            self.SecondTitle.text = @"Hotel Recomendations";
            self.secondThird = YES;
            if(self.carStatus == 1){
                self.ThirdTitle.text = @"Car Recomendations";
                self.lastThird = YES;
            }
        } else {
            if(self.carStatus == 1){
                self.SecondTitle.text = @"Car Recomendations";
                self.secondThird = YES;
            }
        }
    } else {
        if(self.hotelStatus == 1){
            self.FirstTitle.text = @"Hotel Recomendations";
            self.firstThird = YES;
            if(self.carStatus == 1){
                self.SecondTitle.text = @"Car Recomendations";
                self.secondThird = YES;
            }
        } else {
            self.FirstTitle.text = @"Car Recomendations";
            self.firstThird = YES; 
        }
    }
    
    if(self.firstThird == 1){
        self.firstButton.backgroundColor = [UIColor whiteColor];
        self.secondButton.backgroundColor = [UIColor whiteColor];
        self.thirdButton.backgroundColor = [UIColor whiteColor];
    }
    
    if(self.secondThird == 1){
        self.fourthButton.backgroundColor = [UIColor whiteColor];
        self.fifthButton.backgroundColor = [UIColor whiteColor];
        self.sixthButton.backgroundColor = [UIColor whiteColor];
    }
    
    if(self.lastThird == 1){
        self.seventhButton.backgroundColor = [UIColor whiteColor];
        self.eighthButton.backgroundColor = [UIColor whiteColor];
        self.ninthButton.backgroundColor = [UIColor whiteColor];
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
                    NSString *test = [NSString stringWithFormat:@"The first hotel recomendation is the %@. It costs %@ per night and is rated %@ stars.", name, price, rating];
                    if(self.flightStatus == 0){
                        self.firstOutput.text = test;
                    } else {
                        self.fourthOutput.text = test;
                    }
                    NSMutableDictionary *sub = [[NSMutableDictionary alloc] init];
                    [sub setObject:name forKey:@"name"];
                    [sub setObject:price forKey:@"price"];
                    [sub setObject:rating forKey:@"rating"];
                    [newItem setObject:sub forKey:@"firstHotel"];
                }
                if(count == 2){
                    NSString *test = [NSString stringWithFormat:@"The second hotel recomendation is the %@. It costs %@ per night and is rated %@ stars.", name, price, rating];
                    if(self.flightStatus == 0){
                        self.secondOutput.text = test;
                    } else {
                        self.fifthOutput.text = test;
                    }
                    NSMutableDictionary *sub = [[NSMutableDictionary alloc] init];
                    [sub setObject:name forKey:@"name"];
                    [sub setObject:price forKey:@"price"];
                    [sub setObject:rating forKey:@"rating"];
                    [newItem setObject:sub forKey:@"secondHotel"];
                }
                if(count == 3){
                    NSString *test = [NSString stringWithFormat:@"The third hotel recomendation is the %@. It costs %@ per night and is rated %@ stars.", name, price, rating];
                    if(self.flightStatus == 0){
                        self.secondOutput.text = test;
                    } else {
                        self.fifthOutput.text = test;
                    }
                    NSMutableDictionary *sub = [[NSMutableDictionary alloc] init];
                    [sub setObject:name forKey:@"name"];
                    [sub setObject:price forKey:@"price"];
                    [sub setObject:rating forKey:@"rating"];
                    [newItem setObject:sub forKey:@"thirdHotel"];
                }
                if(count == 3){
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
                    NSString *test2 = [NSString stringWithFormat:@"The first flight recomendation is %@. It costs %@ and lasts %@ minutes.", name, [flight objectForKey:@"Price"], [flight objectForKey:@"Duration"]];
                    self.firstOutput.text = test2;
                    NSMutableDictionary *sub = [[NSMutableDictionary alloc] init];
                    [sub setObject:name forKey:@"name"];
                    [sub setObject:[flight objectForKey:@"Price"] forKey:@"price"];
                    [sub setObject:[flight objectForKey:@"Duration"] forKey:@"duration"];
                    [newItem setObject:sub forKey:@"firstFlight"];
                }
                if(count2 == 2){
                    NSString *test2 = [NSString stringWithFormat:@"The second flight recomendation is %@. It costs %@ and lasts %@ minutes.", name, [flight objectForKey:@"Price"], [flight objectForKey:@"Duration"]];
                    self.secondOutput.text = test2;
                    NSMutableDictionary *sub = [[NSMutableDictionary alloc] init];
                    [sub setObject:name forKey:@"name"];
                    [sub setObject:[flight objectForKey:@"Price"] forKey:@"price"];
                    [sub setObject:[flight objectForKey:@"Duration"] forKey:@"duration"];
                    [newItem setObject:sub forKey:@"secondFlight"];
                }
                if(count2 == 3){
                    NSString *test2 = [NSString stringWithFormat:@"The third flight recomendation is %@. It costs %@ and lasts %@ minutes.", name, [flight objectForKey:@"Price"], [flight objectForKey:@"Duration"]];
                    self.thirdOutput.text = test2;
                    NSMutableDictionary *sub = [[NSMutableDictionary alloc] init];
                    [sub setObject:name forKey:@"name"];
                    [sub setObject:[flight objectForKey:@"Price"] forKey:@"price"];
                    [sub setObject:[flight objectForKey:@"Duration"] forKey:@"duration"];
                    [newItem setObject:sub forKey:@"thirdFlight"];
                }
                if(count2 == 3){
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
}


- (IBAction)saveItinerary:(id)sender {
    [self performSegueWithIdentifier:@"saveToHomePage" sender:sender];
}

- (IBAction)ninthButtonTapped:(id)sender {
    if(self.lastThird == 1){
        self.ninthButton.backgroundColor = self.ninthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.ninthButtonState = !self.ninthButtonState;
        if(self.eigthButtonState == 1){
            self.eighthButton.backgroundColor = [UIColor whiteColor];
            self.eigthButtonState = 0;
        }
        if(self.seventhButtonState == 1){
            self.seventhButton.backgroundColor = [UIColor whiteColor];
            self.seventhButtonState = 0;
        }
    }
}

- (IBAction)eigthButtonTapped:(id)sender {
    if(self.lastThird == 1){
        self.eighthButton.backgroundColor = self.eigthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.eigthButtonState = !self.eigthButtonState;
        if(self.ninthButtonState == 1){
            self.ninthButton.backgroundColor = [UIColor whiteColor];
            self.ninthButtonState = 0;
        }
        if(self.seventhButtonState == 1){
            self.seventhButton.backgroundColor = [UIColor whiteColor];
            self.seventhButtonState = 0;
        }
    }
}

- (IBAction)seventhButtonTapped:(id)sender {
    if(self.lastThird == 1){
        self.seventhButton.backgroundColor = self.seventhButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.seventhButtonState = !self.seventhButtonState;
        if(self.eigthButtonState == 1){
            self.eighthButton.backgroundColor = [UIColor whiteColor];
            self.eigthButtonState = 0;
        }
        if(self.ninthButtonState == 1){
            self.ninthButton.backgroundColor = [UIColor whiteColor];
            self.ninthButtonState = 0;
        }
    }
}

- (IBAction)sixthButtonTapped:(id)sender {
    if(self.secondThird == 1){
        self.sixthButton.backgroundColor = self.sixthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.sixthButtonState = !self.sixthButtonState;
        if(self.fifthButtonState == 1){
            self.fifthButton.backgroundColor = [UIColor whiteColor];
            self.fifthButtonState = 0;
        }
        if(self.fourthButtonState == 1){
            self.fourthButton.backgroundColor = [UIColor whiteColor];
            self.fourthButtonState = 0;
        }
    }
}

- (IBAction)fifthButtonTapped:(id)sender {
    if(self.secondThird == 1){
        self.fifthButton.backgroundColor = self.fifthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.fifthButtonState = !self.fifthButtonState;
        if(self.sixthButtonState == 1){
            self.sixthButton.backgroundColor = [UIColor whiteColor];
            self.sixthButtonState = 0;
        }
        if(self.fourthButtonState == 1){
            self.fourthButton.backgroundColor = [UIColor whiteColor];
            self.fourthButtonState = 0;
        }
    }
}

- (IBAction)fourthButtonTapped:(id)sender {
    if(self.secondThird == 1){
        self.fourthButton.backgroundColor = self.fourthButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.fourthButtonState = !self.fourthButtonState;
        if(self.sixthButtonState == 1){
            self.sixthButton.backgroundColor = [UIColor whiteColor];
            self.sixthButtonState = 0;
        }
        if(self.fifthButtonState == 1){
            self.fifthButton.backgroundColor = [UIColor whiteColor];
            self.fifthButtonState = 0;
        }
    }
}

- (IBAction)thirdButtonTapped:(id)sender {
    if(self.firstThird == 1){
        self.thirdButton.backgroundColor = self.thirdButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.thirdButtonState = !self.thirdButtonState;
        if(self.firstButtonState == 1){
            self.firstButton.backgroundColor = [UIColor whiteColor];
            self.firstButtonState = 0;
        }
        if(self.secondButtonState == 1){
            self.secondButton.backgroundColor = [UIColor whiteColor];
            self.secondButtonState = 0;
        }
    }
}

- (IBAction)secondButtonTapped:(id)sender {
    if(self.firstThird == 1){
        self.secondButton.backgroundColor = self.secondButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.secondButtonState = !self.secondButtonState;
        if(self.firstButtonState == 1){
            self.firstButton.backgroundColor = [UIColor whiteColor];
            self.firstButtonState = 0;
        }
        if(self.thirdButtonState == 1){
            self.thirdButton.backgroundColor = [UIColor whiteColor];
            self.thirdButtonState = 0;
        }
    }
}

- (IBAction)firstButtonTapped:(id)sender {
    if(self.firstThird == 1){
        self.firstButton.backgroundColor = self.firstButtonState ? UIColor.whiteColor : UIColor.redColor;
        self.firstButtonState = !self.firstButtonState;
        if(self.secondButtonState == 1){
            self.secondButton.backgroundColor = [UIColor whiteColor];
            self.secondButtonState = 0;
        }
        if(self.thirdButtonState == 1){
            self.thirdButton.backgroundColor = [UIColor whiteColor];
            self.thirdButtonState = 0;
        }
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HomeViewController *newView = [segue destinationViewController];
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
                NSMutableDictionary *val = [self.selectedServices objectForKey:@"hotels"];
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
    if(self.savedItineraries == nil){
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        [temp setObject:newAdd forKey:self.itinCount];
        self.savedItineraries = temp;
    } else {
        [self.savedItineraries setObject:newAdd forKey:self.itinCount];
    }
    newView.savedItineraries = self.savedItineraries; 
}
@end
