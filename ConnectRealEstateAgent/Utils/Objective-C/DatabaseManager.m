//
//  DatabaseManager.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/17.
//

#import "DatabaseManager.h"

@interface DatabaseManager ()
//-(NSString*) currentUser;

- (void) createUserData: (NSString*) data;
- (void) createAreaData: (NSString*) data;
- (void) createItemData: (id) data;
- (void) createChatData;



@end

@implementation DatabaseManager
- (id) init {
    self = [super init];
    if (self) {
        self.ref =[[FIRDatabase database] reference];
        self.handle = [FIRAuth auth];
    }
    return self;
}

- (NSString*)currentUser {
    if (self.handle.currentUser) {
        FIRUser *user = self.handle.currentUser;
        NSString *uid = user.uid;
        return uid;
    } else {
        return nil;
    }
}

- (void)createData:(DatabaseType)type Data:(id)data {
    self.ref =[[FIRDatabase database] reference];
    
    switch (type) {
        case user:
            [self createUserData:data];
            break;
        case area:
            [self createAreaData:data];
            break;
        case item:
            [self createItemData:data];
            break;
        case chat:
//            [self.ref child:@"chatData"] child:<#(nonnull NSString *)#>
            break;
            
        default:
            break;
    }
}

- (void)testData:(id)data {
    
    NSString* uid = [self currentUser];
    if (uid == nil) { return; }
    
    NSString* path = @"/asd/";
    
    [[self.ref child:@"asd"]setValue:@{@"0":@"a", @"1":@"b", @"2":@"c", @"3":@"d"}];
    
    [[self.ref child:path ] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
            if (error == Nil) {
                if ([snapshot.value class] == [NSNull class]) {
                    NSLog(@"nil?");
                }
//                NSLog(@"%lu",(unsigned long)[snapshot.value count]);
            }
    }];
}

- (void)createUserData:(NSString*) data {
//    NSString* path = [NSString stringWithFormat:@"/UserData/%@/",data];
    
    [[[[self.ref child:@"UserData"] child:data] child:@"userType"] setValue:@"고객"];
    
//    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"businessNum"].key]: @""}];
    
//    [self.ref updateChildValues:@{[[path stringByAppendingString:@"Items/"] stringByAppendingString:[self.ref child:@"0"].key]: @""}];z
//
//    [self.ref updateChildValues:@{[[path stringByAppendingString:@"Chats/"] stringByAppendingString:[self.ref child:@"0"].key]: @""}];
//
//    [self.ref updateChildValues:@{[[path stringByAppendingString:@"Like/area/"] stringByAppendingString:[self.ref child:@"0"].key]: @""}];
//
//    [self.ref updateChildValues:@{[[path stringByAppendingString:@"Like/income/"] stringByAppendingString:[self.ref child:@"min"].key]: @""}];
//    [self.ref updateChildValues:@{[[path stringByAppendingString:@"Like/income/"] stringByAppendingString:[self.ref child:@"max"].key]: @""}];
//
//    [self.ref updateChildValues:@{[[path stringByAppendingString:@"Like/sell/"] stringByAppendingString:[self.ref child:@"min"].key]: @""}];
//    [self.ref updateChildValues:@{[[path stringByAppendingString:@"Like/sell/"] stringByAppendingString:[self.ref child:@"max"].key]: @""}];
}

- (void)createAreaData:(NSString *)data {
    NSString* uid = [self currentUser];
    if (uid == nil) { return; }
    
    NSString* path = [NSString stringWithFormat:@"/AreaData/%@/",data];
    
    [[self.ref child:path ] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
            if (error == Nil && [snapshot.value class] == [NSNull class]) {
                [[[[[self.ref child:@"AreaData"] child:data] child:@"Business"] child:@"0"] setValue:uid];
                
                /// 아래 부분들은 나중에 추가할 때 추가를 하기 위해서 일단은 코드만 남겨두기로.
//                [self.ref updateChildValues:@{[[path stringByAppendingString:@"Item/"] stringByAppendingString:[self.ref child:@"0"].key]: @""}];
//
//                [self.ref updateChildValues:@{[[path stringByAppendingString:@"Like/"] stringByAppendingString:[self.ref child:@"0"].key]: @""}];
                
            } else {
                // Database 저장 오류 처리 부분
            }
    }];
    
    
    
}

