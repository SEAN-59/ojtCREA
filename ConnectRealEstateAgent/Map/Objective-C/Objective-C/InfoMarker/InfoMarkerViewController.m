//
//  InfoMarkerViewController.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/24.
//

#import "InfoMarkerViewController.h"

@interface InfoMarkerViewController () <DatabaseCallDelegate>
-(void) tableViewInit;

@end

@implementation InfoMarkerViewController

NSString *cellIdentity = @"InfoMarkerTableViewCell";




- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableViewInit];
    self.dbManager = [[DatabaseManager alloc] init];
    [self.dbManager setDelegate:self];
}

- (void)tableViewInit {
    [self.itemListTabelView setDelegate:self];
    [self.itemListTabelView setDataSource:self];
    
    self.cellNib = [UINib nibWithNibName:cellIdentity
                                  bundle:nil];
    
    [self.itemListTabelView registerNib:self.cellNib
                 forCellReuseIdentifier:cellIdentity];
    
}

- (void)setAnyThings:(NSString *)address addrCd:(NSString *)addrCd {
    
    [self.dbManager readUserItemValueData:addrCd];
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
    InfoMarkerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity forIndexPath:indexPath];
    NSString* index = [NSString stringWithFormat:@"%li", (long)indexPath];
    cell.addressLbl = [[self.tableViewDataDictionary objectForKey:index] objectForKey:@"address"];
    cell.sellLbl = [[self.tableViewDataDictionary objectForKey:index] objectForKey:@"sell"];
    cell.incomeLbl = [[self.tableViewDataDictionary objectForKey:index] objectForKey:@"income"];
    cell.loanLbl = [[self.tableViewDataDictionary objectForKey:index] objectForKey:@"loan"];
    
    
    return cell;
}

//MARK: - DATABASE_DELEGATE

- (void)successReadUserItemValue:(BOOL)result data:(NSArray *)data {
    if (result) {
        self.cellCount = data.count;
        for (int i = 0 ; i <= data.count; i ++){
            [self.dbManager readItemData:data[i] number:i];
        }
    } else {
        
    }
}

- (void)successReadItem:(BOOL)result data:(NSDictionary *)data number:(NSInteger)number {
    
    if (result) {
        NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[[data objectForKey:@"Information"] objectForKey:@"oldAddress"] forKey:@"address"];
        [dict setObject:[[data objectForKey:@"Invest"] objectForKey:@"sell"] forKey:@"sell"];
        [dict setObject:[[data objectForKey:@"Invest"] objectForKey:@"income"] forKey:@"income"];
        [dict setObject:[[data objectForKey:@"Invest"] objectForKey:@"loan"] forKey:@"loan"];
        
        [self.tableViewDataDictionary setObject:dict forKey:[NSString stringWithFormat:@"%li", (long)number]];
        
        if ([self.tableViewDataDictionary allKeys].count == self.cellCount) {
            [self.itemListTabelView reloadData];
            [self.backView setHidden:TRUE];
            [self.loadingIndicator stopAnimating];
            [self.loadingIndicator setHidden:TRUE];
            self.addrTitleLbl.text = self.address;
        }
        
    }
    
}

@end
