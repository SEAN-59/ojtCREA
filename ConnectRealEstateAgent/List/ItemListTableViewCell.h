//
//  ItemListTableViewCell.h
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/08.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addrLbl;
@property (weak, nonatomic) IBOutlet UILabel *sellLbl;
@property (weak, nonatomic) IBOutlet UILabel *incomeLbl;
@property (weak, nonatomic) IBOutlet UILabel *ratLbl;

- (void) initCellLbl: (NSString*) addr sell: (NSString*) sell income: (NSString*) income rat: (NSString*) rat NS_SWIFT_NAME(initCellLbl(addr:sell:income:rat));
@end

NS_ASSUME_NONNULL_END
