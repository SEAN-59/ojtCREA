//
//  LoginProtocol.h
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/21.
//

#ifndef LoginProtocol_h
#define LoginProtocol_h

@protocol SendLoginResultDelegate <NSObject>

@optional
- (void) sendSignInResult: (BOOL) result NS_SWIFT_NAME(sendSignInResult(result:));
- (BOOL) sendUserType: (NSString*) uid NS_SWIFT_NAME(sendUserType(uid:));
- (void) sendCreateResult: (BOOL)result;
@end

#endif /* LoginProtocol_h */
