//
//  SICollectionMacro.h
//  Category
//
//  Created by Silence on 25/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#define IDARRAY(...) (id []){ __VA_ARGS__ }
#define IDCOUNT(...) (sizeof(IDARRAY(__VA_ARGS__)) / sizeof(id))

#define ARRAY(...) [NSArray arrayWithObjects: IDARRAY(__VA_ARGS__) count: IDCOUNT(__VA_ARGS__)]

#define DICT(...) DictionaryWithIDArray(IDARRAY(__VA_ARGS__), IDCOUNT(__VA_ARGS__) / 2)

//The helper function unpacks the object array and then calls through to NSDictionary to create the dictionary:
static inline NSDictionary *DictionaryWithIDArray(id *array, NSUInteger count) {
    id keys[count];
    id objs[count];
    
    for(NSUInteger i = 0; i < count; i++) {
        keys[i] = array[i * 2];
        objs[i] = array[i * 2 + 1];
    }
    
    return [NSDictionary dictionaryWithObjects: objs forKeys: keys count: count];
}
#define POINTERIZE(x) ((__typeof__(x) []){ x })
#define NSVALUE(x) [NSValue valueWithBytes: POINTERIZE(x) objCType: @encode(__typeof__(x))]

#define INDEX_PATH(a,b) [NSIndexPath indexPathWithIndexes:(NSUInteger[]){a,b} length:2]