- (void)createItemData:(id)data {
    NSString* uid = [self currentUser];
    if (uid == nil) { return; }
    
    NSString* itemCd = self.ref.childByAutoId.key;
    NSString* path = [NSString stringWithFormat:@"/ItemData/%@/Information/",itemCd];
    
    [[[[[self.ref child:@"ItemData"] child:itemCd] child:@"Information"] child:@"oldAddress"]setValue: [data objectForKey:@"oldAddress"]];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"newAddress"].key]: [data objectForKey:@"newAddress"]}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"platArea"].key]: [data objectForKey:@"platArea"]}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"archArea"].key]: [data objectForKey:@"archArea"]}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"totArea"].key]: [data objectForKey:@"totArea"]}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"vlRat"].key]: [data objectForKey:@"vlRat"]}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"purpsNm"].key]: [data objectForKey:@"purpsNm"]}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"grndFlrCnt"].key]: [data objectForKey:@"grndFlrCnt"]}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"ugrndFlrCnt"].key]: [data objectForKey:@"ugrndFlrCnt"]}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"useAprDay"].key]: [data objectForKey:@"useAprDay"]}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"newAddress"].key]: [data objectForKey:@"newAddress"]}];
    
    path = [NSString stringWithFormat:@"/ItemData/%@/Invest/",itemCd];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"sell"].key]: [data objectForKey:@"sell"]}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"deposit"].key]: [data objectForKey:@"deposit"]}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"loan"].key]: [data objectForKey:@"loan"]}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"loanRat"].key]: [data objectForKey:@"loanRat"]}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"income"].key]: [data objectForKey:@"income"]}];
    
    /// AreaData_{addressCd}_Item 구성
    path = [NSString stringWithFormat:@"/AreaData/%@/Item/",[data objectForKey:@"addressCd"]];
    
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        // 처음 생성 되는 경우
        if (error == nil && [snapshot.value class] == [NSNull class]) {
            [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"0"].key]: itemCd}];
            
        // 이후 생성되는 부분에서는 저장되어있는 수 만큼 key 변경
        } else if (error == nil && [snapshot.value class] != [NSNull class]) {
            NSString* count = [NSString stringWithFormat:@"%lu",(unsigned long)[snapshot.value count]];
            [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child: count].key]: itemCd}];
            
        } else {
            // 에러 발생시
            
        }
    }];
    
    /// UserData_{UID}_Item_{addressCd}_{itemCd}  구성
    path = [NSString stringWithFormat:@"/UserData/%@/Item/%@/",uid, [data objectForKey:@"addressCd"]];
    
    /// 중복되는거를 이렇게 판단해서 끝내려고 했는데 중복을 일단은 배제를 하고 진행을 해야 다른걸 건들 수 있을것 같음
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == nil) {
            if ([snapshot.value class] == [NSNull class]) {
                [self.ref updateChildValues:@{[path stringByAppendingString: [self.ref child:@"0"].key]:itemCd}];
            } else {
                NSString* count = [NSString stringWithFormat:@"%lu",(unsigned long)[snapshot.value count]];
                [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child: count].key]: itemCd}];
            }
        } else {
            // 에러 발생시
        }
    }];
    
    [self.delegate successSaveDB:TRUE];
    
}

