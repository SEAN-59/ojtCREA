//
//  InfoMarkerViewController.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/24.
//

#import "InfoMarkerViewController.h"

@interface InfoMarkerViewController ()
-(void) tableViewInit;

@end

@implementation InfoMarkerViewController

NSString *cellIdentity = @"InfoMarkerTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableViewInit];
}

- (void)tableViewInit {
    [self.itemListTabelView setDelegate:self];
    [self.itemListTabelView setDataSource:self];
    
    self.cellNib = [UINib nibWithNibName:cellIdentity
                                  bundle:nil];
    
    [self.itemListTabelView registerNib:self.cellNib
                 forCellReuseIdentifier:cellIdentity];
    
}

//MARK: - IBACTION

- (IBAction)tapDismissBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)tapConnectbtn:(UIButton *)sender {
}


//MARK: - TABLEVIEW_DELEGATE

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//static InfoMarkerTableViewCell* extracted(UITableView * _Nonnull tableView) {
//    InfoMarkerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
//    return cell;
//}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
//    InfoMarkerTableViewCell* cell = extracted(tableView);
    
    
    InfoMarkerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity forIndexPath:indexPath];
    
    
    return cell;
}

@end
