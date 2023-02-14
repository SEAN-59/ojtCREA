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
- (void) getAPIData: (id)data NS_SWIFT_NAME(getAPIData(json:));

@end

@interface SearchAddress : NSObject

@property (weak, nonatomic) id <SendAPIDataDelegate> delegate;

-(void) choiceRoad;
//-(void) choiceBuildSggCd: (NSString*)sggCd BjdCd: (NSString*)bjdCd Bun: (NSString*)bun Ji: (NSString*)ji;

-(void) choiceBuild: (NSMutableDictionary*) param;



@end

NS_ASSUME_NONNULL_END
