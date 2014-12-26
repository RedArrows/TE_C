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
    __weak IBOutlet UIView *mainBackView;
    
    CGFloat grandTotalWidth;
}


-(void)uiConfig{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    mainBackView.layer.cornerRadius = 5;
    mainBackView.layer.shadowOffset = CGSizeMake(1, 1);
    mainBackView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    mainBackView.layer.shadowOpacity = 0.8;
}

-(void)fillDataWithModel:(ListModel *)model{
    grandTotalWidth = 5;
    documentNOLabel.text = model.documentNO;
    agentNameLabel.text = model.agentName;
    directorNameLabel.text = model.director;
    priceLabel.text = [NSString stringWithFormat:@"%.0f",model.price];
    buyerLabel.text = model.buyer;
    sellerLabel.text = model.seller;
    dateLabel.text = model.date;
    
    for (NSString *title in model.mark) {
        [self addMarkTab:title];
        
    }
}


-(void)addMarkTab:(NSString *)title{
    
    CGRect markRect = [title boundingRectWithSize:CGSizeMake(1000, 15) options:0 attributes:[NSDictionary dictionaryWithObjectsAndKeys:MarkTabFont,NSFontAttributeName, nil] context:nil];
    CGRect preRect = CGRectMake(grandTotalWidth, 0, markRect.size.width+markTabBackView.frame.size.height, markTabBackView.frame.size.height);
    UILabel *markTabLabel = [[UILabel alloc]initWithFrame:preRect];
    markTabLabel.textAlignment = NSTextAlignmentCenter;
    markTabLabel.text = title;
    markTabLabel.layer.cornerRadius = preRect.size.height/2;
    markTabLabel.layer.backgroundColor = [UIColor orangeColor].CGColor;
    markTabLabel.font = MarkTabFont;
    markTabLabel.textColor = [UIColor whiteColor];
    [markTabBackView addSubview:markTabLabel];
    grandTotalWidth += preRect.size.width + 2;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
