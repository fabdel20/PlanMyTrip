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
@property (nonatomic, strong) NSString *arrivalDate;
@property (nonatomic, strong) NSString *departureDate;
@property (nonatomic, strong) NSString *numberOfGuests;

@end

NS_ASSUME_NONNULL_END
