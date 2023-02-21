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
    
//    NSString* changeString = [NSString stringWithFormat:@"%@",data];
    
    switch (type) {
        case user:
            [self createUserData:data];
            break;
        case area:
            [self createAreaData:data];
            break;
        case item:
            [self createItemData:data];
//            [self.ref child:@"itemData"] child:<#(nonnull NSString *)#>
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
    
    NSString* path = [NSString stringWithFormat:@"/UserData/%@/",data];
    
    [[[[self.ref child:@"UserData"] child:data] child:@"userNm"] setValue:@"고객"];
    
//    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"businessNum"].key]: @""}];
    
//    [self.ref updateChildValues:@{[[path stringByAppendingString:@"Items/"] stringByAppendingString:[self.ref child:@"0"].key]: @""}];
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
    
    NSString* path = [NSString stringWithFormat:@"/UserData/%@/Items/%@/",uid,[data objectForKey:@"addressCd"]];
    
//    /// 데이터 중복 체크를 위해서 DB의 값 확인 부
//    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
//        if (error == nil ) {
//            /// 중복 확인
//            if ([snapshot.value class] != [NSNull class]) {
//
//            }
//            /// 중복 안됨
//            else {
//
//            }
//
//        }
//
//    }];
    
    
    
    path = [NSString stringWithFormat:@"/UserData/%@/Items/%@", uid,[data objectForKey:@"addressCd"]];
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == nil && [snapshot.value class] == [NSNull class]) {
            
        }
    }];
    
    NSString* itemCd = self.ref.childByAutoId.key;
    path = [NSString stringWithFormat:@"/ItemData/%@/Information/",itemCd];
    
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
    
    path = [NSString stringWithFormat:@"/UserData/%@/Item/",uid];
    
    /// 이부분 넣어야 함
    [[self.ref child:path] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
        if (error == nil) {
            if ([snapshot.value class] == [NSNull class]) {
                [self.ref updateChildValues:@{[path stringByAppendingString: [self.ref child: [data objectForKey:@"addressCd"]].key]:itemCd}];
            } else {
                
            }
        }
    }];
    
}

- (void)createChatData {
    
}


- (void)writeData:(NSDictionary *)inputDict {
}

@end
