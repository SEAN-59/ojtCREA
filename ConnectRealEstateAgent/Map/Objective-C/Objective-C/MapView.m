//
//  MapView.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/22.
//

#import "MapView.h"


@interface MapView () 
-(void) moveToMapCamera: (NMFMapView*) map lat: (double) latitude lon: (double) longitude NS_SWIFT_NAME(moveToMapCamera(map:lat:lon:));


@end


@implementation MapView

//MARK: - PRIVATE
- (void)moveToMapCamera:(NMFMapView *)map lat:(double)latitude lon:(double)longitude{
    NMFCameraUpdate *cameraUpdate = [NMFCameraUpdate cameraUpdateWithScrollTo:NMGLatLngMake(latitude, longitude)];
    [map moveCamera:cameraUpdate];
}


- (void)callInitMap {
    
}

/// 현재 위치 받아서 Location 으로 넘겨주는 메서드
/// 가장 처음 시작은 이 부분으로 할 것 같음
- (void)moveToNowLocation:(NMFMapView *)map {
    self.locationManager = [[CLLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager requestAlwaysAuthorization];
    
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
        [self moveToMapCamera:map
                          lat: self.locationManager.location.coordinate.latitude
                          lon: self.locationManager.location.coordinate.longitude];
    } else {
        NSLog(@"OFF!");
    }
    
}


/// 마커를 만들어 주는 메서드
/// 용도에 따라서 마커의 생성 위치와 갯수가 다름
- (void)makeMarker:(UIViewController *)view map:(NMFMapView *)map lat:(double)lat lon:(double)lon addrCd:(NSString *)addrCd address:(NSString *)address {
    
    NMFMarker* marker = [NMFMarker new];
    marker.position = NMGLatLngMake(lat, lon);
    marker.mapView = map;
    marker.isHideCollidedSymbols = TRUE;
    marker.isHideCollidedMarkers = TRUE;
    marker.isHideCollidedCaptions = TRUE;
    
    NMFOverlayTouchHandler handler = ^BOOL(NMFOverlay *overlay) {
//        if (marker.)
        /// 마커가 겹쳐지면 클릭 안되게 하는 구간이 필요할 것 같음
        if (self.userType) {
            InfoMarkerViewController* infoMarkerVC = [[InfoMarkerViewController alloc] initWithNibName:@"InfoMarkerViewController" bundle:nil];
            
            [view presentViewController:infoMarkerVC
                               animated:TRUE
                             completion:^{
                [infoMarkerVC setAnyThings:address addrCd:addrCd];
            }];
            
        }else {
            
            DetailMarkerViewController* detailMarkerVC = [[DetailMarkerViewController alloc] initWithNibName:@"DetailMarkerViewController" bundle:nil];
            detailMarkerVC.modalPresentationStyle = UIModalPresentationAutomatic;
            
            [view presentViewController:detailMarkerVC
                               animated:TRUE
                             completion:^{
                [detailMarkerVC openPage:address addrCd:addrCd];
            }];
        }
        return TRUE;
    };
    
    marker.touchHandler = handler;
}


- (void)moveTest:(NMFMapView *)map {
//    [self moveToMapCamera:map lat:37.5572864 lon:126.9793216];
    [self moveToMapCamera:map lat:36.878467 lon:127.154648];
    

}


- (void)sheetPresentationControllerDidChangeSelectedDetentIdentifier:(UISheetPresentationController *)sheetPresentationController {
    
}




@end
