//
//  AppleLogin.h
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/12.
//

#import <UIKit/UIKit.h>
#import "LoginProtocol.h"


@import AuthenticationServices;
@import CommonCrypto;

@import Firebase;
@import FirebaseCore;
@import FirebaseAuth;

NS_ASSUME_NONNULL_BEGIN

@interface AppleLogin : NSObject <ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>

@property NSString* currentNonce;
@property (strong, nonatomic) id<SendSocialLoginResult> delegate;

- (NSString*) randomNonce: (NSInteger)length ;
- (NSString*) stringBySha256HashingString: (NSString*)input ;

- (void) startSignInWithAppleFlow ;


@end

NS_ASSUME_NONNULL_END
