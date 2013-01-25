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
    [self selectType:nil];
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
#pragma mark update UI
-(void)clearAllString
{
    [fileName_ setStringValue:@""];
    [fileAbstact_ setStringValue:@""];
    [fileAuthor_ setStringValue:@""];
    [fileVersion_ setStringValue:@""];
    [fileUpdateTime_ setStringValue:@""];
    [fileMoreDetails_ setStringValue:@""];
    
    [className_ setStringValue:@""];
    [inheriteClassName_ setStringValue:@""];
    [classAbstact_ setStringValue:@""];
    [classMoreDetails_ setStringValue:@""];
    
    [categoryName_ setStringValue:@""];
    [categoryClassName_ setStringValue:@""];
    [categoryAbstact_ setStringValue:@""];
    [categoryMoreDetails_ setStringValue:@""];
}

#pragma mark-
#pragma mark main IBAction
-(IBAction)selectType:(id)sender
{
    int row = [typeRadio_ selectedRow];
    int column = [typeRadio_ selectedColumn];
    CommentTyped seletType = commentType_[row][column];
    
    [self clearAllString];
    switch (seletType) {
        case CTHeader:
            [typeTab_ selectTabViewItem:type1Item_];
            break;
        case CTClass:
            [LableText_ setStringValue:localized(@"类         名:")];
            [typeTab_ selectTabViewItem:type2Item_];
            break;
        case CTProtocol:
            [LableText_ setStringValue:localized(@"协   议    名:")];
            [typeTab_ selectTabViewItem:type2Item_];
            break;
        case CTCategory:
            [typeTab_ selectTabViewItem:type3Item_];
            break;
        case CTMethod:
            [methodType_ selectItemAtIndex:0];
            [typeTab_ selectTabViewItem:type4Item_];
            break;
        case CTProper:
            [typeTab_ selectTabViewItem:type5Item_];
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
        [self headerComment];
    }
    else if(seletType == CTClass)
    {
        [self ClassComment:NO];
    }
    else if(seletType == CTProtocol)
    {
        [self ClassComment:YES];
    }
    else if(seletType == CTCategory)
    {
        [self CategoryComment];
    }
    else if(seletType == CTMethod)
    {
        [self methodComment];
    }
    else if(seletType == CTProper)
    {
        [self properComment];
    }
}

-(void)properComment
{
    NSMutableDictionary* valueDic = [NSMutableDictionary dictionary];
    NSMutableArray* keys = [NSMutableArray array];
    
    NSString* propertyName = [propertyName_ stringValue];
    if (propertyName)
    {
        [keys addObject:PropertyTag];
        [valueDic setValue:propertyName forKey:PropertyTag];
    }
    NSString* propertyAbstact = [propertyAbstact_ stringValue];
    if (propertyAbstact)
    {
        [keys addObject:AbstractTag];
        [valueDic setValue:propertyAbstact forKey:AbstractTag];
    }
    NSString* propertyMoreDetails = [propertyMoreDetails_ stringValue];
    if (propertyMoreDetails)
    {
        [keys addObject:DiscussionTag];
        [valueDic setValue:propertyMoreDetails forKey:DiscussionTag];
    }
    NSString* comments = [self produceCommentByDic:valueDic withKeys:keys];
    NSString* codeDes = [self producePropertyCode:[propertyType_ stringValue] PropertyName:propertyName];
    
    [self showSubWinWithComment:[NSString stringWithFormat:@"%@%@",comments,codeDes]];
}

