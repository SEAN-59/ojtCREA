//
//  DatabaseManager.h
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/17.
//

#import <Foundation/Foundation.h>
#import "DBProtocolDelegate.h"

@import FirebaseCore;
@import FirebaseDatabase;
@import FirebaseAuth;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DatabaseType) { user, area, item, chat };

//@protocol DatabaseCallDelegate <NSObject>
//
//@optional
//- (void) successSaveDB: (BOOL)result NS_SWIFT_NAME(successSaveDB(result:));
//- (void) successReadUser: (BOOL)result NS_SWIFT_NAME(successReadUser(result:));
//- (void) successReadArea: (BOOL)result data: (NSArray*) data NS_SWIFT_NAME(successReadArea(result:data:));
//
//- (void) successReadItemMarker: (BOOL)result data: (nullable NSDictionary*) data number: (int) number itemCd: (NSString*) itemCd NS_SWIFT_NAME(successReadItem(result:data:number:itemCd:));
//
//- (void) successReadUserItem: (BOOL)result data: (NSArray*) data NS_SWIFT_NAME(successReadUserItem(result:data:));
//- (void) successReadUserItemValue: (BOOL)result data: (NSArray*) data NS_SWIFT_NAME(successReadUserItemValue(result:data:));
//
//- (void) successReadAreaLike: (BOOL)result data: (NSArray*) data NS_SWIFT_NAME(successReadAreaLike(result:data:));
//- (void) successReadAreaItem: (BOOL)result data: (NSArray*) data NS_SWIFT_NAME(successReadAreaItem(result:data:));
//
//@end

@interface DatabaseManager : NSObject

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRAuth *handle;
@property (strong, nonatomic) id<DatabaseCallDelegate> delegate;
- (NSString*) currentUser;

- (void) createData: (DatabaseType) type Data: (id) data NS_SWIFT_NAME(createData(type:data:));

- (void) updateAreaLikeData: (NSString*) addrCd type: (BOOL) type NS_SWIFT_NAME(updateAreaLikeData(addrCd:type:));

- (void) readUserData;
- (void) readItemData: (NSString*) itemCd  NS_SWIFT_NAME(readItemData(itemCd:));

- (void) readAreaData;

- (void) readUserItemKeyData;
- (void) readUserItemValueData: (NSString*) addrCd;
- (void) readUserDataUserType: (NSString*) uid NS_SWIFT_NAME(readUserDataUserType(uid:));

- (void) readItemDataMarker:(NSString *)itemCd number:(int)number NS_SWIFT_NAME(readItemDataMarker(itemCd:number:));
- (void) readAreaDataLike:(NSString*) addrCd NS_SWIFT_NAME(readAreaDataLike(addrCd:));
- (void) readAreaDataItem:(NSString*) addrCd NS_SWIFT_NAME(readAreaDataItem(addrCd:));

- (void) readUserDataName;

- (void) updateUserDataName: (NSString*) name NS_SWIFT_NAME(updateUserDataName(name:));
- (void) updateUserDataLike: (NSString*) income sell: (NSString*) sell NS_SWIFT_NAME(updateUserDataLike(income:sell:));
- (void) updateUserDataType: (NSString*) type NS_SWIFT_NAME(updateUserDataType(type:));
- (void) updateUserDataTag:(NSString*) addr name: (NSString*) name NS_SWIFT_NAME(updateUserDataTag(addr:name:));
- (void) updateItemData: (NSString*) itemCd data: (NSDictionary*) data NS_SWIFT_NAME(updateItemData(itemCd:data:));


- (void) deleteUserDataItem: (NSString*) areaCd itemCd: (NSString*) itemCd itemCnt: (int) itemCnt NS_SWIFT_NAME(deleteUserDataItem(areaCd:itemCd:itemCnt:));

@end

NS_ASSUME_NONNULL_END
