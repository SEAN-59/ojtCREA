//
//  DatabaseManager.h
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/17.
//

#import <Foundation/Foundation.h>

@import FirebaseCore;
@import FirebaseDatabase;
@import FirebaseAuth;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DatabaseType) { user, area, item, chat };

@protocol DatabaseCallDelegate <NSObject>

@optional
- (void) successSaveDB: (BOOL)result NS_SWIFT_NAME(successSaveDB(result:));
- (void) successReadUser: (BOOL)result NS_SWIFT_NAME(successReadUser(result:));
- (void) successReadArea: (BOOL)result data: (NSArray*) data NS_SWIFT_NAME(successReadArea(result:data:));

- (void) successReadItemMarker: (BOOL)result data: (nullable NSDictionary*) data number: (int) number itemCd: (NSString*) itemCd NS_SWIFT_NAME(successReadItem(result:data:number:itemCd:));

- (void) successReadUserItem: (BOOL)result data: (NSArray*) data NS_SWIFT_NAME(successReadUserItem(result:data:));
- (void) successReadUserItemValue: (BOOL)result data: (NSArray*) data NS_SWIFT_NAME(successReadUserItemValue(result:data:));

- (void) successReadAreaLike: (BOOL)result data: (NSArray*) data NS_SWIFT_NAME(successReadAreaLike(result:data:));
- (void) successReadAreaItem: (BOOL)result data: (NSArray*) data NS_SWIFT_NAME(successReadAreaItem(result:data:));

@end

@interface DatabaseManager : NSObject

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRAuth *handle;
@property (strong, nonatomic) id<DatabaseCallDelegate> delegate;
- (NSString*) currentUser;

- (void) createData: (DatabaseType) type Data: (id) data NS_SWIFT_NAME(createData(type:data:));

- (void) updateAreaLikeData: (NSString*) addrCd type: (BOOL) type NS_SWIFT_NAME(updateAreaLikeData(addrCd:type:));

- (void) readUserData: (NSString*) uid NS_SWIFT_NAME(readUserData(uid:));

- (void) readItemData: (NSString*) itemCd  NS_SWIFT_NAME(readItemData(itemCd:));

- (void) readUserItemKeyData;
- (void) readAreaData;
- (void) readUserItemValueData: (NSString*) addrCd;

- (void) readItemDataMarker:(NSString *)itemCd number:(int)number NS_SWIFT_NAME(readItemDataMarker(itemCd:number:));
- (void) readAreaDataLike:(NSString*) addrCd NS_SWIFT_NAME(readAreaDataLike(addrCd:));
- (void) readAreaDataItem:(NSString*) addrCd NS_SWIFT_NAME(readAreaDataItem(addrCd:));



- (void) testData: (id)data;
//-
@end

NS_ASSUME_NONNULL_END