-(void)methodComment
{
    NSMutableDictionary* valueDic = [NSMutableDictionary dictionary];
    NSMutableArray* keys = [NSMutableArray array];
    
    NSString* methodName = [methodName_ stringValue];
    if (methodName && [methodName length]>0)
    {
        [keys addObject:MethodTag];
        [valueDic setValue:methodName forKey:MethodTag];
    }
    else
    {
        methodName = @"method";
        [keys addObject:MethodTag];
        [valueDic setValue:methodName forKey:MethodTag];
    }
    NSString* methodAbstact = [methodAbstact_ stringValue];
    if (methodAbstact)
    {
        [keys addObject:AbstractTag];
        [valueDic setValue:methodAbstact forKey:AbstractTag];
    }
    NSString* methodMoreDetails = [methodMoreDetails_ stringValue];
    if (methodMoreDetails)
    {
        [keys addObject:DiscussionTag];
        [valueDic setValue:methodMoreDetails forKey:DiscussionTag];
    }
    NSString* paramName1 = [paramName1_ stringValue];
    if (paramName1 && [paramName1 length]>0)
    {
        NSString* paramAbstact1 = [paramAbstact1_ stringValue];
        if (paramAbstact1 && [paramAbstact1 length]>0)
        {
            [keys addObject:ParamTag];
            [valueDic setValue:[NSString stringWithFormat:@"%@  %@",paramName1,paramAbstact1] forKey:ParamTag];
        }
    }
    NSString* paramName2 = [paramNam2_ stringValue];
    if (paramName2 && [paramName2 length]>0)
    {
        NSString* paramAbstact2 = [paramAbstact2_ stringValue];
        if (paramAbstact2 && [paramAbstact2 length]>0)
        {
            [keys addObject:ParamTag];
            [valueDic setValue:[NSString stringWithFormat:@"%@  %@",paramName2,paramAbstact2] forKey:ParamTag];
        }
    }
    NSString* paramName3 = [paramName3_ stringValue];
    if (paramName3 && [paramName3 length]>0)
    {
        NSString* paramAbstact3 = [paramAbstact3_ stringValue];
        if (paramAbstact3 && [paramAbstact3 length]>0)
        {
            [keys addObject:ParamTag];
            [valueDic setValue:[NSString stringWithFormat:@"%@  %@",paramName3,paramAbstact3] forKey:ParamTag];
        }
    }
    NSString* paramName4 = [paramName4_ stringValue];
    if (paramName4 && [paramName4 length]>0)
    {
        NSString* paramAbstact4 = [paramAbstact4_ stringValue];
        if (paramAbstact4 && [paramAbstact4 length]>0)
        {
            [keys addObject:ParamTag];
            [valueDic setValue:[NSString stringWithFormat:@"%@  %@",paramName4,paramAbstact4] forKey:ParamTag];
        }
    }
    NSString* retValueAbstact = [retValueAbstact_ stringValue];
    if (retValueAbstact)
    {
        [keys addObject:ResultTag];
        [valueDic setValue:retValueAbstact forKey:ResultTag];
    }
    NSString* comments = [self produceCommentByDic:valueDic withKeys:keys];
    
    //produce method code
    NSString* codeDes = nil;
    NSString* methodTypeValue = [methodType_ objectValueOfSelectedItem];
    if ([methodTypeValue length]==0) 
        methodTypeValue = @"-";
    
    NSString* retType = [retType_ stringValue];
    if ([retType length]==0)
        retType = @"id";
    
    codeDes = [NSString stringWithFormat:@"%@ (%@)",methodTypeValue,retType];
    NSString* paramType1 = [paramType1_ stringValue];
    if([paramType1 length]>0)
        codeDes = [codeDes stringByAppendingFormat:@"%@:(%@)%@",methodName,paramType1,paramName1];
    NSString* paramType2 = [paramType2_ stringValue];
    if([paramType2 length]>0)
        codeDes = [codeDes stringByAppendingFormat:@" %@:(%@)%@",paramName2,paramType2,paramName2];
    NSString* paramType3 = [paramType3_ stringValue];
    if([paramType3 length]>0)
        codeDes = [codeDes stringByAppendingFormat:@" %@:(%@)%@",paramName3,paramType3,paramName3];
    NSString* paramType4 = [paramType4_ stringValue];
    if([paramType4 length]>0)
        codeDes = [codeDes stringByAppendingFormat:@" %@:(%@)%@",paramName4,paramType4,paramName4];
    
    codeDes = [codeDes stringByAppendingString:@";"];
    [self showSubWinWithComment:[NSString stringWithFormat:@"%@%@",comments,codeDes]];
}

-(void)CategoryComment
{
    NSMutableDictionary* valueDic = [NSMutableDictionary dictionary];
    NSMutableArray* keys = [NSMutableArray array];
    
    NSString* categoryName = [categoryName_ stringValue];
    if (categoryName)
    {
        [keys addObject:CategoryTag];
        [valueDic setValue:categoryName forKey:CategoryTag];
    }
    NSString* categoryClassName = [categoryClassName_ stringValue];
    if (categoryClassName)
    {
        [keys addObject:CategoryTag];
        [valueDic setValue:categoryClassName forKey:CategoryTag];
    }
    NSString* categoryAbstact = [categoryAbstact_ stringValue];
    if (categoryAbstact)
    {
        [keys addObject:AbstractTag];
        [valueDic setValue:categoryAbstact forKey:AbstractTag];
    }
    NSString* categoryMoreDetails = [categoryMoreDetails_ stringValue];
    if (categoryMoreDetails)
    {
        [keys addObject:DiscussionTag];
        [valueDic setValue:categoryMoreDetails forKey:DiscussionTag];
    }
    NSString* comments = [self produceCommentByDic:valueDic withKeys:keys];
    NSString* codeDes = [self produceCategoryCode:categoryName className:categoryClassName];
    
    [self showSubWinWithComment:[NSString stringWithFormat:@"%@%@",comments,codeDes]];
}

