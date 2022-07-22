//
//  DisplayResultsViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/22/22.
//

#import "DisplayResultsViewController.h"

@interface DisplayResultsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *flightRSOutput;
@property (strong, nonatomic) IBOutlet UILabel *hotelRSOutput;

@end

@implementation DisplayResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.flightResults);
    NSLog(@"%@", self.hotelResults);
    NSString *test = @"These are your hotel recomendations:";
    
    int count = 1;
    for(id item in self.hotelResults){
        NSString *name = [item objectForKey:@"name"];
        NSString *price = [item objectForKey:@"price"];
        NSString *rating = [item objectForKey:@"rating"];
        
        if(count == 1){
            test = [NSString stringWithFormat:@"%@ The first hotel recomendation is the %@. It costs %@ per night and is rated %@ stars.", test, name, price, rating];
        }
        if(count == 2){
            test = [NSString stringWithFormat:@"%@ The second hotel recomendation is the %@. It costs %@ per night and is rated %@ stars.", test, name, price, rating];
        }
        if(count == 3){
            test = [NSString stringWithFormat:@"%@ The third hotel recomendation is the %@. It costs %@ per night and is rated %@ stars.", test, name, price, rating];
        }
        if(count == 4){
            test = [NSString stringWithFormat:@"%@ The fourth hotel recomendation is the %@. It costs %@ per night and is rated %@ stars.", test, name, price, rating];
        }
        if(count == 5){
            test = [NSString stringWithFormat:@"%@ The fifth hotel recomendation is the %@. It costs %@ per night and is rated %@ stars.", test, name, price, rating];
        }
        count++;
    }
    
    NSString *test2 = @"These are your flights recomendations:";
    int count2 = 1;
    for(id flight in self.flightResults){
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
            test2 = [NSString stringWithFormat:@"%@ The first flight recomendation is %@. It costs %@ and lasts %@ minutes.", test2, name, [flight objectForKey:@"Price"], [flight objectForKey:@"Duration"]];
        }
        if(count2 == 2){
            test2 = [NSString stringWithFormat:@"%@ The second flight recomendation is %@. It costs %@ and lasts %@ minutes.", test2, name, [flight objectForKey:@"Price"], [flight objectForKey:@"Duration"]];
        }
        if(count2 == 3){
            test2 = [NSString stringWithFormat:@"%@ The third flight recomendation is %@. It costs %@ and lasts %@ minutes.", test2, name, [flight objectForKey:@"Price"], [flight objectForKey:@"Duration"]];
        }
        if(count2 == 4){
            test2 = [NSString stringWithFormat:@"%@ The fourth flight recomendation is %@. It costs %@ and lasts %@ minutes.", test2, name, [flight objectForKey:@"Price"], [flight objectForKey:@"Duration"]];
        }
        if(count2 == 5){
            test2 = [NSString stringWithFormat:@"%@ The fifth flight recomendation is %@. It costs %@ and lasts %@ minutes.", test2, name, [flight objectForKey:@"Price"], [flight objectForKey:@"Duration"]];
        }
        count2++;
    }
    self.hotelRSOutput.text = test;
    self.flightRSOutput.text = test2;
}


@end
