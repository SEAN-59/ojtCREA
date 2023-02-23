//
//  MapView.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/22.
//

#import "MapView.h"


@interface MapView () 

@end


@implementation MapView

/// NMFMapview 와 CLLocation을 받아서

- (void)moveToMapCamera:(NMFMapView *)map lat:(double)latitude lon:(double)longitude{
    NMFCameraUpdate *cameraUpdate = [NMFCameraUpdate cameraUpdateWithScrollTo:NMGLatLngMake(latitude, longitude)];
    [map moveCamera:cameraUpdate];
}

/// 현재 위치 받아서 Location 으로 넘겨주는 메서드
- (void)moveToNowLocation:(NMFMapView *)map {
    self.locationManager = [[CLLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager requestAlwaysAuthorization];
    
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"ON!");
        [self.locationManager startUpdatingLocation];
        NSLog(@"%f", self.locationManager.location.coordinate.latitude);
        NSLog(@"%f", self.locationManager.location.coordinate.longitude);
        [self moveToMapCamera:map
                          lat: self.locationManager.location.coordinate.latitude
                          lon: self.locationManager.location.coordinate.longitude];
    } else {
        NSLog(@"OFF!");
    }
    
}

- (void)moveTest:(NMFMapView *)map {
//    [self moveToMapCamera:map lat:37.5572864 lon:126.9793216];
    [self moveToMapCamera:map lat:36.878467 lon:127.154648];
    

}



@end
