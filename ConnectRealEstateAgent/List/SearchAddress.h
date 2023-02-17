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
- (void) getAPIData: (NSDictionary*)data NS_SWIFT_NAME(getAPIData(json:));

@end

@interface SearchAddress : NSObject

@property (weak, nonatomic) id <SendAPIDataDelegate> delegate;

-(void) choiceRoad: (NSString*) address;

@end

NS_ASSUME_NONNULL_END
