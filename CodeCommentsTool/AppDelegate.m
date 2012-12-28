//
//  AppDelegate.m
//  CodeCommentsTool
//
//  Created by liping on 12-12-26.
//  Copyright (c) 2012年 万兴科技. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}

-(void)awakeFromNib
{
    commentType_[0][0] = CTHeader;
    commentType_[0][1] = CTClass;
    commentType_[0][2] = CTProtocol;
    commentType_[0][3] = CTCategory;
    commentType_[0][4] = CTMethod;
    commentType_[0][5] = CTProper;
    commentType_[0][6] = CTEnum;
    commentType_[1][0] = CTVariable;
    commentType_[1][1] = CTConst;
    commentType_[1][2] = CTStruct;
    commentType_[1][3] = CTUnion;
    commentType_[1][4] = CTCodeNav;
    commentType_[1][5] = CTFunctionPointer;
    commentType_[1][6] = CTOther;
}

#pragma mark-
#pragma mark window close delegate
- (BOOL)windowShouldClose:(id)sender
{
    return YES;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
	return YES;
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
	return NSTerminateNow;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}


#pragma mark-
#pragma mark main IBAction
-(IBAction)selectType:(id)sender
{
    int row = [typeRadio_ selectedRow];
    int column = [typeRadio_ selectedColumn];
    CommentTyped seletType = commentType_[row][column];
    
    switch (seletType) {
        case CTHeader:
            [typeTab_ selectTabViewItem:type1Item_];
            break;
        case CTClass:
            [typeTab_ selectTabViewItem:type2Item_];
            break;
        case CTProtocol:
            
            break;
        case CTCategory:
            
            break;
        case CTMethod:
            
            break;
        case CTProper:
            
            break;
        case CTEnum:
            
            break;
        case CTVariable:
            
            break;
        case CTConst:
            
            break;
        case CTStruct:
            
            break;
        case CTUnion:
            
            break;
        case CTCodeNav:
            
            break;
        case CTFunctionPointer:
            
            break;
        case CTOther:
            AlertTip(localized(@"亲，不用着急，其他的类型还在整理中..."));
            [typeRadio_ selectCellAtRow:0 column:0];
            break;
            
        default:
            break;
    }
}

-(IBAction)makeComment:(id)sender
{
    int row = [typeRadio_ selectedRow];
    int column = [typeRadio_ selectedColumn];
    CommentTyped seletType = commentType_[row][column];
    if (seletType == CTHeader) 
    {
        NSMutableDictionary* valueDic = [NSMutableDictionary dictionary];
        NSMutableArray* keys = [NSMutableArray array];
        
        NSString* fileName = [fileName_ stringValue];
        if (fileName)
        {
            [keys addObject:HeaderTag];
            [valueDic setValue:fileName forKey:HeaderTag];
        }
        NSString* fileAbstact = [fileAbstact_ stringValue];
        if (fileAbstact)
        {
            [keys addObject:AbstractTag];
            [valueDic setValue:fileAbstact forKey:AbstractTag];
        }
        NSString* fileAuthor = [fileAuthor_ stringValue];
        if (fileAuthor)
        {
            [keys addObject:AuthorTag];
            [valueDic setValue:fileAuthor forKey:AuthorTag];
        }
        NSString* fileVersion = [fileVersion_ stringValue];
        if (fileVersion)
        {
            [keys addObject:VersionTag];
            [valueDic setValue:fileVersion forKey:VersionTag];  
        }
        NSString* fileUpdateTime = [fileUpdateTime_ stringValue];
        if ([fileUpdateTime length]!=0)
        {
            [keys addObject:UpdatedTag];
            [valueDic setValue:fileUpdateTime forKey:UpdatedTag]; 
        }
        else 
        {
            [keys addObject:UpdatedTag];
            [valueDic setValue:[[[NSCalendarDate calendarDate] dateWithCalendarFormat:@"%Y-%m-%d" timeZone:nil] description] forKey:UpdatedTag];
        }
        NSString* fileMoreDetails = [fileMoreDetails_ stringValue];
        if (fileMoreDetails)
        {
            [keys addObject:DiscussionTag];
            [valueDic setValue:fileMoreDetails forKey:DiscussionTag];  
        }
        
        NSString* comments = [self produceCommentByDic:valueDic withKeys:keys];
        //NSLog(@"%@",comments);
        [self showSubWinWithComment:comments];
    }
    else
    {
        
    }
}

