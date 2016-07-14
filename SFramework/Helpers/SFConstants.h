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

#define CClear                  [UIColor clearColor]
#define CBlack                  [UIColor blackColor]
#define CRed                    [UIColor redColor]
#define CWhite                  RGB(255, 255, 255)
#define CLightGrey              [Utils colorWithHexString:@"#EEEEEE"]
#define CDarkBlue               [Utils colorWithHexString:@"#263167"]
#define CLightBlue              [Utils colorWithHexString:@"#15B3CD"]
#define CBlackBorder            [Utils colorWithHexString:@"#5D5D5D"]
#define CYellow                 [Utils colorWithHexString:@"#FBE608"]

// ************************************** Fonts
#pragma mark - Fonts Name

#define MontserratRegular_WithSize(s)       [UIFont fontWithName:@"Montserrat-Regular" size:s]
#define MontserratBold_WithSize(s)          [UIFont fontWithName:@"Montserrat-Bold" size:s]


#endif /* Constants_h */
