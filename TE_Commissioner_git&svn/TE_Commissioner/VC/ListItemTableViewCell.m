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
#define SelectedColor UICOLOR_RGB_Alpha(0x228B22, 1)


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
    __weak IBOutlet UILabel *toDoNumLabel;
    
    NSMutableArray *_tabArray;
    
    CGFloat grandTotalWidth;
}


-(void)uiConfig{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    mainBackView.layer.cornerRadius = 5;
    mainBackView.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    mainBackView.layer.shadowColor = UICOLOR_RGB_Alpha(0xcccccc, 1).CGColor;
    mainBackView.layer.shadowOpacity = 0.8;
    
    _tabArray = [[NSMutableArray alloc]init];
}

-(void)fillDataWithModel:(ListModel *)model isShowToDo:(BOOL)isShow{
    grandTotalWidth = 5;
    documentNOLabel.text = model.documentNO;
    agentNameLabel.text = model.agentName;
    directorNameLabel.text = model.director;
    priceLabel.text = [NSString stringWithFormat:@"%.0f",model.price];
    buyerLabel.text = model.buyer;
    sellerLabel.text = model.seller;
    dateLabel.text = model.date;
    if (isShow) {
        if (model.toDoNum) {
            toDoNumLabel.backgroundColor = SelectedColor;
        }else{
            toDoNumLabel.backgroundColor = [UIColor lightGrayColor];
        }
        toDoNumLabel.text = [NSString stringWithFormat:@"待办：%li",model.toDoNum];
        toDoNumLabel.hidden = NO;
    }else{
        toDoNumLabel.hidden = YES;
    }
    for (UIView *lv in _tabArray) {
        [lv removeFromSuperview];
    }
    [_tabArray removeAllObjects];
    
    for (NSString *title in model.mark) {
        [self addMarkTab:title];
        
    }
    
    
}


-(void)addMarkTab:(NSString *)title{
    
    UIColor *backColor = [UIColor blackColor];
    UIColor *titleColor = [UIColor whiteColor];
    
    if([title hasPrefix:@"全款"]){
        backColor = UICOLOR_RGB_Alpha(0xa4a4a4, 1);
    }else if([title isEqualToString:@"组合贷.市属.垫资"]||[title isEqualToString:@"补按揭.市属"]||[title hasPrefix:@"公积金.市属"]){
        backColor = UICOLOR_RGB_Alpha(0x947d4b, 1);
    }else if([title isEqualToString:@"商业贷款"]||[title isEqualToString:@"商贷.赎楼"]||[title isEqualToString:@"商贷.垫资"]||[title isEqualToString:@"补按揭.商贷"]){
        backColor = UICOLOR_RGB_Alpha(0x3c6180, 1);
    }else if([title isEqualToString:@"组合贷.市属"]||[title isEqualToString:@"组合贷.市属.赎楼"]){
        backColor = UICOLOR_RGB_Alpha(0xd2ab54, 1);
    }else if([title hasPrefix:@"公积金.国管"]||[title isEqualToString:@"补按揭.国管"]||[title isEqualToString:@"组合贷.国管.垫资"]){
        backColor = UICOLOR_RGB_Alpha(0x865c71, 1);
    }else if([title isEqualToString:@"组合贷.国管"]||[title isEqualToString:@"组合贷.国管.赎楼"]){
        backColor = UICOLOR_RGB_Alpha(0xaf6d8e, 1);
    }else if([title isEqualToString:@"公积金.中直"]){
        backColor = UICOLOR_RGB_Alpha(0x9a00bb, 1);
    }else if([title isEqualToString:@"连环单"]){
        backColor = UICOLOR_RGB_Alpha(0xca0814, 1);
    }else if([title isEqualToString:@"补按揭"]){
        backColor = UICOLOR_RGB_Alpha(0xca0814, 1);
    }else if([title isEqualToString:@"代购"]){
        backColor = UICOLOR_RGB_Alpha(0xca0814, 1);
    }else if([title isEqualToString:@"4+3"]){
        backColor = UICOLOR_RGB_Alpha(0xca0814, 1);
    }else if([title isEqualToString:@"时效单"]){
        backColor = UICOLOR_RGB_Alpha(0xba015c, 1);
    }else if([title isEqualToString:@"挂起"]){
        backColor = [UIColor whiteColor];
        titleColor = UICOLOR_RGB_Alpha(0xff0000, 1);
    }else if([title isEqualToString:@"再次办理"]){
        backColor = UICOLOR_RGB_Alpha(0x909090, 1);
    }
    
    CGRect markRect = [title boundingRectWithSize:CGSizeMake(1000, 15) options:0 attributes:[NSDictionary dictionaryWithObjectsAndKeys:MarkTabFont,NSFontAttributeName, nil] context:nil];
    CGRect preRect = CGRectMake(grandTotalWidth, 0, markRect.size.width+markTabBackView.frame.size.height, markTabBackView.frame.size.height);
    UILabel *markTabLabel = [[UILabel alloc]initWithFrame:preRect];
    markTabLabel.textAlignment = NSTextAlignmentCenter;
    markTabLabel.text = title;
    markTabLabel.layer.cornerRadius = preRect.size.height/2-2;
    markTabLabel.layer.backgroundColor = backColor.CGColor;
    markTabLabel.font = MarkTabFont;
    markTabLabel.textColor = titleColor;
    if ([title isEqualToString:@"挂起"]) {
        markTabLabel.layer.borderColor = titleColor.CGColor;
        markTabLabel.layer.borderWidth = 1.0;
    }
    [_tabArray addObject:markTabLabel];
    
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
