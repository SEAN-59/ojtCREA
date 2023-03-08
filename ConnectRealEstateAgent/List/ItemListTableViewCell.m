//
//  ItemListTableViewCell.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/08.
//

#import "ItemListTableViewCell.h"

@implementation ItemListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCellLbl:(NSString *)addr sell:(NSString *)sell income:(NSString *)income rat:(NSString *)rat {
    [self.addrLbl setText:addr];
    [self.sellLbl setText:sell];
    [self.incomeLbl setText:income];
    [self.ratLbl setText:rat];
    
}
@end
