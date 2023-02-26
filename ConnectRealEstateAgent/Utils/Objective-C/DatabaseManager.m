//
//  DatabaseManager.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/17.
//

#import "DatabaseManager.h"

@interface DatabaseManager ()
-(NSString*) currentUser;

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
        NSLog(@"%@",uid);
        return uid;
        
        
    } else {
        NSLog(@"Do not connect.");
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
    NSLog(@"%@",uid);
    
    NSString* path = @"/asd/";
    
    [[self.ref child:@"asd"]setValue:@{@"0":@"a", @"1":@"b", @"2":@"c", @"3":@"d"}];
    
    [[self.ref child:path ] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
            if (error == Nil) {
//                NSLog(@"%@",snapshot.);
                NSLog(@"%@",[snapshot.value class]);
                if ([snapshot.value class] == [NSNull class]) {
                    NSLog(@"nil?");
                }
//                NSLog(@"%lu",(unsigned long)[snapshot.value count]);
            }
    }];
}

- (void)createUserData:(NSString*) data {
//    NSString* path = [NSString stringWithFormat:@"/UserData/%@/",data];
    
    [[[[self.ref child:@"UserData"] child:data] child:@"userNm"] setValue:@"고객"];
    
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

- (void)readUserData:(NSString *)uid {
    NSString* path = [NSString stringWithFormat:@"/UserData/%@/userNm",uid];
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == nil) {
            if ([snapshot.value isEqual: @"고객"]) { // 일반 고객 = FALSE
                [self.delegate successReadUser:FALSE];
            } else if ([snapshot.value isEqual: @"사업자"]) { // 사업자 고객 = TRUE
                [self.delegate successReadUser:TRUE];
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
                    
                    /// 이부분 진행 중인데 왜 배열값이 안넘어오는지 모르겠네???
                    NSLog(@"%@",[snapshot.value allValues]);
                    NSLog(@"%@",[[snapshot.value allValues] class]);
                    NSArray* arr = [NSMutableArray arrayWithObject:[snapshot.value allValues]];
                    NSLog(@"%@", arr);
                    [self.delegate successReadUserItemValue:TRUE data:arr];
                }
            }
    }];
}

- (void)readItemData:(NSString *)itemCd number:(NSInteger)number{
    NSString* path = [NSString stringWithFormat:@"/ItemData/%@/",itemCd];
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == nil) {
            if ([snapshot.value isKindOfClass:[NSNull class]]) {
                [self.delegate successReadItem:FALSE data:[NSDictionary new] number:0];
            } else {
                [self.delegate successReadItem:TRUE data:snapshot.value number:number];
            }
        }
    }];
    
}

@end