- (void)createChatData {
}
// MARK: - UPDATE
- (void)updateAreaLikeData:(NSString *)addrCd type:(BOOL)type {
    NSString* uid = [self currentUser];
    NSString* path = [NSString stringWithFormat:@"/AreaData/%@/Like/",addrCd];
    
    ///  TRUE  라는 것은 추가가 되어있는 상태
    ///  FALSE 라는 것은 추가 안되어있는 상태
    ///
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == Nil) {
            if (type) {
                NSDictionary* snapDict = snapshot.valueInExportFormat;
                NSArray* keysForValue = [snapDict allKeysForObject:uid];
                if (keysForValue.count > 0) {
                    [[[self.ref child:path] child: [NSString stringWithFormat:@"%@",keysForValue[0]]] setValue:nil];
                }
                
            } else {
                if ([snapshot.value isKindOfClass:[NSNull class]]) {
                    [[[self.ref child: path] child:@"0"] setValue:uid];
                } else {
                    NSDictionary* snapDict = snapshot.valueInExportFormat;
                    NSArray* keys = [snapDict allKeys];
                    NSNumber* areaCount = [NSNumber numberWithInteger: keys.count];
                    
                    @try {
                        id countCheck = keys[keys.count]; // 에러 발생 유도
                    }
                    
                    @catch (NSException *exception) {
                        for (int i = 0; i < keys.count; i ++) {
                            if (i != [keys[i] intValue]) {
                                areaCount = [NSNumber numberWithInt:i];
                            }
                        }
                    }
                    //
                    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child: [NSString stringWithFormat:@"%@", areaCount]].key]: uid}];
                }
            }
            
        }
    }];
        
    path = [NSString stringWithFormat:@"/UserData/%@/Like/area/",uid];
    [[self.ref child:path ] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == Nil) {
            if (type) {
                NSDictionary* snapDict = snapshot.valueInExportFormat;
                
                NSArray* keysForValue = [snapDict allKeysForObject:addrCd];
                
                if (keysForValue.count > 0) {
                    [[[self.ref child:path] child: [NSString stringWithFormat:@"%@",keysForValue[0]]] setValue:nil];
                }
                
            } else {
                if ([snapshot.value isKindOfClass:[NSNull class]]) {
                    [[[self.ref child: path] child:@"0"] setValue:addrCd];
                } else {
                    NSDictionary* snapDict = snapshot.valueInExportFormat;
                    NSArray* keys = [snapDict allKeys];
                    NSNumber* userCount = [NSNumber numberWithInteger: keys.count];

                    @try {
                        id countCheck = keys[keys.count]; // 에러 발생 유도
                    }

                    @catch (NSException *exception) {
                        for (int i = 0; i < keys.count; i ++) {
                            if (i != [keys[i] intValue]) {
                                userCount = [NSNumber numberWithInt:i];
                            }
                        }
                    }
                    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:[NSString stringWithFormat:@"%@", userCount]].key] : addrCd}];
                }
            }
        }
    }];
    
}


- (void)updateUserDataName:(NSString *)name {
    NSString* uid = [self currentUser];
    NSString* path = [NSString stringWithFormat:@"/UserData/%@/",uid];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"userName"].key]: name}];
    
}

- (void)updateUserDataLike:(NSString *)income sell:(NSString *)sell {
    NSString* uid = [self currentUser];
    NSString* path = [NSString stringWithFormat:@"/UserData/%@/Like/",uid];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"income"].key]: income}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"sell"].key]: sell}];
}

- (void)updateUserDataType:(NSString*)type {
    NSString* uid = [self currentUser];
    NSString* path = [NSString stringWithFormat:@"/UserData/%@/",uid];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"userType"].key]: type}];
    
    if ([type  isEqual: @"고객"]) {
        [self.delegate successUpdateUserType:FALSE];
    } else if ([type  isEqual: @"사업자"]) {
        [self.delegate successUpdateUserType:TRUE];
    }
}

- (void)updateUserDataTag:(NSString *)addr name:(NSString *)name {
    NSString* uid = [self currentUser];
    NSString* path = [NSString stringWithFormat:@"/UserData/%@/",uid];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"businessAddr"].key]: addr}];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"businessName"].key]: name}];
    
}

// MARK: - READ
- (void)readUserData {
    NSString* uid = [self currentUser];
    NSString* path = [NSString stringWithFormat:@"/UserData/%@/",uid];
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == nil) {
            if ([snapshot.value isKindOfClass: [NSNull class]]) {
                // 아무것도 없음
                NSDictionary* result = [[NSDictionary alloc] init];
                [self.delegate successReadUser:FALSE data:result];
            } else {
                [self.delegate successReadUser:TRUE data:snapshot.value];
            }
        }
    }];
    
}


- (void)readAreaData {
    NSString* path = @"/AreaData/";
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == nil) {
            if ([snapshot.value isKindOfClass: [NSNull class]]) {
                // 아무것도 없음
                NSArray* result = [[NSArray alloc] init];
                [self.delegate successReadArea:false data:result];
            } else {
                [self.delegate successReadArea:TRUE data:[snapshot.value allKeys]];
            }
        }
    }];
}

