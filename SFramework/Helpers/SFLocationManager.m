//
//  SFLocationManager.m
//  Pods
//
//  Created by Mac on 12/09/16.
//
//

#import "SFLocationManager.h"

// SFImporst ( to have access to all classes )
#import "SFImports.h"

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

#pragma mark - Address

/// Get address based on coordinate

+ (void)getAddressFromCoordinate:(CLLocationCoordinate2D)coordinate withSuccessBlock:(void (^)(NSDictionary *dicAddress, NSString *strAddress, NSString *strCitty, NSString *strZipCode))successBlock andFailureBlock:(void (^)(NSError *error))failureBlock
{
    CLGeocoder *geocoder = [CLGeocoder new];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (!error) {
            
            CLPlacemark *placemark = [placemarks firstObject];
            
            NSDictionary *dicAddress = placemark.addressDictionary;
            
            NSString *ZIP =  [dicAddress safeValueForKey:@"ZIP"];
            NSString *city = [dicAddress safeValueForKey:@"City"];
            NSString *address = [dicAddress safeValueForKey:@"Street"];
            
            // check if address is empty send the name instead of address
            if ([address length] == 0) address = [dicAddress safeValueForKey:@"Name"];
            
            if (successBlock) successBlock(dicAddress, address, city, ZIP);
            
        }
        else {
            if (failureBlock) failureBlock(error);
        }
        
    }];
}


/// Get coordinate based on address

+ (void)getCoordinateFromAddress:(NSString *)address andCity:(NSString *)city withSuccessBlock:(void (^)(CLLocationCoordinate2D coordinate))successBlock andFailureBlock:(void (^)(NSError *error))failureBlock
{
    CLGeocoder *geocoder = [CLGeocoder new];
    NSString *addressString = [NSString stringWithFormat:@"%@, %@", address, city];
    
    [geocoder geocodeAddressString:addressString completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (!error) {
            
            CLPlacemark *placemark = [placemarks firstObject];
            CLLocationCoordinate2D coordinate = placemark.location.coordinate;
            
            // Check se if it is valid position
            if (![self isValidPosition:coordinate]) coordinate = kCLLocationCoordinate2DInvalid;
            
            if (successBlock) successBlock(coordinate);
        }
        else {
            if (failureBlock) failureBlock(error);
        }
    }];
}








@end
