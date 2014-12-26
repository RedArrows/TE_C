//
//  ListDetailMidMenu.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/25.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "ListDetailMidMenu.h"

@implementation ListDetailMidMenu{
    NSArray *_titleArray;
    NSMutableArray *_btnArray;
    NSMutableArray *_dataArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y,320, 40)];
    if (self) {
        _titleArray = [NSArray arrayWithObjects:@"合同信息",@"买方信息",@"卖方信息",@"房源信息",@"批贷信息", nil];
        _btnArray = [[NSMutableArray alloc]init];
        _dataArray = [[NSMutableArray alloc]init];
        [self configBtn];
        
        
    }
    return self;
}

-(void)configBtn{
    [_btnArray removeAllObjects];
    CGFloat btnWidth = 320.0/_titleArray.count;
    CGFloat btnHeight = 40;
    CGFloat cumulation = 0;
    
    int tag = 0;
    
    for (NSString *title in _titleArray) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"white_block"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateSelected];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setFrame:CGRectMake(cumulation, 0, btnWidth, btnHeight)];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = tag++;
        cumulation += btnWidth;
        [self addSubview:btn];
        [_btnArray addObject:btn];
        
        
    }
    
}
-(void)clickBtn:(UIButton *)btn{
    [_btnArray makeObjectsPerformSelector:@selector(setSelected:) withObject:[NSNumber numberWithBool:NO]];
    [btn setSelected:YES];
    if (_menuDelegate&&[_menuDelegate respondsToSelector:@selector(listDetailMenuDidSelected:model:)]&&_dataArray.count) {
        [_menuDelegate listDetailMenuDidSelected:btn.tag model:[_dataArray objectAtIndex:btn.tag]];
    }
}

-(void)setSelected:(NSInteger)index{
    if (index>_btnArray.count-1) {
        return;
    }
    [self clickBtn:[_btnArray objectAtIndex:index]];
}



-(void)updateWithTabArray:(NSArray *)tabArray{
    if (!tabArray) {
        return;
    }
    [_dataArray removeAllObjects];
    NSMutableArray *newTitleArray = [[NSMutableArray alloc]init];
    for (ListDetailModel *model in tabArray) {
        [newTitleArray addObject:model.title];
        [_dataArray addObject:model];
    }
    if (![newTitleArray isEqual:_titleArray]) {
        _titleArray = newTitleArray;
        [self configBtn];
    }
}

@end
