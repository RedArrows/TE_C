//
//  ListItemTableViewCell.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/22.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "ListItemTableViewCell.h"

#define MarkTabFont  [UIFont systemFontOfSize:12]
#define MarkTabTextColor     [UIColor grayColor]

@implementation ListItemTableViewCell{
    
    __weak IBOutlet UILabel *documentNOLabel;
    __weak IBOutlet UIView *markTabBackView;
    
    __weak IBOutlet UILabel *agentNameLabel;
    __weak IBOutlet UILabel *directorNameLabel;
    __weak IBOutlet UILabel *priceLabel;
    __weak IBOutlet UILabel *buyerLabel;
    __weak IBOutlet UILabel *sellerLabel;
    __weak IBOutlet UILabel *dateLabel;
    
    
}


-(void)fillDataWithModel:(ListModel *)model{
    documentNOLabel.text = model.documentNO;
    agentNameLabel.text = model.agentName;
    directorNameLabel.text = model.director;
    priceLabel.text = [NSString stringWithFormat:@"%f",model.price];
    buyerLabel.text = model.buyer;
    sellerLabel.text = model.seller;
    dateLabel.text = model.date;
    
    
}

-(void)addMarkTab:(NSString *)title{
    
    UILabel *tabLabel = [[UILabel alloc]init];
    CGRect markRect = [title boundingRectWithSize:CGSizeMake(1000, 15) options:0 attributes:nil context:nil];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
