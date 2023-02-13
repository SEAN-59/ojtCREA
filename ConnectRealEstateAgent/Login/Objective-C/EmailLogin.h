//
//  EmailLogin.h
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/12.
//

#import <Foundation/Foundation.h>

@import Firebase;
@import FirebaseCore;
@import FirebaseAuth;

NS_ASSUME_NONNULL_BEGIN
@protocol sendEmailLoginResult <NSObject>

@optional
- (void) sendCreateResult: (BOOL)result;
/*
 dsdsds
 */
- (void) sendSignResult: (BOOL)result NS_SWIFT_NAME(sendSignResult(result:));

@end

@interface EmailLogin : NSObject <sendEmailLoginResult>
@property (weak, nonatomic) id<sendEmailLoginResult> delegate;

- (BOOL) checkEmailTxf: (NSString*) email;
- (BOOL) checkPasswordTxf: (NSString*) password;

- (void) signInEmail: (NSString*) email password: (NSString*) password;

- (void) createEmail: (NSString*) email password: (NSString*) password;

@end

NS_ASSUME_NONNULL_END
