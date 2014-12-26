//
//  ListDetailTableViewCell.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/26.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "ListDetailTableViewCell.h"

#define FontSection [UIFont systemFontOfSize:13]
#define ColorSectionKey [UIColor darkGrayColor]
#define ColorSectionValue [UIColor lightGrayColor]



@implementation ListDetailTableViewCell{
    CGFloat _totalHeight;

}

-(void)fillDataWithDic:(NSDictionary *)dic{
    if (![dic objectForKey:@"content"]) {
        return;
    }
    NSArray *contentArray = [dic objectForKey:@"content"];
    for (id data in contentArray) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            [self configWithDic:data];
        }else if ([data isKindOfClass:[NSArray class]]){
            [self configWithArray:data];
        }
    }
    self.frame = CGRectMake(0, 0, 320, _totalHeight);
}

-(void)configWithDic:(NSDictionary *)dic{
    
    NSString *showText = [NSString stringWithFormat:@"%@：%@",dic[@"key"],dic[@"value"]];
    CGFloat addHeight = [self getHeight:showText];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, _totalHeight, 300, addHeight)];
    label.numberOfLines = 0;
    [self.contentView addSubview:label];
    _totalHeight += addHeight;
    label.attributedText = [self getAttrString:dic];
}

-(void)configWithArray:(NSArray *)arr{
    if (arr.count==1) {
        [self configWithDic:[arr objectAtIndex:0]];
        return;
    }
    CGFloat labelHeight = 18.0;
    CGFloat labelWidth = 300.0/arr.count;
    int i = 0;
    for (NSDictionary *dic in arr) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10+labelWidth*i, _totalHeight, labelWidth, labelHeight)];
        label.attributedText = [self getAttrString:dic];
        [self.contentView addSubview:label];
        i++;
    }
    _totalHeight += labelHeight;
    
    
}

-(NSAttributedString *)getAttrString:(NSDictionary *)dic{
    NSString *keyStr = [NSString stringWithFormat:@"%@：",dic[@"key"]];
    NSString *valueStr = dic[@"value"];
    NSString *showText = [NSString stringWithFormat:@"%@%@",keyStr,dic[@"value"]];
    
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:showText];
    [aString addAttribute:NSForegroundColorAttributeName value:ColorSectionKey range:NSMakeRange(0,keyStr.length)];
    [aString addAttribute:NSForegroundColorAttributeName value:ColorSectionValue range:NSMakeRange(keyStr.length,valueStr.length)];
    [aString addAttribute:NSFontAttributeName value:FontSection range:NSMakeRange(0, showText.length)];
    return aString;
}

-(CGFloat)getHeight:(NSString *)str{
    CGRect matchRect = [str boundingRectWithSize:CGSizeMake(300, 100) options:0 attributes:[NSDictionary dictionaryWithObjectsAndKeys:FontSection,NSFontAttributeName, nil] context:nil];
    return matchRect.size.height+5;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
