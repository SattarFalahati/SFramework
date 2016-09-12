//
//  Constants.h
//  SFramework
//
//  Created by Sattar Falahati (SFramework) on 13/04/16.
//  Copyright © 2016 Sattar Falahati (SFramework). All rights reserved.
//

#ifndef Constants_h
#define Constants_h

// ************************************** Cloros
#pragma mark - Colors

#define kCClear                  [UIColor clearColor]
#define kCBlack                  [UIColor blackColor]
#define kCRed                    [UIColor redColor]
#define kCWhite                  RGB(255, 255, 255)
#define kCLightGrey              [Utils colorWithHexString:@"#EEEEEE"]
#define kCDarkBlue               [Utils colorWithHexString:@"#263167"]
#define kCLightBlue              [Utils colorWithHexString:@"#15B3CD"]
#define kCBlackBorder            [Utils colorWithHexString:@"#5D5D5D"]
#define kCYellow                 [Utils colorWithHexString:@"#FBE608"]

// ************************************** Fonts
#pragma mark - Fonts Name

#define MontserratRegular_WithSize(s)       [UIFont fontWithName:@"Montserrat-Regular" size:s]
#define MontserratBold_WithSize(s)          [UIFont fontWithName:@"Montserrat-Bold" size:s]


#endif /* Constants_h */
