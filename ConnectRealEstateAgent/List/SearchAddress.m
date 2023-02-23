//
//  SearchAddress.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/14.
//

#import "SearchAddress.h"
#import "ConnectRealEstateAgent-Swift.h"

@interface SearchAddress ()

-(void) searchAddressURL: (NSString*)url Parameters: (NSMutableDictionary*) param Type: (NSString*) type;
-(void) searchNaverGeocoding: (NSString*)url Parameters:(NSMutableDictionary*) param;

-(void) choiceBuild: (NSDictionary*) param;

-(NSMutableDictionary*) createRoadParameters: (NSString*) key Address: (NSString*) address;
-(NSMutableDictionary*) createBuildParameters: (NSString*) key SggCd: (NSString*)sggCd BjdCd: (NSString*)bjdCd Bun: (NSString*)bun Ji: (NSString*)ji;
-(NSMutableDictionary*) createNaverGeoParameters: (NSString*) naverId key: (NSString*) key Address: (NSString*) address;

-(NSMutableDictionary*) roadParsingData: (NSDictionary*) data;
-(NSMutableDictionary*) buildParsingData: (NSDictionary*) data;
-(NSMutableDictionary*) geoParsingData: (NSDictionary*) data;

@end

@implementation SearchAddress

// MARK: - CALL PARTS
- (void)choiceRoad:(NSString *)address {
    KeyData* keys = [[KeyData alloc] init];
    NSString* roadKey = [NSString stringWithString: keys.roadKey];
    URLDatas* urls = [[URLDatas alloc] init];
    NSString* roadURL = [NSString stringWithString: urls.roadAddress];
    
    NSMutableDictionary* roadParam = [NSMutableDictionary dictionaryWithDictionary: [self createRoadParameters:roadKey Address:address]];
    
    [self searchAddressURL:roadURL Parameters:roadParam Type:@"road"];
}

- (void)choiceBuild:(NSDictionary *)param {
    KeyData* keys = [[KeyData alloc] init];
    NSString* buildKey = [NSString stringWithString: keys.decodingKey];
    URLDatas* urls = [[URLDatas alloc] init];
    NSString* buildURL = [NSString stringWithString: urls.buildService];
    
    NSString*(^checkZero)(NSString*) =  ^(NSString* dictValue) {
        NSString* value = @"0000";

        if (dictValue != nil) {
            value = [NSString stringWithFormat:@"%@",dictValue];
            while([value length] != 4){
                value = [@"0" stringByAppendingString:value];
            }
        }
        
        return value;
    };
    
    NSMutableDictionary* buildParam = [NSMutableDictionary dictionaryWithDictionary:
                                       [self createBuildParameters:buildKey
                                                   SggCd:[param objectForKey:@"sggCd"]
                                                   BjdCd:[param objectForKey:@"bjdCd"]
                                                     Bun:checkZero([param objectForKey:@"bun"])
                                                      Ji:checkZero([param objectForKey:@"ji"])
                                       ]];
    
    [self searchAddressURL:buildURL Parameters:buildParam Type: @"build"];
}

- (void)checkGeocode:(NSString *)address {
    KeyData* keys = [[KeyData alloc] init];
    NSString* naverKey = [NSString stringWithString: keys.naverKey];
    NSString* naverID = [NSString stringWithString: keys.naverID];
    URLDatas* urls = [[URLDatas alloc] init];
    NSString* naverURL = [NSString stringWithString: urls.naverGeocode];
    
    NSMutableDictionary* naverGeoParm = [NSMutableDictionary dictionaryWithDictionary:[self createNaverGeoParameters:naverID key:naverKey Address:address]];
    
    [self searchNaverGeocoding:naverURL Parameters:naverGeoParm];
    
}
// MARK: - NETWORKING PART
- (void)searchAddressURL:(NSString *)url Parameters:(NSMutableDictionary *)param Type:(NSString *)type{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:url
      parameters:param
         headers:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        if ([type isEqualToString: @"road"]) {
            NSDictionary* roadData = [self roadParsingData:responseObject];
            if (roadData == nil) {
                [self.delegate getAddressAPI:nil];
            } else {
                [self choiceBuild:roadData];
            }
        } else if ([type isEqualToString: @"build"]) {
            NSDictionary* buildData = [self buildParsingData:responseObject];
            [self.delegate getAddressAPI:buildData];
            // delegate에 Dictionary 값으로 넘어가니까 잘 풀어서 사용하면 된다.
        }
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR: %@", error);
    }];
}

