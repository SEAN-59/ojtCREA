//
//  SearchAddress.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/14.
//

#import "SearchAddress.h"
#import "ConnectRealEstateAgent-Swift.h"

@interface SearchAddress () <NSXMLParserDelegate>

-(void) searchAddressURL: (NSString*)url Parameters: (NSMutableDictionary*) param;
-(NSMutableDictionary*) createRoad: (NSString*) key Address: (NSString*) address;
-(NSMutableDictionary*) createBuild: (NSString*) key SggCd: (NSString*)sggCd BjdCd: (NSString*)bjdCd Bun: (NSString*)bun Ji: (NSString*)ji;

-(NSMutableDictionary*) roadParsingData: (NSDictionary*) data;

@end

@implementation SearchAddress

- (void)choiceRoad {
    KeyData* keys = [[KeyData alloc] init];
    NSString* roadKey = [NSString stringWithString: keys.roadKey];
    URLDatas* urls = [[URLDatas alloc] init];
    NSString* roadURL = [NSString stringWithString: urls.roadAddress];
    
    NSString* address = @"충청남도 천안시 서북구 성정동 835-1번지";
    
    NSMutableDictionary* roadParam = [NSMutableDictionary dictionaryWithDictionary: [self createRoad:roadKey Address:address]];
    
    [self searchAddressURL:roadURL Parameters:roadParam];
}

-(void)choiceBuild:(NSMutableDictionary *)param {
    KeyData* keys = [[KeyData alloc] init];
    NSString* buildKey = [NSString stringWithString: keys.decodingKey];
    URLDatas* urls = [[URLDatas alloc] init];
    NSString* buildURL = [NSString stringWithString: urls.buildService];
    
    NSString*(^checkZero)(id) =  ^(id dictValue) {
        NSString* value = [NSString stringWithFormat:@"%@",dictValue];
        while(1){
            if ([value length] != 4) {
                value = @"0" + value;
            } else {
                return value;
            }
        }
    };
    
    NSMutableDictionary* buildParam = [NSMutableDictionary dictionaryWithDictionary:
                                       [self createBuild:buildKey
                                                   SggCd:[param objectForKey:@"sggCd"]
                                                   BjdCd:[param objectForKey:@"bjdCd"]
                                                     Bun:checkZero([param objectForKey:@"bun"])
                                                      Ji:checkZero([param objectForKey:@"ji"])
                                       ]];
    
    [self searchAddressURL:buildURL Parameters:buildParam];
}
- (void)searchAddressURL:(NSString *)url Parameters:(NSMutableDictionary *)param {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:url
      parameters:param
         headers:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        [self.delegate getAPIData:responseObject];
        NSDictionary* roadParam = [self roadParsingData:responseObject];
        [self choiceBuild:roadParam];
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR: %@", error);
    }];
}

- (NSMutableDictionary*)createRoad:(NSString *)key Address:(NSString *)address {
    NSMutableDictionary* urlParameters = [[NSMutableDictionary alloc] init];
    [urlParameters setObject:key forKey:@"confmKey"];
    [urlParameters setObject:@1 forKey:@"currentPage"];
    [urlParameters setObject:@1 forKey:@"currentPerPage"];
    [urlParameters setObject:address forKey:@"keyword"];
    [urlParameters setObject:@"json" forKey:@"resultType"];
    
    
    return urlParameters;
}

- (NSMutableDictionary *)createBuild:(NSString *)key SggCd:(NSString *)sggCd BjdCd:(NSString *)bjdCd Bun:(NSString *)bun Ji:(NSString *)ji{
    NSMutableDictionary* urlParameters = [[NSMutableDictionary alloc] init];
    [urlParameters setObject:key forKey:@"serviceKey"];
    [urlParameters setObject:sggCd forKey:@"sigunguCd"];
    [urlParameters setObject:bjdCd forKey:@"bjdongCd"];
    [urlParameters setObject:bun forKey:@"bun"];
    [urlParameters setObject:ji forKey:@"ji"];
    [urlParameters setObject:@"json" forKey:@"_type"];
//    NSLog(@"%@", urlParameters);
    return urlParameters;
}

- (NSMutableDictionary *)roadParsingData:(NSDictionary *)data {
    NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
    NSDictionary *juso = [[data objectForKey:@"results"] objectForKey:@"juso"][0];
    
    [result setObject: [[juso objectForKey:@"admCd"] substringWithRange: NSMakeRange(0, 5)] forKey:@"sggCd"];
    [result setObject: [[juso objectForKey:@"admCd"] substringFromIndex:5] forKey:@"emdCd"];
    
    [result setObject:[juso objectForKey:@"lnbrMnnm"] forKey:@"lnbrMnnm"];
    
    if ([juso objectForKey:@"lnbrSlno"] == nil) {
        [result setObject: @"0000" forKey:@"lnbrSlno"];
    } else {
        [result setObject:[juso objectForKey:@"lnbrSlno"] forKey:@"lnbrSlno"];
    }
    
    
    return result;
}

@end
