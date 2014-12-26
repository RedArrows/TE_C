//
//  DateOrderSelect.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/24.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "DateOrderSelect.h"

#define SelectedColor UICOLOR_RGB_Alpha(0x228B22, 1)



@implementation DateOrderSelect{
    NSArray *_titleArray;
    UILabel *_showLabel;
    UILabel *_preLabel;
    DATEORDERMETHOD _curDateMethod;
    BOOL _menuOpened;
    CGRect _preRect;
    UIImageView *_imageView;
    UIView *_coverView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //直接对应枚举顺序，省得麻烦
        _titleArray = [NSArray arrayWithObjects:@"报单时间新-旧",@"报单时间旧-新", nil];
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        _menuOpened = NO;
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.layer.borderWidth = 1;
        
        _showLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2.5, frame.size.width-10, frame.size.height-5)];
        _showLabel.textColor = [UIColor darkGrayColor];
        _showLabel.font = [UIFont systemFontOfSize:13];
        _showLabel.userInteractionEnabled = YES;
        _showLabel.text = [_titleArray objectAtIndex:DATEORDER_new_old];
        _curDateMethod = DATEORDER_new_old;
        [self addSubview:_showLabel];
        
        UITapGestureRecognizer *_showLabelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShowLabel)];
        [_showLabel addGestureRecognizer:_showLabelTap];
        
        
        CGSize size = _showLabel.frame.size;
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(size.width-10, (size.height-5)/2, 10, 5)];
        _imageView.image = [UIImage imageNamed:@"arrow_down"];
        [_showLabel addSubview:_imageView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(5, frame.size.height, frame.size.width-10, 1)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        
        _preLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, frame.size.height+2.5, frame.size.width-10, frame.size.height-5)];
        _preLabel.textColor = [UIColor darkGrayColor];
        _preLabel.font = [UIFont systemFontOfSize:13];
        _preLabel.text = [_titleArray objectAtIndex:DATEORDER_old_new];
        _preLabel.userInteractionEnabled = YES;
        [self addSubview:_preLabel];
        UITapGestureRecognizer *_preLabelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPreLabel)];
        [_preLabel addGestureRecognizer:_preLabelTap];
        
        
    }
    return self;
}
-(void)tapShowLabel{
    if (!_coverView) {
        _coverView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 588)];
        [self.superview addSubview:_coverView];
        [self.superview insertSubview:_coverView belowSubview:self];
        _coverView.hidden = YES;
        UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeMenu)];
        [_coverView addGestureRecognizer:cancelTap];
    }
    
    if (_menuOpened) {//关闭菜单
        _curDateMethod = DATEORDER_new_old;
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height/2);
        } completion:^(BOOL finished) {
            [self resetCloseMenuState:DATEORDER_new_old];
            _menuOpened = NO;
            if (_callBackMethod) {
                _callBackMethod(_curDateMethod);
            }
        }];
    }else{//打开菜单
        [self resetOpenMenuState];
       [UIView animateWithDuration:0.3 animations:^{
           self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height*2);
       } completion:^(BOOL finished) {
           _menuOpened = YES;
           
       }];
    }
}
-(void)tapPreLabel{
    if (_menuOpened) {//关闭菜单
        _curDateMethod = DATEORDER_old_new;
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height/2);
        } completion:^(BOOL finished) {
            [self resetCloseMenuState:DATEORDER_old_new];
            _menuOpened = NO;
            if (_callBackMethod) {
                _callBackMethod(_curDateMethod);
            }
        }];
    }
}

-(void)resetOpenMenuState{
    _coverView.hidden = NO;
    _showLabel.text = [_titleArray objectAtIndex:DATEORDER_new_old];
    _imageView.image = [UIImage imageNamed:@"arrow_up"];
    if (_curDateMethod==DATEORDER_new_old) {
        _showLabel.textColor = SelectedColor;
    }else{
        _preLabel.textColor = SelectedColor;
    }
}

-(void)resetCloseMenuState:(DATEORDERMETHOD)selMethod{
    _coverView.hidden = YES;
    _imageView.image = [UIImage imageNamed:@"arrow_down"];
    _showLabel.text = [_titleArray objectAtIndex:selMethod];
    _showLabel.textColor = [UIColor darkGrayColor];
    _preLabel.textColor = [UIColor darkGrayColor];

}

-(void)closeMenu{
    if (_menuOpened) {//关闭菜单
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height/2);
        } completion:^(BOOL finished) {
            [self resetCloseMenuState:_curDateMethod];
            _menuOpened = NO;
        }];
    }
}


@end
