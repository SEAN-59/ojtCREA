//
//  AppleLogin.m
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/12.
//

#import "AppleLogin.h"

@interface AppleLogin ()


@end

@implementation AppleLogin

/// 모든 로그인 요청에 임의의 문자열을 생성하여 앱의 인증 요청에 대한 응답으로 받은 ID 토큰이 특별히 부여되었는지 확인하는데 사용
///
///
- (void)startSignInWithAppleFlow {
    NSString *nonce = [self randomNonce:32];
    self.currentNonce = nonce;
    ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
    ASAuthorizationAppleIDRequest *request = [appleIDProvider createRequest];
    request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
    request.nonce = [self stringBySha256HashingString:nonce];
    
    ASAuthorizationController *authorizationController =
    [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
    authorizationController.delegate = self;
    authorizationController.presentationContextProvider = self;
    NSLog(@"INIT?");
    [authorizationController performRequests];
}

- (NSString *)randomNonce:(NSInteger)length {
    NSAssert(length > 0, @"Expected nonce to have positive length");
    NSString *characterSet = @"0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._";
    NSMutableString *result = [NSMutableString string];
    NSInteger remainingLength = length;
    
    while (remainingLength > 0) {
        NSMutableArray *randoms = [NSMutableArray arrayWithCapacity:16];
        for (NSInteger i = 0; i < 16; i++) {
            uint8_t random = 0;
            int errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random);
            NSAssert(errorCode == errSecSuccess, @"Unable to generate nonce: OSStatus %i", errorCode);
            
            [randoms addObject:@(random)];
        }
        
        for (NSNumber *random in randoms) {
            if (remainingLength == 0) {
                break;
            }
            
            if (random.unsignedIntValue < characterSet.length) {
                unichar character = [characterSet characterAtIndex:random.unsignedIntValue];
                [result appendFormat:@"%C", character];
                remainingLength--;
            }
        }
    }
    
    return [result copy];
}

- (NSString *)stringBySha256HashingString:(NSString *)input {
    const char *string = [input UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, (CC_LONG)strlen(string), result);
    
    NSMutableString *hashed = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [hashed appendFormat:@"%02x", result[i]];
    }
    return hashed;
}

- (void)authorizationController:(ASAuthorizationController *)controller
   didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    NSLog(@"INIT2?");
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        ASAuthorizationAppleIDCredential *appleIDCredential = authorization.credential;
        NSString *rawNonce = self.currentNonce;
        NSAssert(rawNonce != nil, @"Invalid state: A login callback was received, but no login request was sent.");
        
        if (appleIDCredential.identityToken == nil) {
            
            NSLog(@"Unable to fetch identity token.");
            return;
        }
        
        NSString *idToken = [[NSString alloc] initWithData:appleIDCredential.identityToken
                                                  encoding:NSUTF8StringEncoding];
        if (idToken == nil) {
            NSLog(@"Unable to serialize id token from data: %@", appleIDCredential.identityToken);
        }
        
        // Initialize a Firebase credential.
        FIROAuthCredential *credential = [FIROAuthProvider credentialWithProviderID:@"apple.com"
                                                                            IDToken:idToken
                                                                           rawNonce:rawNonce];
        
        // Sign in with Firebase.
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRAuthDataResult * _Nullable authResult,
                                               NSError * _Nullable error) {
            if (error != nil) {
                // Error. If error.code == FIRAuthErrorCodeMissingOrInvalidNonce,
                // make sure you're sending the SHA256-hashed nonce as a hex string
                // with your request to Apple.
                return;
            }
            // Sign-in succeeded!
        }];
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller
           didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    NSLog(@"Sign in with Apple errored: %@", error);
}



//- (nonnull ASPresentationAnchor)presentationAnchorForAuthorizationController:(nonnull ASAuthorizationController *)controller {
//    return NSExpression;
//}


@end
