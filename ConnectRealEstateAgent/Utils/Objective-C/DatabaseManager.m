//
//  DatabaseManager.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/17.
//

#import "DatabaseManager.h"



@interface DatabaseManager ()
-(NSString*) currentUser;

- (void) createUserData: (NSString*) uid;
- (void) createAreaData;
- (void) createItemData;
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
    NSString* uid = [NSString stringWithFormat:@"%@",data];

    switch (type) {
        case user:
            [[[[self.ref child:@"userData"] child:uid] child:@"userNm"] setValue:@"고객"];
            [self createUserData:uid];
            break;
        case area:
            [[self.ref child:@"areaData"] child:@"0000"];
            break;
        case item:
//            [self.ref child:@"itemData"] child:<#(nonnull NSString *)#>
            break;
        case chat:
//            [self.ref child:@"chatData"] child:<#(nonnull NSString *)#>
            break;
            
        default:
            break;
    }
}

- (void)createUserData:(NSString *)uid {
//    NSString* uid = [self currentUser];
//    if(uid == nil) { return; }
    
    NSDictionary* likeDict = @{@"area":@"", @"income":@"", @"sell":@""};
    
    NSString* path = [NSString stringWithFormat:@"/userData/%@/",uid];
    
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"businessNum"].key]: @""}];
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"Items"].key]: @""}];
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"Chats"].key]: @""}];
    [self.ref updateChildValues:@{[path stringByAppendingString:[self.ref child:@"Like"].key]: likeDict}];
}

- (void)createAreaData {
    
}

- (void)createItemData {
    
}

- (void)createChatData {
    
}





- (void)writeData:(NSDictionary *)inputDict {
    
//    [self createData: area];
    
//    [[self.ref child:@"areaData"] setValue:@"abc"];
    
//    NSString *randomKey = self.ref.childByAutoId.key;
    
//    NSString *key = [self.ref child:@"areaData"].key;
//    [self.ref updateChildValues:@{[@"/areaData/" stringByAppendingString:key]: Nil}];
    
//    [[[self.ref child:@"areaData"] child:@"sub"] getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
//        if (error){
//            NSLog(@"%@",error);
//        } else {
//            if (snapshot.value == NULL) {
//                NSLog(@"%@",snapshot.value);
//            } else {
//                NSLog(@"It's NULL");
//            }
//        }
//
//
//    }];
    
//    if (  ) {
//        NSLog(@"out %@", [[self.ref child:@"areaData"] child:@"sub"].key);
//    }
    
    
//    NSDictionary*(^makeDict)(void) = ^(void) {
//        NSDictionary* result = @{@"123":@"q", @"456":@"w"};
//        return result;
//    };
    
//    [data setObject:@"123" forKey:@"qwe"];
//    [data setObject:@{@"123":@"q", @"456":@"w"} forKey:@"dict22"];
//
//
//    [self.ref setValue:data];
}

@end
