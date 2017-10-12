//
//  MoreCell.m
//  WXWeibo
//
//  Created by wei.chen on 14-9-17.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MoreCell.h"
#import "ThemeManager.h"

@implementation MoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _createView];
        [self themeChangeAction];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

- (void)_createView {
    _imgView = [[ThemeImageView alloc] initWithFrame:CGRectMake(7, 7, 30, 30)];
    
    _txLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(_imgView.right+5, 11, 200, 20)];
    _dtLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(180, 11, 95, 20)];
    
    _txLabel.font = [UIFont boldSystemFontOfSize:16];
    _txLabel.backgroundColor = [UIColor clearColor];
    _txLabel.colorName = @"More_Item_Text_color";
    
    _dtLabel.font = [UIFont boldSystemFontOfSize:15];
    _dtLabel.backgroundColor = [UIColor clearColor];
    _dtLabel.colorName = @"More_Item_Text_color";
    _dtLabel.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_txLabel];
    [self.contentView addSubview:_dtLabel];
}

- (void)themeChangeAction {
    self.backgroundColor = [[ThemeManager shareInstance] getThemeColor:@"More_Item_color"];
}

@end
