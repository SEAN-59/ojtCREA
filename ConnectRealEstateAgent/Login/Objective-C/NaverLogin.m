//
//  NaverLogin.m
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/12.
//

#import "NaverLogin.h"
    

@interface NaverLogin () <SendLoginResultDelegate>
{
    NaverThirdPartyLoginConnection* connection;
}

@end

@implementation NaverLogin


- (void)naverSignIn {
    [self requestThirdpartyLogin];
}

- (void)oauth20Connection:(NaverThirdPartyLoginConnection *)oauthConnection didFailWithError:(NSError *)error {
    NSLog(@"Fail %@", error);
}

- (void)oauth20ConnectionDidFinishDeleteToken {
    NSLog(@"DeleteToken");
    
}

- (void)oauth20ConnectionDidFinishRequestACTokenWithAuthCode {
    NSLog(@"Success");
}

- (void)oauth20ConnectionDidFinishRequestACTokenWithRefreshToken {
    NSLog(@"Refresh Token successs");
}

- (void)requestThirdpartyLogin {
    connection = [NaverThirdPartyLoginConnection getSharedInstance];
    connection.delegate = self;
    connection.isNaverAppOauthEnable = TRUE;
    connection.isInAppOauthEnable = TRUE;
    [connection setOnlyPortraitSupportInIphone:TRUE];
    [connection setConsumerKey: kConsumerKey];
    NSLog(@"%@",kConsumerKey);
    [connection setConsumerSecret:kConsumerSecret];
    NSLog(@"%@",kConsumerSecret);
    [connection setAppName:kServiceAppName];
    NSLog(@"%@",kServiceAppName);
    [connection setServiceUrlScheme:kServiceAppUrlScheme];
    NSLog(@"%@",kServiceAppUrlScheme);
    [connection requestThirdPartyLogin];
    
//    AppDelegate *appDelegate = (AppDelegate)[[UIApplication sharedApplication] delegate];
    
//    [naverLoginInstance requestThirdPartyLogin];
    
}

//- (void)requestAccessTokenWithRefreshToken {
//    connection = [NaverThirdPartyLoginConnection getSharedInstance];
//    connection.delegate = self;
//    [connection requestAccessTokenWithRefreshToken];
//}

//- (void)sendRequestWithUrlString {
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://openapi.naver.com/v1/nid/me"]];
//
//    NSString *authValue = [NSString stringWithFormat:@"Bearer %@", connection.accessToken];
//
//    [urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
//
//    [[[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString *decodingString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (error) {
//                NSLog(@"Error happened - %@", [error description]);
////                [_mainView setResultLabelText:[error description]];
//            } else {
//                NSLog(@"recevied data - %@", decodingString);
////                [_mainView setResultLabelText:decodingString];
//            }
//        });
//    }] resume];
//}

@end
