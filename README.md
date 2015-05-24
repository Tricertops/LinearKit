LinearKit
=========

#### Objective-C wrapper for Accelerate framework.

Accelerate code is unreadable, arguments are mysterious and its documentation sucks.

**LinearKit** code:

```objc
LKVector *vector = LKVectorMake(1, 4, 6, 7, 1);
[vector set:vector.squared];
```

**Accelerate** equivalent:

```objc
float values[] = { 1, 4, 6, 7, 1 };
vDSP_vsq(values, 1, values, 1, 5);
```

> **Project Status:** What is described here is already implemented and partially tested. There is much more to implement, so if you are interested in development, contact me.

Features
--------

### Precision

Available for **single and double precision** floating-point numbers. Just change desired precision at compile time by modifying `#define LinearKitPrecision 1` in `LKPrecision.h`. After setting the precision to `2`, all types and functions will use `double` type, instead of `float`.

_How to store the values?_

### Vector

Abstraction over an array of values. `LKVector` class provides unified interface for vectors **backed** by `NSMutableData` and proxy vectors called **subvectors**. Vectors don’t need to be continuous, because they also support strides.

```objc
LKVector *vector = LKVectorMake(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);

LKVector *fromSixth = [vector subvectorFrom:6]; // 6, 7, 8, 9
LKVector *toThird = [vector subvectorTo:3]; // 0, 1, 2, 3
LKVector *fromFourthToSeventh = [vector subvectorFrom:4 to:7]; // 4, 5, 6, 7

LKVector *everyEven = [vector subvectorBy:2]; // 0, 2, 4, 6, 8
LKVector *everyOdd = [vector subvectorFrom:1 by:2] // 1, 3, 5, 7, 9

LKVector *reversed = [vector reversed]; // 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
LKVector *reversedEveryEven = [everyEven reversed]; // 8, 6, 4, 2, 0
```

None of the methods above copied any of the values. They are just proxies to the original vector. Modifying the values in the subvectors affect the orignal values:

```objc
*reversedEveryEven.at(2) = 100;
// 0, 1, 2, 3, 100, 5, 6, 7, 8, 9
```

Method `-at` returns a block taking index. This block returns pointer to value at the given index, so you can then read or write its value.

Imagine you have RGBA samples of an image, you can easily separate all 4 channels like this:

```objc
LKVector *samples = [self sampleImage];
LKVector *red = [samples subvectorFrom:0 by:4];
LKVector *green = [samples subvectorFrom:1 by:4];
LKVector *blue = [samples subvectorFrom:2 by:4];
LKVector *alpha = [samples subvectorFrom:3 by:4];
```

_How to get such RGBA samples in a first place?_

### Formats

Class `LKFormat` abstracts information about how to convert bytes **to and from** floating-point samples. When you get some data in 1-byte integer samples, you have to convert them to desired floating-point samples. This is easy with LinearKit:

```objc
uint8_t *byteSamples = [self createByteSamples]; // 0, 63, 127, 191 255
NSData *data = [NSData dataWithBytesNoCopy:byteSamples length:length];

LKFormat *normalizedFormat = LKFormatMakeNormalized(uint8_t);
LKVector *vector = [LKVector vectorFromData:data format:normalizedFormat];
// 0, 0.25, 0.5, 0.75, 1
```

`Normalized` in the `LKFormat` means the values will be mapped to 0-1 range. Otherwise the values would be `0.0, 63.0, 127.0, 191.0, 255.0`. Here is Accelerate equivalent of the above conversion:

```objc
vDSP_vfltu8(byteSamples, 1, floatSamples, 1, length);
float max = UINT8_MAX;
vDSP_vsdiv(floatSamples, 1, &max, floatSamples, 1, length);
```

It is also easy to convert **back** to any format you need:

```objc
LKFormat *format = LKFormatMakeNormalized(unsigned short);
NSMutableData *data = [vector copyDataWithFormat:format];
```

_What can I do with these vectors then?_

### Operations

Operation object encapsulates **future** operation on one or more vectors. They are future, because the only thing they do not encapsulate is the destination of the results. Once you provide destination, they actually evaluate by calling (typically) **single Accelerate function**.

```objc
LKVector *vector = LKVectorMake(1, 4, 6, 7, 1);

LKOperation *squared = [vector squared]; // x²
[vector set:squared]; // 1, 16, 36, 49, 1

LKOperation *negated = [vector negated]; // -x
[vector set:negated]; // -1, -16, -36, -49, -1

[vector set:[vector addedTo:@3]; // 2, -13, -33, -46, 2
```

> This example uses: `vDSP_vsq()`, `vDSP_vneg()`, `vDSP_vsadd()`

• Method `-vectorize` creates new `LKVector` from the results of the receiveing operation.  
• Operations may produce scalars, like averages or extremes.  
• Some operation work only in-place.

```objc
LKVector *vector = LKVectorMake(2, -13, -33, -46, 2);
LKVector *clipped = [[vectorA clippedBelow:-30 above:0] vectorize]; // 0, -13, -30, -30, 0
LKFloat meanA = [vectorA mean]; // -17.6 
[vectorA sortAscending:YES]; // -46, -33, -13, 2, 2
[vectorA set:[vectorA multipliedBy:clipped addedTo:@(meanA)]]; // -17.6, 411.4, 372.4, -77.6, -17.6
```

> This example uses: `vDSP_vclip()`, `vDSP_meanv()`, `vDSP_vsort()`, `vDSP_vma()`


### Generators

Generator is an operation that takes no input vector. They can be infinite and they can fill existing vectors of any length using some patterns. So far only these generators are available:

  - `-clear`: Fills zeroes, uses `vDSP_vclr()`.
  - `-fill:`: Fills with given constant, uses `vDSP_vfill()`.
  - `-rampFrom:by:`: Fills linear values like `value = from + index * by`, uses `vDSP_vramp()`.
  - `-interpolateFrom:to:`: Fills values between two numbers, uses `vDSP_vgen()`.


---

_Would you ever say working with Accelerate.framework will be fun?_
