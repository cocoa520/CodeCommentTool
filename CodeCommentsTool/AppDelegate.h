//
//  AppDelegate.h
//  CodeCommentsTool
//
//  Created by liping on 12-12-26.
//  Copyright (c) 2012年 万兴科技. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define localized(X)            NSLocalizedString(X,nil)
#define AlertTip(str)           NSRunAlertPanel(@"info", str, @"ok", @"cancel", nil)

#define HeaderTag               @"@header"
#define AbstractTag             @"@abstract"
#define AuthorTag               @"@author"
#define VersionTag              @"@version"
#define UpdatedTag              @"@updated"
#define DiscussionTag           @"@discussion"


typedef enum CommentTyped_
{
    CTHeader = 0,
    CTClass,
    CTProtocol,
    CTCategory,
    CTMethod,
    CTProper,
    CTEnum,
    CTVariable,
    CTConst,
    CTStruct,
    CTUnion,
    CTCodeNav,
    CTFunctionPointer,
    CTOther
} CommentTyped;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    int                         commentType_[2][7];
    IBOutlet NSMatrix*          typeRadio_;
    
    //subwindow
    IBOutlet NSWindow*          showCommentWin_;
    IBOutlet NSTextView*        commentTextView_;
    
    //tabview
    IBOutlet NSTabView*         typeTab_;
    IBOutlet NSTabViewItem*     type1Item_;
    IBOutlet NSTabViewItem*     type2Item_;
    
    //typeTab1
    IBOutlet NSTextField*       fileName_;
    IBOutlet NSTextField*       fileAbstact_;
    IBOutlet NSTextField*       fileAuthor_;
    IBOutlet NSTextField*       fileVersion_;
    IBOutlet NSTextField*       fileUpdateTime_;
    IBOutlet NSTextField*       fileMoreDetails_;
    
    //typeTab4
    
    
}
@property (assign) IBOutlet NSWindow *window;
-(IBAction)selectType:(id)sender;
-(IBAction)makeComment:(id)sender;

-(IBAction)subWinRet:(id)sender;
-(IBAction)commentCopy:(id)sender;

-(IBAction)produceDocument:(id)sender;
@end