-(void)ClassComment:(BOOL)isProtocol
{
    NSMutableDictionary* valueDic = [NSMutableDictionary dictionary];
    NSMutableArray* keys = [NSMutableArray array];
    NSString* className = [className_ stringValue];
    if (className)
    {
        if (isProtocol){
            [keys addObject:ProtocolTag];
            [valueDic setValue:className forKey:ProtocolTag];
        }
        else {
            [keys addObject:ClassTag];
            [valueDic setValue:className forKey:ClassTag];
        }
    }
    NSString* classAbstact = [classAbstact_ stringValue];
    if (classAbstact)
    {
        [keys addObject:AbstractTag];
        [valueDic setValue:classAbstact forKey:AbstractTag];
    }
    NSString* classMoreDetails = [classMoreDetails_ stringValue];
    if (classMoreDetails)
    {
        [keys addObject:DiscussionTag];
        [valueDic setValue:classMoreDetails forKey:DiscussionTag];  
    }
    
    NSString* comments = [self produceCommentByDic:valueDic withKeys:keys];
    NSString* inheriteClassName = [inheriteClassName_ stringValue];
    NSString* codeDes = [self produceClassCode:className inheriteClass:inheriteClassName isProtocol:isProtocol];
    
    [self showSubWinWithComment:[NSString stringWithFormat:@"%@%@",comments,codeDes]];
    
}

-(void)headerComment
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
            [makeDocumentTip_ setStringValue:localized(@"正在生成文档,请稍等...")];
            [self makeCommentDocument:path];
            [makeDocumentTip_ setStringValue:localized(@"文档生成完毕")];
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
    [[NSWorkspace sharedWorkspace] selectFile:[NSString stringWithFormat:@"%@/%@.html",path,fileName]inFileViewerRootedAtPath:path];
}

#pragma mark-
#pragma mark main function
-(NSString*)produceCommentByDic:(NSDictionary*)dic withKeys:(NSArray*)keys
{
    if ([dic count] == 0 || [keys count] == 0) 
        return @"";
    
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

-(NSString*)produceClassCode:(NSString*)className 
               inheriteClass:(NSString*)inheriteName 
                  isProtocol:(BOOL)isProtocol
{
    if (className == nil || [className length] == 0)
        return @"";
    
    if (inheriteName==nil || [inheriteName length]==0)
        inheriteName = @"NSObject";
    
    NSString* codeDes = @"";
    if (isProtocol)
    {
       codeDes = [NSString stringWithFormat:@"%@ %@ <%@>\n@end",ProtocolTag,className,inheriteName]; 
    }
    else
    {
       codeDes = [NSString stringWithFormat:@"%@ %@ : %@ {\n}\n@end",InterfaceTag,className,inheriteName]; 
    }
    return codeDes;
}

-(NSString*)produceCategoryCode:(NSString*)CategoryName className:(NSString*)className
{
    if (CategoryName == nil || [CategoryName length] == 0)
        return @"";
    
    if (className == nil || [className length] == 0)
        return @"";
    
    return [NSString stringWithFormat:@"%@ %@ (%@)\n@end",InterfaceTag,className,CategoryName];
}

-(NSString*)producePropertyCode:(NSString*)properType PropertyName:(NSString*)name
{
    if (properType == nil || [properType length] == 0)
        return @"";
    
    if (name == nil || [name length] == 0)
        return @"";
    
    NSArray* typeArray = [NSArray arrayWithObjects:@"bool",@"int",@"float",@"double",@"long",@"Integer",@"short",@"char",nil];
    
    BOOL isBasicType = NO;
    for (NSString* item in typeArray) 
    {
        if ([properType rangeOfString:item options:NSCaseInsensitiveSearch].location!=NSNotFound)
        {
            isBasicType = YES;
            break;
        }
    }
    
    if (isBasicType) 
    {
        return [NSString stringWithFormat:@"%@ (nonatomic) %@ %@;",PropertyTag,properType,name];
    }
    else
    {
        if ([properType rangeOfString:@"NSString" options:NSCaseInsensitiveSearch].location!=NSNotFound) 
        {
           return [NSString stringWithFormat:@"%@ (nonatomic,copy) NSString* %@;",PropertyTag,name]; 
        }
        else
        {
            return [NSString stringWithFormat:@"//if the type is delegate,please use assign replace retain.\n%@ (nonatomic,retain) %@ %@;",PropertyTag,properType,name];
        }
    }
}
@end
