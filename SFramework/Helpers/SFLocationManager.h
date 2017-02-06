//
//  SFLocationManager.h
//  Pods
//
//  Created by Mac on 12/09/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface SFLocationManager : NSObject

/// Block to get current location
typedef void (^SFLocationManagerBlock)(CLLocationCoordinate2D currentLocation);

// MARK: - Get user current location 

/// initial location manager to get user current location
+ (void)initGeoLocationManagerWithCompletitionBlock:(SFLocationManagerBlock)locationBlock;

/// Stop getting location *** IMPORTANT : if we don't call this method location will get update endlessly
+ (void)stopGeoLocationManager;

// MARK: - DISTANCE

/// Calculate Distance *** This function return kilometers ***
+ (NSString *)calculateDistanceFromLocation:(CLLocationCoordinate2D)startLocation toLocation:(CLLocationCoordinate2D)destinationLocation;

// MARK: - Position

/// Check if position is valid position
+ (BOOL)isValidPosition:(CLLocationCoordinate2D)coordinate;

// MARK: - Address & Coordinate

/// Get address based on coordinate IMPORTANT : for defult in success block it will return address, city, zip , dicAddress . in case that we need more option like country ect we need to print dicAddress.
+ (void)getAddressFromCoordinate:(CLLocationCoordinate2D)coordinate withSuccessBlock:(void (^)(NSDictionary *dicAddress, NSString *strAddress, NSString *strCitty, NSString *strZipCode))successBlock andFailureBlock:(void (^)(NSError *error))failureBlock;

/// Get coordinate based on address
+ (void)getCoordinateFromAddress:(NSString *)address andCity:(NSString *)city withSuccessBlock:(void (^)(CLLocationCoordinate2D coordinate))successBlock andFailureBlock:(void (^)(NSError *error))failureBlock;

@end
