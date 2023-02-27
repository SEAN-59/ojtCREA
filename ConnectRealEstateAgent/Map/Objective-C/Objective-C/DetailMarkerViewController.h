//
//  DetailMarkerViewController.h
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/24.
//

#import <UIKit/UIKit.h>
#import "DatabaseManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailMarkerViewController : UIViewController

@property (strong, nonatomic) DatabaseManager* dbManager;
@property NSString* address;
@property NSString* addrCd;

@property NSInteger count;


@property (weak, nonatomic) IBOutlet UILabel *addrTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *haveItemsLbl;
@property (weak, nonatomic) IBOutlet UILabel *averageSellLbl;
@property (weak, nonatomic) IBOutlet UILabel *averageRatLbl;
@property (weak, nonatomic) IBOutlet UIButton *addLikeBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

- (IBAction)tapAddLikeBtn:(UIButton *)sender;
- (IBAction)tapBackBtn:(UIButton *)sender;

-(void) openPage: (NSString*) address addrCd: (NSString*) addrCd;

@end

NS_ASSUME_NONNULL_END
