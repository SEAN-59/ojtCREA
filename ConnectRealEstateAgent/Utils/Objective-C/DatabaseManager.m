//
//  DatabaseManager.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/17.
//

#import "DatabaseManager.h"


@interface DatabaseManager ()


@end

@implementation DatabaseManager
- (id) init {
    self = [super init];
    if (self) {
        self.ref =[[FIRDatabase database] reference];
    }
    return self;
}

- (void)writeData:(NSDictionary *)inputDict {
//    inputDict
    NSString *randomKey = self.ref.childByAutoId.key;
    
    [[self.ref child:@"Test"] setValue:@{@"messageid": inputDict}];
    
//    [[[[self.ref child:@"message"] child:self.chatId] child:listCount] setValue:@{@"messageId": key, @"userId": user.uid, @"userName":user.email, @"message" :message, @"time": messageTime}];
}

@end
