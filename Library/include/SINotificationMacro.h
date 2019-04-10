//
//  SINotificationMacro.h
//  Category
//
//  Created by Silence on 25/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

// Add
#define ADD_OBSERVER_WITH_OBJECT(_selector, _name, _object) \
([[NSNotificationCenter defaultCenter] addObserver:self selector:_selector name:_name object:_object])
#define ADD_OBSERVER(_selector,_name) \
ADD_OBSERVER_WITH_OBJECT(_selector, _name, nil)

// Post
#define POST_NOTIFICATION_WITH_OBJECT_AND_INFO(_name, _object, _info) \
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_object userInfo:(_info)])
#define POST_NOTIFICATION(_name) \
POST_NOTIFICATION_WITH_OBJECT_AND_INFO(_name, nil, nil)
#define POST_NOTIFICATION_WITH_OBJECT(_name, _object) \
POST_NOTIFICATION_WITH_OBJECT_AND_INFO(_name, _object, nil)
#define POST_NOTIFICATION_WITH_INFO(_name, _info) \
POST_NOTIFICATION_WITH_OBJECT_AND_INFO(_name, nil, _info)

// Remove
#define REMOVE_OBSERVER(_name) \
([[NSNotificationCenter defaultCenter] removeObserver:self name:_name object:nil])
#define REMOVE_ALL_OBSERVERS(_self) \
([[NSNotificationCenter defaultCenter] removeObserver:_self])
