//
//  LoginProtocol.h
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/20.
//

#ifndef LoginProtocol_h
#define LoginProtocol_h

#import <UIKit/UIKit.h>


@protocol SendSocialLoginResult <NSObject>

@optional
- (void) sendSignInResult: (BOOL) result NS_SWIFT_NAME(sendSignInResutl(result:));

@end



#endif /* LoginProtocol_h */
