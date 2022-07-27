//
//  Flights_Information.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/11/22.
//

#import "Flights_Information.h"

@implementation Flights_Information

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.departureCity = dictionary[@"departure_city"];
        self.departureDate = dictionary[@"departure_date"];
        self.arrivalCity = dictionary[@"destination_city"];
        self.returnDate = dictionary[@"return_date"];
        self.numberOfTravelers = dictionary[@"number_of_travlers"];
    }
    return self;
}

@end
