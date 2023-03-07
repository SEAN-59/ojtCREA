//
//  AddressSearchView.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/06.
//

#import "AddressSearchView.h"
@interface AddressSearchView ()
-(void) loadNib;
@end

@implementation AddressSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self loadNib];
        
        

    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if(self) {
        [self loadNib];
    }
    return self;
}

- (void)loadNib {
    UIView* nibView = [[[NSBundle mainBundle] loadNibNamed:@"AddressSearchView"
                                                    owner:nil
                                                  options:nil]firstObject];
    nibView.frame = self.bounds;
    
    
//    UINib* nib = [UINib bu]
    
//    NSArray* arrayNib = [[NSBundle mainBundle] loadNibNamed:@"AddressSearchView" owner:nil options:nil];
        [self addSubview:nibView];
    
}



//- (void)awakeFromNib {
//    [super awakeFromNib];
////    [self initilize];
//}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    [super initWithFrame:rect];
//
//}



@end
