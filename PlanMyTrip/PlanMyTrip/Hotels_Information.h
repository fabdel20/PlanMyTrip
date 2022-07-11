//
//  Hotels_Information.h
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Hotels_Information : NSObject
@property (nonatomic, strong) NSString *destination;
@property (nonatomic, strong) NSDate *arrivalDate;
@property (nonatomic, strong) NSDate *departureDate;
@property (nonatomic) int numberOfGuests;

@end

NS_ASSUME_NONNULL_END
