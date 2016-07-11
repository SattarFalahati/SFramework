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

#define clearC                  [UIColor clearColor]
#define blackC                  [UIColor blackColor]
#define whiteC                  RGB(255, 255, 255)
#define redC                    [UIColor redColor]
#define lightGreyC              [Utils colorWithHexString:@"#EEEEEE"]
#define darkBlueC               [Utils colorWithHexString:@"#263167"]
#define lightBlueC              [Utils colorWithHexString:@"#15B3CD"]
#define blackBorderC            [Utils colorWithHexString:@"#5D5D5D"]
#define yellowC                 [Utils colorWithHexString:@"#FBE608"]
#define grayForFonts            [Utils colorWithHexString:@"#777777"]

// ************************************** Fonts
#pragma mark - Fonts Name

#define MontserratRegular_WithSize(s)       [UIFont fontWithName:@"Montserrat-Regular" size:s]
#define MontserratBold_WithSize(s)          [UIFont fontWithName:@"Montserrat-Bold" size:s]



#endif /* Constants_h */
