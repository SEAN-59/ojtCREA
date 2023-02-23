//
//  LoginProtocol.h
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/21.
//

#ifndef LoginProtocol_h
#define LoginProtocol_h

@protocol SendSocialLoginResult <NSObject>

@optional
- (void) sendSignInResult: (BOOL) result NS_SWIFT_NAME(sendSignInResult(result:));

@end

#endif /* LoginProtocol_h */
