//
//  Flights_Information.h
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Flights_Information : NSObject
@property (nonatomic, strong) NSString *departureCity;
@property (nonatomic, strong) NSString *arrivalCity;
@property (nonatomic, strong) NSString *departureDate;
@property (nonatomic, strong) NSString *returnDate;
@property (nonatomic, strong) NSString *numberOfTravelers;
@property (nonatomic, strong) NSString *cabin;
@property (nonatomic, strong) NSString *results;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
