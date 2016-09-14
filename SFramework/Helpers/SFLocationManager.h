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

/// Block to have current location
typedef void (^SFLocationManagerBlock)(CLLocationCoordinate2D currentLocation);

#pragma mark - Get user current location 

/// initial location manager to get user current location
+ (void)initGeoLocationManagerWithCompletitionBlock:(SFLocationManagerBlock)locationBlock;

/// Stop getting location *** IMPORTANT : if we don't call this method location will get update endlessly
+ (void)stopGeoLocationManager;

#pragma mark - DISTANCE

/// Calculate Distance *** This function return kilometers ***
+ (NSString *)calculateDistanceFromLocation:(CLLocationCoordinate2D)startLocation toLocation:(CLLocationCoordinate2D)destinationLocation;

@end
