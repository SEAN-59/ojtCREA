//
//  EmailLogin.h
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmailLogin : NSObject
- (BOOL) checkEmailTxf: (NSString*) email;
- (BOOL) checkPasswordTxf: (NSString*) password;

- (void) signInEmail: (NSString*) email password: (NSString*) password;

@end

NS_ASSUME_NONNULL_END
