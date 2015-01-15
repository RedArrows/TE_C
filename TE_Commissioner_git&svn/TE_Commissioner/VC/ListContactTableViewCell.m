//
//  ListContactTableViewCell.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/25.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "ListContactTableViewCell.h"
#import "PAAImageView.h"

@implementation ListContactTableViewCell{
    
    __weak IBOutlet UIView *headerPhotoBackView;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *phoneLabel;
    __weak IBOutlet UILabel *positionLabel;
    
    ContactPeople *_curPeople;
    PAAImageView *_photoView;
}

-(void)fillDataWithModel:(ContactPeople *)model{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _curPeople = model;
    switch (model.headerType) {
        case HEADER_buyer:{
            [_photoView setImage:[UIImage imageNamed:@"icon_client"]];
        }
            break;
        case HEADER_seller:{
            [_photoView setImage:[UIImage imageNamed:@"icon_owner"]];
        }
            break;
        case HEADER_photo:{
            [_photoView setImageURL:[NSURL URLWithString:model.imageUrl]];
        }
        default:
            break;
    }
    nameLabel.text = model.name;
    phoneLabel.text = model.phone;
    CGRect matchRect = [model.position boundingRectWithSize:CGSizeMake(1000, 15) options:0 attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName, nil] context:nil];
    [positionLabel setFrame:CGRectMake(positionLabel.frame.origin.x, positionLabel.frame.origin.y, matchRect.size.width+10, positionLabel.frame.size.height)];
    positionLabel.text = model.position;

}
- (IBAction)clickPhone:(id)sender {
    NSString* telString = [NSString stringWithFormat:@"tel://%@",_curPeople.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
    NSLog(@"拨打：%@",_curPeople.phone);
    
}

-(void)uiConfig{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _photoView = [[PAAImageView alloc]initWithFrame:headerPhotoBackView.bounds backgroundProgressColor:[UIColor lightGrayColor] progressColor:[UIColor whiteColor]];
    [headerPhotoBackView addSubview:_photoView];
    
    positionLabel.layer.cornerRadius = positionLabel.frame.size.height/2;
    positionLabel.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    positionLabel.textColor = [UIColor whiteColor];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
