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
    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",filterString];
    
    result = [emailCheck evaluateWithObject:email];
    
    return result;
}

- (BOOL)checkPasswordTxf:(NSString *)password {
    BOOL result = false;
    if (password == nil) {
        return result;
    }
    NSString* filterString = @"^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{6,12}$";
    NSPredicate *passwordCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",filterString];
    
    result = [passwordCheck evaluateWithObject:password];
    
    return result;
}

- (void)signInEmail:(NSString *)email password:(NSString *)password {
    
}


@end
