//
//  NaverLogin.h
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/12.
//

#import <Foundation/Foundation.h>
#import "LoginProtocol.h"
#import "KEYData.h"
#import <NaverThirdPartyLogin/NaverThirdPartyLogin.h>

@import SafariServices;

NS_ASSUME_NONNULL_BEGIN

@interface NaverLogin : NSObject <NaverThirdPartyLoginConnectionDelegate>


@property (strong, nonatomic) id<SendLoginResultDelegate> delegate;
//@property NaverThirdPartyLoginConnection* connection;

-(void)naverSignIn;


@end

NS_ASSUME_NONNULL_END
