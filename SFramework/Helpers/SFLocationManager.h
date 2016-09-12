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

/// initial location manager to get user current location
+ (void)initGeoLocationManagerWithCompletitionBlock:(SFLocationManagerBlock)locationBlock;

/// Stop getting location *** IMPORTANT : if we don't call this method location will get update endlessly
+ (void)stopGeoLocationManager;


@end
