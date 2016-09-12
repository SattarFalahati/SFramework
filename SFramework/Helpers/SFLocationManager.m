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

#pragma mark - FUNCTIONS

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



@end
