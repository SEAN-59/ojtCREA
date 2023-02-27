//
//  InfoMarkerViewController.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/24.
//

#import "InfoMarkerViewController.h"

@interface InfoMarkerViewController () <DatabaseCallDelegate>
{
    NSMutableDictionary* tableViewDataDictionary;
}
-(void) tableViewInit;


@end

@implementation InfoMarkerViewController






- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellIdentity = @"InfoMarkerTableViewCell";
    [self tableViewInit];
    self.dbManager = [[DatabaseManager alloc] init];
    [self.dbManager setDelegate:self];
    tableViewDataDictionary = [[NSMutableDictionary alloc] init];
}

- (void)tableViewInit {
    [self.itemListTabelView setDelegate:self];
    [self.itemListTabelView setDataSource:self];
    
    self.cellNib = [UINib nibWithNibName:self.cellIdentity
                                  bundle:nil];
    
    [self.itemListTabelView registerNib:self.cellNib
                 forCellReuseIdentifier:self.cellIdentity];
    
}

- (void)setAnyThings:(NSString *)address addrCd:(NSString *)addrCd {
    
    [self.dbManager readUserItemValueData:addrCd];
    [self.dbManager readAreaDataLike:addrCd];
    self.addrCd = addrCd;
    self.address = address;
}

//MARK: - IBACTION

- (IBAction)tapDismissBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)tapConnectbtn:(UIButton *)sender {
}


//MARK: - TABLEVIEW_DELEGATE

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellCount;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InfoMarkerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentity forIndexPath:indexPath];
    
    
    if (self.cellCount > 0 ) {
        NSString* index = [NSString stringWithFormat:@"%ld", (long)indexPath.item];
        
        NSDictionary* cellData = [tableViewDataDictionary objectForKey:index];
        
        cell.addressLbl.text = [NSString stringWithFormat:@"%@", [cellData objectForKey:@"address"]];
        cell.sellLbl.text = [NSString stringWithFormat:@"%@", [cellData objectForKey:@"sell"]];
        cell.incomeLbl.text = [NSString stringWithFormat:@"%@", [cellData objectForKey:@"income"]];
        cell.loanLbl.text = [NSString stringWithFormat:@"%@", [cellData objectForKey:@"loan"]];
        cell.itemCd = [NSString stringWithFormat:@"%@", [cellData objectForKey:@"itemCd"]];
    }
    
    return cell;
}

//MARK: - DATABASE_DELEGATE
- (void) successReadAreaLike:(BOOL)result data:(NSArray *)data {
    if (result) {
        NSString* count = [NSString stringWithFormat:@"%lu", (unsigned long)data.count];
        self.likePersonLbl.text = [NSString stringWithFormat:@"%@", count];
    } else {
        self.likePersonLbl.text = @"0";
    }
}

- (void)successReadUserItemValue:(BOOL)result data:(NSArray *)data {
    if (result) {
        self.cellCount = data.count;
        for (int i = 0 ; i < data.count; i ++){
            [self.dbManager readItemDataMarker:data[i] number:i];
        }
    } else {
        
    }
}

- (void)successReadItemMarker:(BOOL)result data:(NSDictionary *)data number:(int)number itemCd:(NSString *)itemCd {
    
    if (result) {
        NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[[data objectForKey:@"Information"] objectForKey:@"oldAddress"] forKey:@"address"];
        [dict setObject:[[data objectForKey:@"Invest"] objectForKey:@"sell"] forKey:@"sell"];
        [dict setObject:[[data objectForKey:@"Invest"] objectForKey:@"income"] forKey:@"income"];
        [dict setObject:[[data objectForKey:@"Invest"] objectForKey:@"loan"] forKey:@"loan"];
        [dict setObject:itemCd forKey:@"itemCd"];
        
        [tableViewDataDictionary setObject:dict forKey:[NSString stringWithFormat:@"%d", number]];
        
        if ([tableViewDataDictionary allKeys].count == self.cellCount) {
            [self.itemListTabelView reloadData];
            [self.backView setHidden:TRUE];
            [self.loadingIndicator stopAnimating];
            [self.loadingIndicator setHidden:TRUE];
            self.addrTitleLbl.text = self.address;
        }
        
    }
    
}

@end