-(void)showSubWinWithComment:(NSString*)comment
{
    [commentTextView_ setString:comment];
    if ([showCommentWin_ isVisible] == NO)
    {
        [showCommentWin_ setIsVisible:YES];
    }
}

-(IBAction)subWinRet:(id)sender
{
    [commentTextView_ setString:@""];
    [showCommentWin_ setIsVisible:NO];
}

-(IBAction)commentCopy:(id)sender
{
    NSPasteboard *pasteBoard = [NSPasteboard generalPasteboard];
    [pasteBoard declareTypes:[NSArray arrayWithObjects:NSStringPboardType, nil] owner:nil];
    
    NSString* comments = [commentTextView_ string];
    if (comments && [comments length]>0) {
       [pasteBoard setString:comments forType:NSStringPboardType];
    }
}

-(IBAction)produceDocument:(id)sender
{
    NSOpenPanel * openPanel = [NSOpenPanel openPanel];
    [openPanel setMessage:@"Choose Directory to import:"];
    [openPanel setCanChooseDirectories:YES];
    
    void (^openPanelHandler)(NSInteger) = ^(NSInteger result)
    {
        if (result == NSOKButton)
        {
            if ([[openPanel URLs] count] == 0)
            {
                return;
            }
            
            NSMutableArray * files = [NSMutableArray array];
            [files setArray:[openPanel URLs]];
            
            [self performSelectorOnMainThread:@selector(getCodeDirectoryFromPanel:) withObject:files waitUntilDone:NO];
        }
	};
    [openPanel beginSheetModalForWindow:[self window] completionHandler:openPanelHandler];
    //openPanelHandler([openPanel runModal]);
}

-(void)getCodeDirectoryFromPanel:(NSArray*)filePaths
{
    if ([filePaths count]==0)
        return;
    
    for (int i=0; i<[filePaths count]; ++i) 
    {
        NSString* path = [[filePaths objectAtIndex:i] path];
        if ([path length]>0) {
            [self makeCommentDocument:path];
        }
    }
}

-(void)makeCommentDocument:(NSString*)path
{
    //mkdir -p headerDoc
    //find ./CodeCommentsTool/ -name \*.h -print | xargs headerdoc2html -o headerDoc
    //gatherheaderdoc headerDoc CodeCommentsTool.html
    
    NSString* fileName = [path lastPathComponent];
    NSString* mkdirCmd = [NSString stringWithFormat:@"mkdir -p %@",path];
    NSString* findCmd = [NSString stringWithFormat:@"find %@ -name \\*.h -print | xargs headerdoc2html -o %@",path,path];
    NSString* gatherCmd = [NSString stringWithFormat:@"gatherheaderdoc %@ %@.html",path,fileName];
    NSString* exectueCmd = [NSString stringWithFormat:@"%@\n%@\n%@\n",mkdirCmd,findCmd,gatherCmd];
    NSLog(@"%@",exectueCmd);
    int ret = system([exectueCmd UTF8String]);
    printf("%d",ret);
    [[NSWorkspace sharedWorkspace] selectFile:nil inFileViewerRootedAtPath:path];
}

#pragma mark-
#pragma mark main function
-(NSString*)produceCommentByDic:(NSDictionary*)dic withKeys:(NSArray*)keys
{
    if ([dic count] == 0 || [keys count] == 0) 
        return nil;
    
    NSString* comment = @"/*!\n";
    
    for (int i=0;i<[keys count];++i)
    {
        NSString* key = [keys objectAtIndex:i];
        NSString* value = [dic objectForKey:key];
        if (value) 
        {
            comment = [comment stringByAppendingFormat:@"%@  %@\n",key,value];
        }
    }
   
    comment = [comment stringByAppendingString:@"*/\n"];
    
    return comment;
}

@end
