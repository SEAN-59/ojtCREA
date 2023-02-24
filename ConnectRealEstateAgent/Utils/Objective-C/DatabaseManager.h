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

/// TRUE 면 사업자 / FALSE 면 일반
- (void) successReadUser: (BOOL)result NS_SWIFT_NAME(successReadUser(result:));

- (void) successReadArea: (BOOL)result data: (NSArray*) data NS_SWIFT_NAME(successReadArea(result:data:));

- (void) successReadUserItem: (BOOL)result data: (NSArray*) data NS_SWIFT_NAME(successReadUserItem(result:data:));

@end

@interface DatabaseManager : NSObject

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRAuth *handle;
@property (strong, nonatomic) id<DatabaseCallDelegate> delegate;

- (void) createData: (DatabaseType) type Data: (id) data NS_SWIFT_NAME(createData(type:data:));

- (void) readUserData: (NSString*) uid NS_SWIFT_NAME(readUserData(uid:));

- (void) readUserItemaData;
- (void) readAreaData;

- (void) testData: (id)data;
//-
@end

NS_ASSUME_NONNULL_END
