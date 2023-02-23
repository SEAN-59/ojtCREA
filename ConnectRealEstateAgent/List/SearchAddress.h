//
//  SearchAddress.h
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/14.
//

#import <Foundation/Foundation.h>

@import AFNetworking;

NS_ASSUME_NONNULL_BEGIN
@protocol SendAPIDataDelegate <NSObject>

@optional
- (void) getAddressAPI: (nullable NSDictionary*)data NS_SWIFT_NAME(getAddressAPI(json:));
- (void) getGeocodingAPI: (NSDictionary*)data NS_SWIFT_NAME(getGeocodingAPI(json:));

@end

@interface SearchAddress : NSObject

@property (weak, nonatomic) id <SendAPIDataDelegate> delegate;

-(void) choiceRoad: (NSString*) address;

-(void) checkGeocode: (NSString*) address;

@end

NS_ASSUME_NONNULL_END
