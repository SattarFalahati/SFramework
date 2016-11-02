//
//  SFLocationManager.m
//  Pods
//
//  Created by Mac on 12/09/16.
//
//

#import "SFLocationManager.h"

#define kCurrentPositionIsUpdated       @"kCurrentPositionIsUpdated"


@interface SFGeoManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D currentPosition;
@property (copy) SFLocationManagerBlock locationBlock;

- (void)initLocationManager;
- (void)stopLocationManager;

@end


@implementation SFGeoManager

- (void)initLocationManager
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)stopLocationManager
{
    [self.locationManager stopUpdatingLocation];
    self.locationBlock = nil;
}

#pragma mark - DELEGATE

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    self.currentPosition = location.coordinate;
    // return location 
    if (self.locationBlock) self.locationBlock(self.currentPosition);
}

@end

@implementation SFLocationManager

#pragma mark - Get user current location 

SFGeoManager *sfGeoLocationManager;

+ (SFGeoManager *)initGeoLocationManager
{
    @synchronized(self) {
        if (!sfGeoLocationManager) {
            sfGeoLocationManager = [SFGeoManager new];
            sfGeoLocationManager.locationManager = [CLLocationManager new];
            sfGeoLocationManager.locationManager.delegate = sfGeoLocationManager;
            sfGeoLocationManager.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        }
        return sfGeoLocationManager;
    }
}

+ (void)stopGeoLocationManager
{
    if (!sfGeoLocationManager) return;
    
    SFGeoManager *geolocationManager = [self initGeoLocationManager];
    [geolocationManager stopLocationManager];
}

+ (void)initGeoLocationManagerWithCompletitionBlock:(SFLocationManagerBlock)locationBlock
{
   SFGeoManager *geolocationManager = [self initGeoLocationManager];
    geolocationManager.locationBlock = locationBlock;
    [geolocationManager initLocationManager];
    
}

#pragma mark - Distance

/// Calculate Distance *** This function return kilometers ***
+ (NSString *)calculateDistanceFromLocation:(CLLocationCoordinate2D)startLocation toLocation:(CLLocationCoordinate2D)destinationLocation
{
    CLLocation *fromLocation = [[CLLocation alloc] initWithLatitude:startLocation.latitude longitude:startLocation.longitude];
    CLLocation *toLocation = [[CLLocation alloc] initWithLatitude:destinationLocation.latitude longitude:destinationLocation.longitude];
    
    CLLocationDistance distance = [toLocation distanceFromLocation:fromLocation];

    // If distance is less than one kilometers return by metr
    if (distance >= 999.00) return [NSString stringWithFormat:@"%.2f Km",distance/1000];
    
    // Return Kilometers
    return [NSString stringWithFormat:@"%d m",(int)distance];
}

#pragma mark - Position

/// Check if position is valid position
+ (BOOL)isValidPosition:(CLLocationCoordinate2D)coordinate
{
    if (!CLLocationCoordinate2DIsValid(coordinate)) return NO;
    
    if (coordinate.latitude == 0.0 && coordinate.longitude == 0.0) return NO;
    
    return YES;
}



@end