- (void)searchNaverGeocoding:(NSString *)url Parameters:(NSMutableDictionary *)param {
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:url
      parameters:param
         headers:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* geoData = [self geoParsingData:responseObject];
        
        [self.delegate getGeocodingAPI:geoData];
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR: %@", error);
    }];
    
}

// MARK: - CREATE PARAMETER

- (NSMutableDictionary*)createRoadParameters:(NSString *)key Address:(NSString *)address {
    NSMutableDictionary* urlParameters = [[NSMutableDictionary alloc] init];
    [urlParameters setObject:key forKey:@"confmKey"];
    [urlParameters setObject:address forKey:@"keyword"];
    [urlParameters setObject:@1 forKey:@"currentPage"];
    [urlParameters setObject:@1 forKey:@"currentPerPage"];
    [urlParameters setObject:@"json" forKey:@"resultType"];
    
    return urlParameters;
}

- (NSMutableDictionary *)createBuildParameters:(NSString *)key SggCd:(NSString *)sggCd BjdCd:(NSString *)bjdCd Bun:(NSString *)bun Ji:(NSString *)ji{
    NSMutableDictionary* urlParameters = [[NSMutableDictionary alloc] init];
    [urlParameters setObject:key forKey:@"serviceKey"];
    [urlParameters setObject:sggCd forKey:@"sigunguCd"];
    [urlParameters setObject:bjdCd forKey:@"bjdongCd"];
    [urlParameters setObject:bun forKey:@"bun"];
    [urlParameters setObject:ji forKey:@"ji"];
    [urlParameters setObject:@"json" forKey:@"_type"];
    
    return urlParameters;
}

- (NSMutableDictionary *)createNaverGeoParameters:(NSString *)naverId key:(NSString *)key Address:(NSString *)address {
    NSMutableDictionary* urlParameters = [[NSMutableDictionary alloc] init];
    [urlParameters setObject:naverId forKey:@"X-NCP-APIGW-API-KEY-ID"];
    [urlParameters setObject:key forKey:@"X-NCP-APIGW-API-KEY"];
    [urlParameters setObject:address forKey:@"query"];
    
    return urlParameters;
}
// MARK: - DATA PARSING

- (NSMutableDictionary *)roadParsingData:(NSDictionary *)data {
    NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
    
    int roadCode = [[[[data objectForKey:@"results"] objectForKey:@"common"] objectForKey:@"totalCount"] intValue];
    if (roadCode != 1) {
        return nil;
    }
    
    NSDictionary *juso = [[data objectForKey:@"results"] objectForKey:@"juso"][0];
    
    [result setObject: [[juso objectForKey:@"admCd"] substringWithRange: NSMakeRange(0, 5)] forKey:@"sggCd"];
    [result setObject: [[juso objectForKey:@"admCd"] substringFromIndex:5] forKey:@"bjdCd"];
    [result setObject: [juso objectForKey:@"lnbrMnnm"] forKey:@"bun"];
    [result setObject: [juso objectForKey:@"lnbrSlno"] forKey:@"ji"];
    
    return result;
}

- (NSMutableDictionary *)buildParsingData:(NSDictionary *)data {
    NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
    NSDictionary *item = [[[[data objectForKey:@"response"] objectForKey:@"body"] objectForKey:@"items"] objectForKey: @"item"];
    
    [result setObject: [item objectForKey:@"platPlc"] forKey:@"oldAddress"];
    [result setObject: [item objectForKey:@"newPlatPlc"] forKey:@"newAddress"];
    [result setObject: [item objectForKey:@"platArea"] forKey:@"platArea"];
    [result setObject: [item objectForKey:@"archArea"] forKey:@"archArea"];
    [result setObject: [item objectForKey:@"totArea"] forKey:@"totArea"];
    [result setObject: [item objectForKey:@"vlRat"] forKey:@"vlRat"];
    [result setObject: [item objectForKey:@"mainPurpsCdNm"] forKey:@"purpsNm"];
    [result setObject: [item objectForKey:@"grndFlrCnt"] forKey:@"grndFlrCnt"];
    [result setObject: [item objectForKey:@"ugrndFlrCnt"] forKey:@"ugrndFlrCnt"];
    [result setObject: [item objectForKey:@"useAprDay"] forKey:@"useAprDay"];
    
    return result;
}

-(NSMutableDictionary *)geoParsingData:(NSDictionary *)data {
    NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
    NSDictionary *geo = [data objectForKey:@"addresses"][0];
    
    [result setObject:[geo objectForKey:@"x"] forKey:@"lon"];
    [result setObject:[geo objectForKey:@"y"] forKey:@"lat"];

    return result;
    
}

@end
