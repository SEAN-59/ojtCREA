//
//  EmailLogin.m
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/12.
//

#import "EmailLogin.h"

@interface EmailLogin ()

@end

@implementation EmailLogin

- (BOOL)checkEmailTxf:(NSString *)email {
    BOOL result = false;
    if (email == nil) {
        return result;
    }
    NSString* filterString = @"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._%+-]+\\.[A-Za-z]{2,64}";
    
    NSRange match = [email rangeOfString:filterString options:NSRegularExpressionSearch];
    
    if (NSNotFound == match.location) {
        result = false;
    }
    else { result = true; }
    
    return result;
}

- (BOOL)checkPasswordTxf:(NSString *)password {
    BOOL result = false;
    if (password == nil) {
        return result;
    }
    NSString* filterString = @"[A-Z0-9a-z._%+-]{6,12}";
    
    NSRange match = [password rangeOfString:filterString options:NSRegularExpressionSearch];
    
    if (NSNotFound == match.location) {
        result = false;
    }
    else { result = true; }
    
    return result;
}

- (void)signInEmail:(NSString *)email password:(NSString *)password {
    [[FIRAuth auth] signInWithEmail:email
                           password:password
                         completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if (error == nil) {
            [self.delegate sendSignInResult:true];
        } else {
            [self.delegate sendSignInResult:false];
        }
    }];
}

- (void) createEmail:(NSString *)email password:(NSString *)password {
    [[FIRAuth auth] createUserWithEmail:email
                               password:password
                             completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        
        if (error == nil) {
            NSLog(@"%@",authResult);
            NSLog(@"%@",authResult.user.uid);
            
            [[DatabaseManager alloc]createData:user
                                          Data:authResult.user.uid];
            
            [self.delegate sendCreateResult:TRUE];
        } else { // 계정을 만들다 발생하는 오류
            [self.delegate sendCreateResult:FALSE];
        }
    }];
}

@end
