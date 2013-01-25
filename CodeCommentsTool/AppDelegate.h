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

//header tab
#define HeaderTag               @"@header"
#define AbstractTag             @"@abstract"
#define AuthorTag               @"@author"
#define VersionTag              @"@version"
#define UpdatedTag              @"@updated"
#define DiscussionTag           @"@discussion"

//class tab
#define ClassTag                @"@class"
#define InterfaceTag            @"@interface"
#define ProtocolTag             @"@protocol"
#define CategoryTag             @"@category"

#define MethodTag               @"@method"
#define ParamTag                @"@param"
#define ResultTag               @"@result"

#define PropertyTag             @"@property"

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
    IBOutlet NSTabViewItem*     type3Item_;
    IBOutlet NSTabViewItem*     type4Item_;
    IBOutlet NSTabViewItem*     type5Item_;
    
    //typeTab1 header
    IBOutlet NSTextField*       fileName_;
    IBOutlet NSTextField*       fileAbstact_;
    IBOutlet NSTextField*       fileAuthor_;
    IBOutlet NSTextField*       fileVersion_;
    IBOutlet NSTextField*       fileUpdateTime_;
    IBOutlet NSTextField*       fileMoreDetails_;
    
    //typeTab2 class or protocol
    IBOutlet NSTextField*       LableText_;
    IBOutlet NSTextField*       className_;
    IBOutlet NSTextField*       inheriteClassName_;
    IBOutlet NSTextField*       classAbstact_;
    IBOutlet NSTextField*       classMoreDetails_;
    
    //typeTab3 category
    IBOutlet NSTextField*       categoryName_;
    IBOutlet NSTextField*       categoryClassName_;
    IBOutlet NSTextField*       categoryAbstact_;
    IBOutlet NSTextField*       categoryMoreDetails_;
    
    //typeTab4 category
    IBOutlet NSComboBox*        methodType_;
    IBOutlet NSTextField*       retType_;
    IBOutlet NSTextField*       retValueAbstact_;
    IBOutlet NSTextField*       methodName_;
    IBOutlet NSTextField*       methodAbstact_;
    
    IBOutlet NSTextField*       paramType1_;
    IBOutlet NSTextField*       paramName1_;
    IBOutlet NSTextField*       paramAbstact1_;
    IBOutlet NSTextField*       paramType2_;
    IBOutlet NSTextField*       paramNam2_;
    IBOutlet NSTextField*       paramAbstact2_;
    IBOutlet NSTextField*       paramType3_;
    IBOutlet NSTextField*       paramName3_;
    IBOutlet NSTextField*       paramAbstact3_;
    IBOutlet NSTextField*       paramType4_;
    IBOutlet NSTextField*       paramName4_;
    IBOutlet NSTextField*       paramAbstact4_;
    
    IBOutlet NSTextField*       methodMoreDetails_;
    
    //typeTab5 property
    IBOutlet NSTextField*       propertyType_;
    IBOutlet NSTextField*       propertyName_;
    IBOutlet NSTextField*       propertyAbstact_;
    IBOutlet NSTextField*       propertyMoreDetails_;
    
    //make document
    IBOutlet NSTextField*       makeDocumentTip_;
    
}
@property (assign) IBOutlet NSWindow *window;
-(IBAction)selectType:(id)sender;
-(IBAction)makeComment:(id)sender;

-(IBAction)subWinRet:(id)sender;
-(IBAction)commentCopy:(id)sender;

-(IBAction)produceDocument:(id)sender;
@end
