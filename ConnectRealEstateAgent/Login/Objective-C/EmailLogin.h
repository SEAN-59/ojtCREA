//
//  EmailLogin.h
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/12.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"
#import "LoginProtocol.h"

@import Firebase;
@import FirebaseCore;
@import FirebaseAuth;

NS_ASSUME_NONNULL_BEGIN
//@protocol sendEmailLoginResult <NSObject>
//
//@optional
//- (void) sendCreateResult: (BOOL)result;
//
//- (void) sendSignInResult: (BOOL)result NS_SWIFT_NAME(sendSignInResult(result:));
//
//@end

@interface EmailLogin : NSObject <SendLoginResultDelegate>
//@property (strong, nonatomic) DatabaseManager* dbManager;
@property (weak, nonatomic) id<SendLoginResultDelegate> delegate;


- (BOOL) checkEmailTxf: (NSString*) email;
- (BOOL) checkPasswordTxf: (NSString*) password;

- (void) signInEmail: (NSString*) email password: (NSString*) password NS_SWIFT_NAME(signInEmail(email:password:));

- (void) createEmail: (NSString*) email password: (NSString*) password;

@end

NS_ASSUME_NONNULL_END
