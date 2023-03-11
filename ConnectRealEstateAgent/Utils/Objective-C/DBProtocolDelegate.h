//
//  DBProtocolDelegate.h
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/07.
//

#ifndef DBProtocolDelegate_h
#define DBProtocolDelegate_h

@protocol DatabaseCallDelegate <NSObject>

@optional
- (void) successSaveDB: (BOOL)result NS_SWIFT_NAME(successSaveDB(result:));

- (void) successReadArea: (BOOL)result data: (nonnull NSArray*) data NS_SWIFT_NAME(successReadArea(result:data:));
- (void) successReadUser: (BOOL)result data: (nonnull NSDictionary*) data NS_SWIFT_NAME(successReadUser(result:data:));
- (void) successReadItem: (BOOL)result data: (nonnull NSDictionary*) data code: (nonnull NSString*) code NS_SWIFT_NAME(successReadItem(result:data:code:));


- (void) successReadItemMarker: (BOOL)result data: (nullable NSDictionary*) data number: (int) number itemCd: (nonnull NSString*) itemCd NS_SWIFT_NAME(successReadItemMarker(result:data:number:itemCd:));

- (void) successReadUserType: (BOOL)result NS_SWIFT_NAME(successReadUserType(result:));
- (void) successReadUserItem: (BOOL)result data: (nonnull NSArray*) data NS_SWIFT_NAME(successReadUserItem(result:data:));
- (void) successReadUserItemValue: (BOOL)result data: (nonnull NSArray*) data NS_SWIFT_NAME(successReadUserItemValue(result:data:));
-(void) successReadUserName: (BOOL) result data: (nonnull NSString*) data NS_SWIFT_NAME(successReadUserName(result:data:));

- (void) successReadAreaLike: (BOOL)result data: (nonnull NSArray*) data NS_SWIFT_NAME(successReadAreaLike(result:data:));
- (void) successReadAreaItem: (BOOL)result data: (nonnull NSArray*) data NS_SWIFT_NAME(successReadAreaItem(result:data:));


-(void) successUpdateUserType: (BOOL) result;

@end

#endif /* DBProtocolDelegate_h */
