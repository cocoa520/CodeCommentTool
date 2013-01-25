/*!
 @header 这里的信息应该与该源代码文件的名字一致
 @abstract 关于这个源代码文件的一些基本描述
 @author Kevin Wu (作者信息)
 @version 1.00 2012/01/20 Creation (此文档的版本信息)
 @updated 2012/12/27
 */

#import <Foundation/Foundation.h>

/*!
 @enum
 @abstract 关于这个enum的一些基本信息
 @constant HelloDocEnumDocDemoTagNumberPopupView PopupView的Tag
 @constant HelloDocEnumDocDemoTagNumberOKButton OK按钮的Tag
 */
typedef enum HelloDocEnumDocDemo_{
    HelloDocEnumDocDemoTagNumberPopupView = 100,
    HelloDocEnumDocDemoTagNumberOKButton,
}HelloDocEnumDocDemo;

/*!
 @typedef TypedefdEnum
 @abstract Abstract for this API.
 @constant aCFCompareLessThan Description of first constant.
 @constant aCFCompareEqualTo Description of second constant.
 @constant aCFCompareGreaterThan Description of third constant.
 @discussion Discussion that applies to the entire typedef'd enum.
 Lorem ipsum....
 */
typedef enum {
    aCFCompareLessThan = -1,
    aCFCompareEqualTo = 0,
    aCFCompareGreaterThan = 1,
} TypedefdEnum;


/*!
 @const kCFTypeArrayCallBacks
 @abstract Predefined CFArrayCallBacks structure containing a set of callbacks appropriate...
 @discussion Extended discussion goes here.
 Lorem ipsum....
 */
const CFArrayCallBacks kCFTypeArrayCallBacks;

/*!
 @var we_are_root
 @abstract Tells whether this device is the root power domain
 @discussion TRUE if this device is the root power domain.
 For more information on power domains....
 */

bool we_are_root;

/*!
 @struct TableOrigin
 @abstract Locates lower-left corner of table in screen coordinates.
 @field x Point on horizontal axis.
 @field y Point on vertical axis
 @discussion Extended discussion goes here.
 Lorem ipsum....
 */
struct TableOrigin {
    int x;
    int y;
};

/*!
 union TableOrigin2
 @abstract Locates lower-left corner of table in screen coordinates.
 @field x Point on horizontal axis.
 @field y Point on vertical axis
 @discussion Extended discussion goes here.
 Lorem ipsum....
 */
union TableOrigin2 {
    int x;
    int y;
};

/*!
 @typedef TypedefdSimpleStruct
 @abstract Abstract for this API.
 @field firstField Description of first field
 @field secondField Description of second field
 @discussion Discussion that applies to the entire typedef'd simple struct.
 Lorem ipsum....
 */
typedef struct _structTag {
    short firstField;
    unsigned long secondField;
} TypedefdSimpleStruct;

/*!
 @typedef simpleCallback
 @abstract Abstract for this API.
 @param inFirstParameter Description of the callback's first parameter.
 @param outSecondParameter Description of the callback's second parameter.
 @result Returns what it can when it is possible to do so.
 @discussion Discussion that applies to the entire callback.
 Lorem ipsum...
 */
typedef long (*simpleCallback)(short inFirstParameter, unsigned long long *outSecondParameter);


/*!
 @typedef TypedefdStructWithCallbacks
 @abstract Abstract for this API.
 @discussion Defines the basic interface for Command DescriptorBlock (CDB) commands.
 
 @field firstField Description of first field.
 
 @callback setPointers Specifies the location of the data buffer. The setPointers function has the following parameters:
 @param cmd A pointer to the CDB command interface.
 @param sgList A pointer to a scatter/gather list.
 @result An IOReturn structure which returns the return value in the structure returned.
 
 @field lastField Description of the struct's last field.
 */
typedef struct _someTag {
    short firstField;
    IOReturn (*setPointers)(void *cmd, IOVirtualRange *sgList);
    unsigned long lastField;
} TypedefdStructWithCallbacks;

/*!
 @defined TRUE 宏
 @abstract Defines the boolean true value.
 @parseOnly
 @discussion Extended discussion goes here.
 Lorem ipsum....
 */
#define TRUE 1





/*!
 @protocol
 @abstract 这个HelloDoc类的一个protocol
 @discussion 具体描述信息可以写在这里
 */
@protocol HelloDocDelegate <NSObject>

@end

/*!
 @class
 @abstract 这里可以写关于这个类的一些描述。
 */
@interface Testdoc : NSObject {
    NSString    *name; /*! @var your's name. */
}

/*!
 @property
 @abstract 这里可以写关于这个Property的一些基本描述。
 */
@property (nonatomic,readonly) NSString *helloDocText_;

/*!
 @method
 @abstract 这里可以写一些关于这个方法的一些简要描述
 @discussion 这里可以具体写写这个方法如何使用，注意点之类的。如果你是设计一个抽象类或者一个
 共通类给给其他类继承的话，建议在这里具体描述一下怎样使用这个方法。
 @param text 文字 (这里把这个方法需要的参数列出来)
 @param error 错误参照
 @result 返回结果
 */
- (BOOL)showText:(NSString *)text 
           error:(NSError **)error
           error:(NSError **)error
           error:(NSError **)error;

@end

/*!
 @category
 @abstract NSString的Category
 */
@interface NSString (copyTo)

@end
