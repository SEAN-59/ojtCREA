//
//  NaverLogin.h
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/12.
//

#import <Foundation/Foundation.h>
#import "LoginProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NaverLogin : NSObject
@property (strong, nonatomic) id<SendSocialLoginResult> delegate;
@end

NS_ASSUME_NONNULL_END
