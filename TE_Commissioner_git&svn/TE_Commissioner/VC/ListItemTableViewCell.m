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
    
    
    
    CGFloat grandTotalWidth;
}


-(void)uiConfig{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    mainBackView.layer.cornerRadius = 5;
    mainBackView.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    mainBackView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    mainBackView.layer.shadowOpacity = 0.8;
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
    
    for (NSString *title in model.mark) {
        [self addMarkTab:title];
        
    }
}


-(void)addMarkTab:(NSString *)title{
    
    UIColor *backColor = [UIColor blackColor];
    UIColor *titleColor = [UIColor whiteColor];
    
    if([title hasPrefix:@"全款"]){
        backColor = [UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:1];
    }else if([title isEqualToString:@"组合贷.市属.垫资"]||[title isEqualToString:@"补按揭.市属"]||[title hasPrefix:@"公积金.市属"]){
        backColor = [UIColor colorWithRed:147/255.0 green:124/255.0 blue:78/255.0 alpha:1];
    }else if([title isEqualToString:@"商业贷款"]||[title isEqualToString:@"商贷.赎楼"]||[title isEqualToString:@"商贷.垫资"]||[title isEqualToString:@"补按揭.商贷"]){
        backColor = [UIColor colorWithRed:62/255.0 green:98/255.0 blue:127/255.0 alpha:1];
    }else if([title isEqualToString:@"组合贷.市属"]||[title isEqualToString:@"组合贷.市属.赎楼"]){
        backColor = [UIColor colorWithRed:208/255.0 green:169/255.0 blue:91/255.0 alpha:1];
    }else if([title hasPrefix:@"公积金.国管"]||[title isEqualToString:@"补按揭.国管"]||[title isEqualToString:@"组合贷.国管.垫资"]){
        backColor = [UIColor colorWithRed:126/255.0 green:51/255.0 blue:88/255.0 alpha:1];
    }else if([title isEqualToString:@"组合贷.国管"]||[title isEqualToString:@"组合贷.国管.赎楼"]){
        backColor = [UIColor colorWithRed:163/255.0 green:67/255.0 blue:115/255.0 alpha:1];
    }else if([title isEqualToString:@"公积金.中直"]){
        backColor = [UIColor colorWithRed:152/255.0 green:27/255.0 blue:183/255.0 alpha:1];
    }else if([title isEqualToString:@"连环单"]){
        backColor = [UIColor colorWithRed:190/255.0 green:14/255.0 blue:29/255.0 alpha:1];
    }else if([title isEqualToString:@"补按揭"]){
        backColor = [UIColor colorWithRed:115/255.0 green:204/255.0 blue:211/255.0 alpha:1];
    }else if([title isEqualToString:@"代购"]){
        backColor = [UIColor colorWithRed:80/255.0 green:136/255.0 blue:78/255.0 alpha:1];
    }else if([title isEqualToString:@"4+3"]){
        backColor = [UIColor colorWithRed:211/255.0 green:187/255.0 blue:50/255.0 alpha:1];
    }else if([title isEqualToString:@"时效单"]){
        backColor = [UIColor colorWithRed:184/255.0 green:15/255.0 blue:93/255.0 alpha:1];
    }else if([title isEqualToString:@"挂起"]){
        backColor = [UIColor whiteColor];
        titleColor = [UIColor colorWithRed:252/255.0 green:15/255.0 blue:34/255.0 alpha:1];
    }
    
    CGRect markRect = [title boundingRectWithSize:CGSizeMake(1000, 15) options:0 attributes:[NSDictionary dictionaryWithObjectsAndKeys:MarkTabFont,NSFontAttributeName, nil] context:nil];
    CGRect preRect = CGRectMake(grandTotalWidth, 0, markRect.size.width+markTabBackView.frame.size.height, markTabBackView.frame.size.height);
    UILabel *markTabLabel = [[UILabel alloc]initWithFrame:preRect];
    markTabLabel.textAlignment = NSTextAlignmentCenter;
    markTabLabel.text = title;
    markTabLabel.layer.cornerRadius = preRect.size.height/2;
    markTabLabel.layer.backgroundColor = backColor.CGColor;
    markTabLabel.font = MarkTabFont;
    markTabLabel.textColor = titleColor;
    if ([title isEqualToString:@"挂起"]) {
        markTabLabel.layer.borderColor = titleColor.CGColor;
        markTabLabel.layer.borderWidth = 1.0;
    }
    
    
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
