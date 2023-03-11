//
//  AppleLogin.m
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/12.
//

#import "AppleLogin.h"

@interface AppleLogin () <SendLoginResultDelegate>


@end

@implementation AppleLogin

/// 애플의 응답을 처리하는 대리자 클래스와 nonce의 SHA256 해시를 요청에 포함하는 것으로 애플의 로그인 과정을 시작
- (void)startSignInWithAppleFlow {
    NSLog(@"Start_startSignInWithAppleFlow");
    
    NSString *nonce = [self randomNonce:32];
    self.currentNonce = nonce;
    
    ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
    ASAuthorizationAppleIDRequest *request = [appleIDProvider createRequest];
    
    request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
    
    request.nonce = [self stringBySha256HashingString:nonce];
    
    ASAuthorizationController *authorizationController =
    [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
//    authorizationController.delegate = self;
    [authorizationController setDelegate:self];
    authorizationController.presentationContextProvider = self;
    [authorizationController performRequests];
    
    NSLog(@"End_startSignInWithAppleFlow");
}

/// 모든 로그인 요청에 임의의 문자열을 생성하여 앱의 인증 요청에 대한 응답으로 받은 ID 토큰이 특별히 부여되었는지 확인하는데 사용
- (NSString *)randomNonce:(NSInteger)length {
    NSLog(@"Start_randomNonce");
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
    NSLog(@"End_randomNonce");
    return [result copy];
}

/// 로그인 요청과 함께 nonce 의 SHA256 해시를 전송하면 애플은 응답으로 원래의 값을 전달한다.
/// FB 는 원래의 nonce 를 해싱하고 전달받은 값과 비교해 응답 검증
- (NSString *)stringBySha256HashingString:(NSString *)input {
    NSLog(@"Start_256Hashing");
    const char *string = [input UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, (CC_LONG)strlen(string), result);
    
    NSMutableString *hashed = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [hashed appendFormat:@"%02x", result[i]];
    }
    NSLog(@"End_256Hashing");
    return hashed;
}

/// ASAuthorizationControllerDelegate를 구현해 apple의 응답을 처리
- (void)authorizationController:(ASAuthorizationController *)controller
   didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    NSLog(@"Start_didCompleteWithauth");
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
                NSLog(@"End_didCompleteWithauth");
                // Error. If error.code == FIRAuthErrorCodeMissingOrInvalidNonce,
                // make sure you're sending the SHA256-hashed nonce as a hex string
                // with your request to Apple.
                return;
            } else {
                NSLog(@"End_didCompleteWithauth");
            }
            // Sign-in succeeded!
        }];
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller
           didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    NSLog(@"Sign in with Apple errored: %@", error);
}



// MARK: - DELEGATE 필수 메서드
- (nonnull ASPresentationAnchor)presentationAnchorForAuthorizationController:(nonnull ASAuthorizationController *)controller {
    return self.presentingVC.view.window;
}



@end
