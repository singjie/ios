//
//  SJTitleView.m
//  singjie.com
//
//  Created by Lee Sing Jie on 12/5/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import "SJTitleView.h"

@interface SJTitleView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SJTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    
    self.titleLabel.font = font;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    
    self.titleLabel.textColor = textColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(self.edgeInset.left, self.edgeInset.top, self.bounds.size.width - self.edgeInset.left - self.edgeInset.right, self.bounds.size.height - self.edgeInset.top - self.edgeInset.bottom);
}

@end
