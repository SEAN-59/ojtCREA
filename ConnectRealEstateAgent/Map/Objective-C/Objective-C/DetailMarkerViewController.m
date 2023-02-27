//
//  DetailMarkerViewController.m
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/24.
//

#import "DetailMarkerViewController.h"

@interface DetailMarkerViewController () <DatabaseCallDelegate>
{
    NSMutableDictionary* dataDictionary;
}
-(void) toggleLoadingState;
-(void) averageData: (NSMutableDictionary*) data;
-(float) averageOfArray: (NSArray *) array;
@end

@implementation DetailMarkerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    dataDictionary = [[NSMutableDictionary alloc] init];
    self.dbManager = [[DatabaseManager alloc]init];
    [self.dbManager setDelegate:self];
    
}

- (void)openPage:(NSString *)address addrCd:(NSString *)addrCd {
    self.address = address;
    self.addrCd = addrCd;
    [self.dbManager readAreaDataItem:addrCd];
    
}

- (IBAction)tapBackBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)tapAddLikeBtn:(UIButton *)sender {
    
}

- (void)toggleLoadingState {
    if (self.loadingIndicator.isHidden) {
        [self.loadingIndicator setHidden:FALSE];
        [self.loadingIndicator stopAnimating];
        [self.backView setHidden:FALSE];
    } else {
        [self.loadingIndicator setHidden:TRUE];
        [self.loadingIndicator startAnimating];
        [self.backView setHidden:TRUE];
    }
    
}

- (void)averageData:(NSMutableDictionary *)data {
    NSMutableArray* arrayRat = [[NSMutableArray alloc] init];
    NSMutableArray* arraySell = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [data allKeys].count; i++) {
        double sell = [[[data objectForKey:[NSString stringWithFormat:@"%d", i]]objectForKey:@"sell"] doubleValue];
        double deposit = [[[data objectForKey:[NSString stringWithFormat:@"%d", i]]objectForKey:@"deposit"]doubleValue];
        double loan = [[[data objectForKey:[NSString stringWithFormat:@"%d", i]]objectForKey:@"loan"]doubleValue];
        double income = [[[data objectForKey:[NSString stringWithFormat:@"%d", i]]objectForKey:@"income"]doubleValue];
        
        NSNumber* resultRat = [NSNumber numberWithDouble: ((income * 12) / (sell - deposit - loan))* 100];
        
        
        [arrayRat addObject: resultRat];
        [arraySell addObject: [NSNumber numberWithDouble:sell]];
        
    }
    
    NSLog(@"%6.2f",[self averageOfArray:arrayRat]);
    self.averageRatLbl.text = [NSString stringWithFormat:@"%6.2f", [self averageOfArray: arrayRat]];
    self.averageSellLbl.text = [NSString stringWithFormat:@"%6.0f", [self averageOfArray: arraySell]];
    
    
    
}

- (float)averageOfArray:(NSArray *)array {
    float sum = 0;
    for (NSNumber *number in array) {
        sum += [number floatValue];
    }
    float average = sum / [array count];
    return average;
}

//MARK: - DATABASE_DELEGATE

- (void)successReadAreaItem:(BOOL)result data:(NSArray *)data {
    if (result) {
        
        self.count = data.count;
        for (int i = 0; i < data.count; i++) {
            [self.dbManager readItemDataMarker:data[i] number:i];
        }
    }
}

- (void)successReadItemMarker:(BOOL)result data:(NSDictionary *)data number:(int)number itemCd:(NSString *)itemCd {
    if (result) {
        NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[[data objectForKey:@"Invest"] objectForKey:@"sell"] forKey:@"sell"];
        [dict setObject:[[data objectForKey:@"Invest"] objectForKey:@"deposit"] forKey:@"deposit"];
        [dict setObject:[[data objectForKey:@"Invest"] objectForKey:@"loan"] forKey:@"loan"];
        [dict setObject:[[data objectForKey:@"Invest"] objectForKey:@"income"] forKey:@"income"];
        
        [dataDictionary setObject:dict forKey:[NSString stringWithFormat:@"%d", number]];
        
        if ([dataDictionary allKeys].count == self.count) {
            [self toggleLoadingState];
            [self averageData:dataDictionary];
            self.addrTitleLbl.text = [NSString stringWithFormat:@"%@",self.address];
            
        }
        
    }
}


@end
