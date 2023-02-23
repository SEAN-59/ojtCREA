//
//  GoogleLogin.h
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

@import GoogleSignIn;

NS_ASSUME_NONNULL_BEGIN


@interface GoogleLogin : NSObject 
@property (strong, nonatomic) id<SendLoginResultDelegate> delegate;

-(void) googleSignInWithFirebase: (UIViewController*)vc ;


@end

NS_ASSUME_NONNULL_END
