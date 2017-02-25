//
//  SILogMacros.h
//  Category
//
//  Created by 杨晴贺 on 16/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#if defined(__GON_TRIM_LOG_MACROS__)
#define GONLog(msg, ...)
#define LOG_VIEW(view)
#define FRAME_TO_STRING(frame)
#define RECT_TO_STRING(rect)
#define POINT_TO_STRING(point)
#define SIZE_TO_STRING(size)
#define OBJ_TO_STRING(obj)
#define LOG_FRAME(frame)
#define LOG_RECT(rect)
#define LOG_POINT(point)
#define LOG_SIZE(size)
#define LOG_OBJ(obj)
#define DATA_TO_STR(data, dataEnc)
#define DATA_TO_UTF8_STRING(data)
#define COORDINATE_REGION_TO_STRING(region)
#define COORDINATE_SPAN_TO_STRING(span)
#define MAP_POINT_TO_STRING(mapPoint)
#define MAP_SIZE_TO_STRING(mapSize)
#define LOCATION_COORDINATE_2D_TO_STRING(coordinate)
#define MAP_RECT_TO_STRING(mapRect)
#define LOG_COORDINATE_REGION(region)
#define LOG_COORDINATE_SPAN(span)
#define LOG_MAP_POINT(mapPoint)
#define LOG_MAP_SIZE(mapSize)
#define LOG_LOCATION_COORDINATE_2D(coordinate)
#define LOG_MAP_RECT(mapRect)
#else
#if !defined(GON_LOGGER)
#define GON_LOGGER NSLog
#endif

// 重新定义日志输出
#define GONLog(msg, ...)                                        GON_LOGGER(@"%@|%s|%d> %@", [[self class] description], sel_getName(_cmd), __LINE__, [NSString stringWithFormat:(msg), ##__VA_ARGS__]);

// 打印View层级
#define LOG_VIEW(view)                                          GON_LOGGER(@"%@", [view recursiveDescription]);

// 转换为字符串
#define FRAME_TO_STRING(frame)                                  [NSString stringWithFormat:@"%f %f %f %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height]
#define RECT_TO_STRING(rect)                                    FRAME_TO_STRING(rect)
#define POINT_TO_STRING(point)                                  [NSString stringWithFormat:@"%f %f", point.x, point.y]
#define SIZE_TO_STRING(size)                                    [NSString stringWithFormat:@"%f %f", size.width, size.height]
#define OBJ_TO_STRING(obj)                                      [obj description]

// 打印Frame
#define LOG_FRAME(frame)                                        GON_LOGGER(@"%@", FRAME_TO_STRING(frame))
#define LOG_RECT(rect)                                          GON_LOGGER(@"%@", RECT_TO_STRING(rect))
#define LOG_POINT(point)                                        GON_LOGGER(@"%@", POINT_TO_STRING(point))
#define LOG_SIZE(size)                                          GON_LOGGER(@"%@", SIZE_TO_STRING(size))
#define LOG_OBJ(obj)                                            GON_LOGGER(@"%@", OBJ_TO_STRING(obj))

// 将Date转换为String
#define DATA_TO_STR(data, dataEnc)                              GON_LOGGER(@"%@", [[NSString alloc] initWithData:data encoding:dataEnc])

#define DATA_TO_UTF8_STRING(data)                               DATA_TO_STR(data, NSUTF8StringEncoding)

// Map kit
#define COORDINATE_REGION_TO_STRING(region)                     [NSString stringWithFormat:@"%f %f %f %f", region.center.latitude, region.center.longitude, region.span.latitudeDelta, region.span.longitudeDelta]
#define COORDINATE_SPAN_TO_STRING(span)                         [NSString stringWithFormat:@"%f %f", span.latitudeDelta, span.longitudeDelta]
#define MAP_POINT_TO_STRING(mapPoint)                           [NSString stringWithFormat:@"%f %f", mapPoint.x, mapPoint.y]
#define MAP_SIZE_TO_STRING(mapSize)                             [NSString stringWithFormat:@"%f %f", mapSize.width, mapSize.height]
#define LOCATION_COORDINATE_2D_TO_STRING(coordinate)            [NSString stringWithFormat:@"%f %f", coordinate.latitude, coordinate.longitude]
#define MAP_RECT_TO_STRING(mapRect)                             [NSString stringWithFormat:@"%f %f %f %f", mapRect.origin.x, mapRect.origin.y, mapRect.size.width, mapRect.size.height]

#define LOG_COORDINATE_REGION(region)                           GON_LOGGER(@"%@", COORDINATE_REGION_TO_STRING(region))
#define LOG_COORDINATE_SPAN(span)                               GON_LOGGER(@"%@", COORDINATE_SPAN_TO_STRING(span))
#define LOG_MAP_POINT(mapPoint)                                 GON_LOGGER(@"%@", MAP_POINT_TO_STRING(mapPoint))
#define LOG_MAP_SIZE(mapSize)                                   GON_LOGGER(@"%@", MAP_SIZE_TO_STRING(mapSize))
#define LOG_LOCATION_COORDINATE_2D(coordinate)                  GON_LOGGER(@"%@", LOCATION_COORDINATE_2D_TO_STRING(coordinate))
#define LOG_MAP_RECT(mapRect)                                   GON_LOGGER(@"%@", MAP_RECT_TO_STRING(mapRect))
#endif
