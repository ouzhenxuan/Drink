//
//  ZXTool.h
//  Drink
//
//  Created by 区振轩 on 2019/1/2.
//  Copyright © 2019 区振轩. All rights reserved.
//

#ifndef ZXTool_h
#define ZXTool_h


/**************************************/
/************     控制输出       **********/

#define ZXLogFunc ZXLog(@"%s",__func__)

#ifdef DEBUG
#define ZXLog(...) NSLog(__VA_ARGS__)
#define ZXFormatDebug 1
#else
#define ZXLog(...)
#define ZXFormatDebug 0
#endif


#if ZXFormatDebug
#define ZXFormatLog(...)\
{\
NSString *string = [NSString stringWithFormat:__VA_ARGS__];\
NSLog(@"\n===========================\n===========================\n=== ZXFormatLog ===\n提示信息:%@\n所在方法:%s\n所在行数:%d\n===========================\n===========================",string,__func__,__LINE__);\
}
#else
#define ZXFormatLog(...)
#endif

#if ZXFormatDebug
#define ZXErrorLog(...)\
{\
NSString *string = [NSString stringWithFormat:__VA_ARGS__];\
NSLog(@"\n===========================\n===========================\n=== ZXErrorLog ===\n异常情况输出信息:%@\n所在方法:%s\n所在行数:%d\n===========================\n===========================",string,__func__,__LINE__);\
}
#else
#define ZXErrorLog(...)
#endif

#endif /* ZXTool_h */