- (void)readItemData:(NSString *)itemCd {
    NSString* path = [NSString stringWithFormat:@"/ItemData/%@/",itemCd];
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == nil) {
            if ([snapshot.value isKindOfClass:[NSNull class]]) {
                [self.delegate successReadItem:FALSE data:[NSDictionary new] code:itemCd];
            } else {
                [self.delegate successReadItem:TRUE data:snapshot.value code:itemCd];
            }
        }
    }];
    
}

- (void)readUserDataUserType:(NSString *)uid {
    NSString* path = [NSString stringWithFormat:@"/UserData/%@/userType",uid];
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == nil) {
            if ([snapshot.value isEqual: @"고객"]) { // 일반 고객 = FALSE
                [self.delegate successReadUserType:FALSE];
            } else if ([snapshot.value isEqual: @"사업자"]) { // 사업자 고객 = TRUE
                [self.delegate successReadUserType:TRUE];
            }
        }
    }];
}

- (void)readUserItemKeyData {
    NSString* uid = [self currentUser];
    NSString* path = [NSString stringWithFormat:@"/UserData/%@/Item",uid];
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == nil) {
            if ([snapshot.value isKindOfClass:[NSNull class]]) {
                [self.delegate successReadUserItem:FALSE data:[[NSArray alloc] init]];
            } else {
                [self.delegate successReadUserItem:TRUE data:[snapshot.value allKeys]];
            }
        }
    }];
}

- (void)readUserItemValueData:(NSString *)addrCd {
    NSString* uid = [self currentUser];
    NSString* path = [NSString stringWithFormat:@"/UserData/%@/Item/%@/",uid,addrCd];
    
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
            if (error == nil) {
                if ([snapshot.value isKindOfClass:[NSNull class]]) {
                    [self.delegate successReadUserItemValue:FALSE data:[NSArray new]];
                } else {
                    [self.delegate successReadUserItemValue:TRUE data:snapshot.value];
                }
            }
    }];
}

- (void)readItemDataMarker:(NSString *)itemCd number:(int)number {
    NSString* path = [NSString stringWithFormat:@"/ItemData/%@",itemCd];
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == nil) {
            if ([snapshot.value isKindOfClass:[NSNull class]]) {
                [self.delegate successReadItemMarker:FALSE data:[NSDictionary new] number:0 itemCd:itemCd];
            } else {
                [self.delegate successReadItemMarker:TRUE data:snapshot.value number:number itemCd: itemCd];
            }
        }
    }];
    
}


- (void)readAreaDataLike:(NSString *)addrCd {
    NSString* path = [NSString stringWithFormat:@"/AreaData/%@/Like", addrCd];
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == nil) {
            if ([snapshot.value isKindOfClass: [NSNull class]]) {
                // 아무것도 없음
                NSArray* result = [[NSArray alloc] init];
                [self.delegate successReadAreaLike:false data:result];
            } else {
                [self.delegate successReadAreaLike:TRUE data:snapshot.value];
            }
        }
    }];
}

- (void)readAreaDataItem:(NSString *)addrCd {
    NSString* path = [NSString stringWithFormat:@"/AreaData/%@/Item", addrCd];
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == nil) {
            if ([snapshot.value isKindOfClass: [NSNull class]]) {
                // 아무것도 없음
                NSArray* result = [[NSArray alloc] init];
                [self.delegate successReadAreaItem:false data:result];
            } else {
                [self.delegate successReadAreaItem:TRUE data:snapshot.value];
            }
        }
    }];
}


- (void)readUserDataName {
    NSString* uid = [self currentUser];
    NSString* path = [NSString stringWithFormat:@"/UserData/%@/userName", uid];
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == nil) {
            if ([snapshot.value isKindOfClass: [NSNull class]]) {
                NSString* result = @"";
                [self.delegate successReadUserName:false data:result];
            } else {
                [self.delegate successReadUserName:TRUE data:snapshot.value];
            }
        }
    }];
}



//- (void)readUserDataLike {
//    NSString* uid = [self currentUser];
//    NSString* path = [NSString stringWithFormat:@"/UserData/%@/", uid];
//    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
//        if (error == nil) {
//            if ([snapshot.value isKindOfClass: [NSNull class]]) {
//                NSString* result = @"";
//                [self.delegate successReadUserName:false data:result];
//            } else {
//                [self.delegate successReadUserName:TRUE data:snapshot.value];
//            }
//        }
//    }];
//}

@end
