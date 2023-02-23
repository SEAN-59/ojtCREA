//
//  MapView.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/22.
//

#import "MapView.h"


@interface MapView ()
-(void) customInit;
-(void) layout;
@end


@implementation MapView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    [[NSBundle mainBundle] loadNibNamed:@"MainMapView" owner:self options:nil];
//    NMFMapView* naverMapView = [[NMFMapView alloc] initWithFrame:self.frame];
    NMFMapView* naverMapView = [[NMFMapView alloc] initWithFrame:self.contentView.frame];
    
    [self addSubview: self.contentView];
    self.contentView.frame = self.bounds;

    [self.contentView addSubview:naverMapView];
    naverMapView.frame = self.contentView.bounds;
    

}

- (void)layout {
    
}


@end
