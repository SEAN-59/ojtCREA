//
//  MapView.h
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/22.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@import NMapsMap;


NS_ASSUME_NONNULL_BEGIN

@interface MapView : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager* locationManager;

-(void) moveToMapCamera: (NMFMapView*) map lat: (double) latitude lon: (double) longitude NS_SWIFT_NAME(moveToMapCamera(map:lat:lon:));

-(void) moveToNowLocation: (NMFMapView*) map NS_SWIFT_NAME(moveToNowLocation(map:));

-(void) moveTest: (NMFMapView*) map;

@end

NS_ASSUME_NONNULL_END
