//
//  SIExceptionMacro.h
//  Category
//
//  Created by Silence on 25/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#define kArgumentException                  @"ArgumentException"
#define kArgumentNilException               @"ArgumentNilException"
#define kArgumentNilOrEmptyException        @"ArgumentNilOrEmptyException"
#define kNilObjectException                 @"NilObjectException"
#define kInvalidOperationException          @"InvalidOperationException"
#define kInvalidObjectTypeException         @"InvalidObjectTypeException"
#define kNotImplementedException            @"NotImplementedException"
#define kOutOfRangeException                @"OutOfRangeException"

#define AssertIndexInRange(parameter, parameterName, min, max) if (parameter < min || parameter > max) { \
@throw [NSException exceptionWithName:kOutOfRangeException \
reason:[NSString stringWithFormat:@"%s, %d -> the parameter '%@' with value %d is out of bounds [%d .. %d].", __FUNCTION__, __LINE__, parameterName, parameter, min, max] \
userInfo:nil]; }

#define AssertIndexLessThan(parameter, parameterName, max) if (parameter >= max) { \
@throw [NSException exceptionWithName:kOutOfRangeException \
reason:[NSString stringWithFormat:@"%s, %d -> the parameter '%@' with upper bound %d has the value %d.", __FUNCTION__, __LINE__, parameterName,max, parameter] \
userInfo:nil]; }

#define AssertArgumentNotNil(argument, argumentName) if (argument == nil) { \
@throw [NSException exceptionWithName:kArgumentNilException \
reason:[NSString stringWithFormat:@"%s, %d -> the parameter %@ can not be nil.", __FUNCTION__, __LINE__, argumentName] \
userInfo:nil]; }

#define AssertArgumentNotNilOrEmptyString(argument, argumentName) if (!IS_POPULATED_STRING(argument)) { \
@throw [NSException exceptionWithName:kArgumentNilOrEmptyException \
reason:[NSString stringWithFormat:@"%s, %d -> the parameter %@ can not be nil or empty.", __FUNCTION__, __LINE__, argumentName] \
userInfo:nil]; }

#define AssertObjectNotNil(var, varName) if (var == nil) { \
@throw [NSException exceptionWithName:kNilObjectException \
reason:[NSString stringWithFormat:@"%s, %d -> the variable %@ should not be nil.", __FUNCTION__, __LINE__, varName] \
userInfo:nil]; }

#define AssertStringNonEmptyOrNil(string, argumentName) if (!IS_POPULATED_STRING(argument)) { \
@throw [NSException exceptionWithName:kArgumentException \
reason:[NSString stringWithFormat:@"%s, %d -> the parameter %@ can not be empty or nil.", __FUNCTION__, __LINE__, argumentName] \
userInfo:nil]; }

#define AssertObjectConformsProtocol(obj, objName, protocol) if (![obj conformsToProtocol:protocol]) { \
@throw [NSException exceptionWithName:kInvalidOperationException \
reason:[NSString stringWithFormat:@"%s, %d -> object %@ should conforms to the protocol %@.", __FUNCTION__, __LINE__, objName, protocol] \
userInfo:nil]; }

#define AssertObjectIsKindOfClass(obj, objName, requiredType) if (![obj isKindOfClass:[requiredType class]]) { \
@throw [NSException exceptionWithName:kInvalidObjectTypeException \
reason:[NSString stringWithFormat:@"%s, %d -> object %@ should be of type %@. Real type is %@", __FUNCTION__, __LINE__, objName, [[requiredType class] description], [[obj class] description]] \
userInfo:nil]; }

#define THROW_NOT_IMPLEMENTED_EXCEPTION @throw [NSException exceptionWithName:kNotImplementedException reason:[NSString stringWithFormat:@"%s -> the method is not implemented.", __FUNCTION__] userInfo:nil];

