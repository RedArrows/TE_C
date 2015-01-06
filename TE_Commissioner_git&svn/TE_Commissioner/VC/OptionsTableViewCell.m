//
//  OptionsTableViewCell.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/18.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "OptionsTableViewCell.h"

@implementation OptionsTableViewCell{
    
    __weak IBOutlet UILabel *optionsTitle;
    __weak IBOutlet UIView *baseGrayView;
}

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)cancelClick:(id)sender {
    if([_delDelegate respondsToSelector:@selector(deleteOptionForType:)]){
        [_delDelegate deleteOptionForType:_myType];
    }
}

-(void)uiConfig{
    baseGrayView.layer.borderColor = [UIColor grayColor].CGColor;
    baseGrayView.layer.borderWidth = 1;
    
//    baseGrayView.layer.shadowOffset = CGSizeMake(1, 1);
//    baseGrayView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
//    baseGrayView.layer.shadowOpacity = 0.8;
}
-(void)fillDataWithModel:(OptionDetailModel *)model{
    optionsTitle.text = model.mainText;
    _myType = model.optionType;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
