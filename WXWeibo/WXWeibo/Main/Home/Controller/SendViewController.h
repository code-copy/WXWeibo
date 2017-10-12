//
//  SendViewController.h
//  WXWeibo
//
//  Created by wei.chen on 15/4/14.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseController.h"

@interface SendViewController : BaseController<UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    
    UITextView *_textView;
    UIView *_editorView;
    
}

@end
