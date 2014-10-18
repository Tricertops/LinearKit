//
//  LKPrecision.h
//  LinearKit
//
//  Created by Martin Kiss on 17.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//



#ifndef LinearKitPrecision
// You may need to clean the Xcode target after changing the precision.
    #define LinearKitPrecision 1
#endif



#if LinearKitPrecision == 1
    #define LKPrecision(Single, Double)    Single

#elif LinearKitPrecision == 2
    #define LKPrecision(Single, Double)    Double

#else
    #error Unsupported precision, valid values are only 1 (single, 32-bit) and 2 (double, 64-bit).
    // Add support for 4 (quadruple, 128-bit) once "long double" is supported by Accelerate.framework
#endif


