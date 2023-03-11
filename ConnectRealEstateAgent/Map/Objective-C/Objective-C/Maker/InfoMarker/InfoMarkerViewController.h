//
//  InfoMarkerViewController.h
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/24.
//

#import <UIKit/UIKit.h>

#import "InfoMarkerTableViewCell.h"
#import "DatabaseManager.h"


NS_ASSUME_NONNULL_BEGIN

@interface InfoMarkerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) DatabaseManager* dbManager;

@property NSString* address;
@property NSString* addrCd;
@property NSString* cellIdentity;
@property NSInteger cellCount;
@property UINib* cellNib;


@property (weak, nonatomic) IBOutlet UILabel *addrTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *likePersonLbl;
@property (weak, nonatomic) IBOutlet UITableView *itemListTabelView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;


- (IBAction)tapConnectbtn:(UIButton *)sender;

- (IBAction)tapDismissBtn:(UIButton *)sender;


- (void) setAnyThings: (NSString*) address addrCd: (NSString*) addrCd;



@end

NS_ASSUME_NONNULL_END
