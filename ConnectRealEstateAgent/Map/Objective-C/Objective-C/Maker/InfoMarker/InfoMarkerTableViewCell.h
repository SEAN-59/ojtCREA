//
//  InfoMarkerTableViewCell.h
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoMarkerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *sellLbl;
@property (weak, nonatomic) IBOutlet UILabel *incomeLbl;
@property (weak, nonatomic) IBOutlet UILabel *loanLbl;
@property (weak, nonatomic) IBOutlet UILabel *depositLbl;

@property (strong, nonatomic) NSString* itemCd;
@end

NS_ASSUME_NONNULL_END
