//
//  ASMacro.h
//  ASLY
//
//  Created by 张志超 on 2020/11/2.
//  Copyright © 2020 AS. All rights reserved.
//

#ifndef ASMacro_h
#define ASMacro_h

#import <JKCategories/JKCategories.h>
#import <Masonry/Masonry.h>

#define WEAKSELF_(x) typeof(x) __weak weakSelf = x;
#define STRONGSELF_(x) typeof(x) __strong strongSelf = x;

#define WEAKSELF WEAKSELF_(self)
#define STRONGSELF STRONGSELF_(self)


#define kColorHex(hexValue) [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:1.0]


#define kTEXT_FONT_(fontSize) [UIFont systemFontOfSize:fontSize]

#define kTEXT_FONT_BOLD_(fontSize) [UIFont boldSystemFontOfSize:fontSize]



#define kMainColor kColorHex(0x1296db)

#define kNormalTextColor kColorHex(0x8a8a8a)


#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define UIImageNamed(name) [UIImage imageNamed:name]


#endif /* ASMacro_h */
