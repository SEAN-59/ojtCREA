//
//  ItemListTableView.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/07.
//

#import "ItemListTableView.h"

@implementation ItemListTableView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        // code is HERE
//        ItemListTableView* listTableView = [[ItemListTableView alloc] initWithCoder:<#(nonnull NSCoder *)#>]
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // code is HERE
    }
    return self;
}


@end

/*
 
 override init(frame: CGRect) {
 super.init(frame: frame)
 self.loadNib()
 }
 
 required init?(coder: NSCoder) {
 super.init(coder: coder)
 self.loadNib()
 }
 
 private func loadNib() {
 let identifier = String(describing: type(of: self))
 let nibs = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
 guard let nibView = nibs?.first as? UIView else { return }
 nibView.frame = self.bounds
 self.addSubview(nibView)
 }
 */
