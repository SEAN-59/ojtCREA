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

@interface DatabaseManager : NSObject
@property (strong, nonatomic) FIRDatabaseReference *ref;
- (void) writeData: (NSDictionary*) inputDict NS_SWIFT_NAME(writeData(input:));
//-
@end

NS_ASSUME_NONNULL_END
