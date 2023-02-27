//
//  MapView.h
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/22.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "InfoMarkerViewController.h"
#import "DetailMarkerViewController.h"

@import NMapsMap;


NS_ASSUME_NONNULL_BEGIN

@interface MapView : NSObject <CLLocationManagerDelegate, UISheetPresentationControllerDelegate>

@property (strong, nonatomic) CLLocationManager* locationManager;
@property BOOL userType;


-(void) callInitMap;

-(void) moveToNowLocation: (NMFMapView*) map NS_SWIFT_NAME(moveToNowLocation(map:));
-(void) makeMarker: (UIViewController *)view map: (NMFMapView *)map lat: (double) lat lon: (double) lon addrCd: (NSString*) addrCd address:(NSString*) address NS_SWIFT_NAME(makeMarker(view:map:lat:lon:addrCd:address:));

-(void) moveTest: (NMFMapView*) map;

@end

NS_ASSUME_NONNULL_END
