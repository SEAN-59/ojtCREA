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

@end

@interface DatabaseManager : NSObject

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRAuth *handle;
@property (strong, nonatomic) id<DatabaseCallDelegate> delegate;

- (void) createData: (DatabaseType) type Data: (id) data NS_SWIFT_NAME(createData(type:data:));

- (void) writeData: (NSDictionary*) inputDict NS_SWIFT_NAME(writeData(input:));

- (void) testData: (id)data;
//-
@end

NS_ASSUME_NONNULL_END
