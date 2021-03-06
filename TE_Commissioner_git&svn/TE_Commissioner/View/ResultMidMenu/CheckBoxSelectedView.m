//
//  CheckBoxSelectedView.m
//  TE_Commissioner
//
//  Created by 时瑶 on 15/1/14.
//  Copyright (c) 2015年 shiyao. All rights reserved.
//

#import "CheckBoxSelectedView.h"

@implementation CheckBoxSelectedView{
    NSArray *_titleArray;
    NSMutableArray *_boxArray;
    NSMutableArray *_labelArray;
    
    NSInteger _curSelectIndex;
    
    NSInteger _selectedViewType;
    
    UIColor *_selectedColor;
    UIColor *_normalColor;
}

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray viewType:(SelectedType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectedViewType = type;
        _titleArray = [NSArray arrayWithArray:titleArray];
        _boxArray = [[NSMutableArray alloc]init];
        _labelArray = [[NSMutableArray alloc] init];
        _selectedArray = [[NSMutableArray alloc]init];
        _curSelectIndex = 10086;
        
        if (type == SelectedType_CheckBox) {
            [self configTypeOne];
        }
        if (type == SelectedType_TwoSelectOne) {
            [self configTypeTwo];
        }
        
    }
    return self;
}
-(void)configTypeTwo{
    
    _selectedColor = UICOLOR_RGB_Alpha(0x39ac6a, 1);
    _normalColor = UICOLOR_RGB_Alpha(0x969696, 1);
    
    CGFloat btnHeight = 35;
    CGFloat btnWidth = 120;
    CGFloat btnHeightGas = 10;
    
    CGFloat heightSpace = 10;
    CGFloat widthSpace = (320.0-2*btnWidth)/3;
    
    CGFloat boxWidth = 16;
    CGFloat boxHeight = 12;
    CGFloat boxHeightGap = (btnHeight-boxHeight)/2;
    
    //    checkBox_empty@2x
    CGFloat curHeight = heightSpace;
    
    
    for (int i = 0; i<_titleArray.count; i++) {
        if (i%2==0) {
            curHeight += btnHeight +btnHeightGas;
        }
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(widthSpace+(i%2)*(widthSpace+btnWidth), heightSpace+(i/2)*(heightSpace+btnHeight), btnWidth, btnHeight)];
        label.tag = i;
        label.text = [NSString stringWithFormat:@"     %@",[_titleArray objectAtIndex:i]];
        label.layer.cornerRadius = 8.0;
        label.layer.borderColor = _normalColor.CGColor;
        label.layer.borderWidth = 2.0;
        label.textColor = _normalColor;
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTwoTap:)];
        [label addGestureRecognizer:tap];
        
        UIImageView *checkBox = [[UIImageView alloc]initWithFrame:CGRectMake(5, boxHeightGap, boxWidth, boxHeight)];
        [checkBox setImage:[UIImage imageNamed:@"mark_yes"]];
        [label addSubview:checkBox];
        [_boxArray addObject:checkBox];
        [_labelArray addObject:label];
        [self addSubview:label];
        
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 320, curHeight);
}

-(void)labelTwoTap:(UITapGestureRecognizer *)tap{
    [self setSelectedView:tap.view.tag];
    
}
-(void)setSelectedViewWithArray:(NSArray *)array offset:(NSInteger)offset{
    for (NSString *numStr in array) {
        [self setSelectedView:numStr.integerValue+offset];
    }
}

-(void)setSelectedView:(NSInteger)tag{
    if (_selectedViewType == SelectedType_CheckBox) {
        if ([_selectedArray containsObject:[NSString stringWithFormat:@"%ld",(long)tag]]){
            [_selectedArray removeObject:[NSString stringWithFormat:@"%ld",(long)tag]];
            [[_boxArray objectAtIndex:tag] performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"checkBox_empty"]];
        }else{
            [_selectedArray addObject:[NSString stringWithFormat:@"%ld",(long)tag]];
            [[_boxArray objectAtIndex:tag] performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"checkBox_selected"] afterDelay:0];
        }
        _curSelectIndex = tag;
        _callBack(_curSelectIndex,_selectedArray);
    }else{
        if (tag == _curSelectIndex) {
            return;
        }
        _curSelectIndex = tag;
        _selectedArray = [NSMutableArray arrayWithObject:[NSString stringWithFormat:@"%ld",(long)tag]];
        for (UILabel *label in _labelArray) {
            if (label.tag == tag) {
                label.textColor = _selectedColor;
                label.layer.borderColor = _selectedColor.CGColor;
                ((UIImageView *)[_boxArray objectAtIndex:label.tag]).hidden = NO;
//                [[_boxArray objectAtIndex:label.tag] performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:NO]];
            }else{
                label.textColor = _normalColor;
                label.layer.borderColor = _normalColor.CGColor;
                [[_boxArray objectAtIndex:label.tag] performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES]];
            }
        }
        _callBack(_curSelectIndex,_selectedArray);
    }
    
}


-(void)configTypeOne{
    CGFloat btnHeight = 25;
    CGFloat btnWidth = 120;
    CGFloat btnHeightGas = 10;
    
    CGFloat heightSpace = 5;
    CGFloat widthSpace = (320.0-2*btnWidth)/3;
    
    CGFloat boxWidth = 15;
    CGFloat boxHeightGap = (btnHeight-boxWidth)/2;
    
//    checkBox_empty@2x
    CGFloat curHeight = heightSpace;
    
    
        for (int i = 0; i<_titleArray.count; i++) {
            if (i%2==0) {
                curHeight += btnHeight +btnHeightGas;
            }
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(widthSpace+(i%2)*(widthSpace+btnWidth), heightSpace+(i/2)*(heightSpace+btnHeight), btnWidth, btnHeight)];
            label.tag = i;
            label.text = [NSString stringWithFormat:@"    %@",[_titleArray objectAtIndex:i]];
            label.textColor = UICOLOR_RGB_Alpha(0x5f5f5f, 1);
            label.userInteractionEnabled = YES;
            label.font = [UIFont systemFontOfSize:15.0];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelOneTap:)];
            [label addGestureRecognizer:tap];
            
            UIImageView *checkBox = [[UIImageView alloc]initWithFrame:CGRectMake(0, boxHeightGap, boxWidth, boxWidth)];
            [checkBox setImage:[UIImage imageNamed:@"checkBox_empty"]];
            [label addSubview:checkBox];
            [_boxArray addObject:checkBox];
            [self addSubview:label];
        }
        
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 320, curHeight);
}

-(void)labelOneTap:(UITapGestureRecognizer *)tap{
    [self setSelectedView:tap.view.tag];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
