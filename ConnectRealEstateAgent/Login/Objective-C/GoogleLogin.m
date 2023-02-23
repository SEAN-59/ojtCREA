//
//  GoogleLogin.m
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/12.
//

#import "GoogleLogin.h"

@interface GoogleLogin () <SendSocialLoginResult>

@end

@implementation GoogleLogin

- (void)googleSignInWithFirebase:(UIViewController *)vc{
    
    GIDConfiguration *config = [[GIDConfiguration alloc] initWithClientID:[FIRApp defaultApp].options.clientID];
    [GIDSignIn.sharedInstance setConfiguration:config];
    [GIDSignIn.sharedInstance signInWithPresentingViewController: vc
                                                      completion:^(GIDSignInResult * _Nullable result, NSError * _Nullable error) {
        
        if (error == nil) {
            FIRAuthCredential *credential =
            [FIRGoogleAuthProvider credentialWithIDToken:result.user.idToken.tokenString
                                             accessToken:result.user.accessToken.tokenString];
            
            [[FIRAuth auth] signInWithCredential:credential
                                      completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
                if (error == nil) {
                    [self.delegate sendSignInResult:TRUE];
                    [[DatabaseManager alloc]createData:user
                                                  Data:authResult.user.uid];
                }
            }];
        } else {
            // error
      }
    }];
    
}

@end
