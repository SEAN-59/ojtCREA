//
//  GoogleLogin.m
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/12.
//

#import "GoogleLogin.h"

@implementation GoogleLogin

- (void)googleSignInWithFirebase:(UIViewController *)vc{
    
    GIDConfiguration *config = [[GIDConfiguration alloc] initWithClientID:[FIRApp defaultApp].options.clientID];
    [GIDSignIn.sharedInstance setConfiguration:config];
//    __weak __auto_type weakSelf = self;
    [GIDSignIn.sharedInstance signInWithPresentingViewController: vc
                                                      completion:^(GIDSignInResult * _Nullable result, NSError * _Nullable error) {
//        __auto_type strongSelf = weakSelf;
//        if (strongSelf == nil) { return; }
        
        if (error == nil) {
            FIRAuthCredential *credential =
            [FIRGoogleAuthProvider credentialWithIDToken:result.user.idToken.tokenString
                                             accessToken:result.user.accessToken.tokenString];
            [[FIRAuth auth] signInWithCredential:credential
                                      completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            }];
        } else {
            // error
      }
    }];
    
}

@end
