//
//  SIFRCMacros.h
//  Category
//
//  Created by 杨晴贺 on 16/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

/* Default implementation for a FRC, in a view controller with an UITableView property */
#define FRC_TABLEVIEW_DEFAULT_IMPLEMENTATION                                    FRC_TABLEVIEW_DEFAULT_IMPLEMENTATION_FOR_TABLEVIEW(_tableView)
#define FRC_TABLEVIEW_DEFAULT_IMPLEMENTATION_FOR_TABLEVIEW(aTableView)          FRC_TABLEVIEW_DEFAULT_IMPLEMENTATION_FOR_TABLEVIEW_UPDATE_SELECTOR(aTableView, nil)
#define FRC_TABLEVIEW_DEFAULT_IMPLEMENTATION_UPDATE_SELECTOR(updateSelector)    FRC_TABLEVIEW_DEFAULT_IMPLEMENTATION_FOR_TABLEVIEW_UPDATE_SELECTOR(_tableView, updateSelector)

#define FRC_TABLEVIEW_DEFAULT_IMPLEMENTATION_FOR_TABLEVIEW_UPDATE_SELECTOR(aTableView, updateSelector) \
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller { [aTableView beginUpdates]; }\
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller { [aTableView endUpdates]; SuppressPerformSelectorLeakWarning(if (updateSelector) [self performSelector:updateSelector];);} \
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo \
atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type { \
switch(type) { \
case NSFetchedResultsChangeInsert: \
[aTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] \
withRowAnimation:UITableViewRowAnimationFade]; \
break; \
case NSFetchedResultsChangeDelete: \
[aTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] \
withRowAnimation:UITableViewRowAnimationFade]; \
break; \
default:\
break;\
} \
} \
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject \
atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type \
newIndexPath:(NSIndexPath *)newIndexPath { \
switch(type) { \
case NSFetchedResultsChangeInsert:\
[aTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]\
withRowAnimation:UITableViewRowAnimationFade];\
break;\
case NSFetchedResultsChangeDelete:\
[aTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]\
withRowAnimation:UITableViewRowAnimationFade];\
break;\
case NSFetchedResultsChangeUpdate:\
{\
UITableViewCell *aCell = [aTableView cellForRowAtIndexPath:indexPath];\
if(aCell){\
[self tableView:aTableView\
willDisplayCell:aCell\
forRowAtIndexPath:indexPath];\
}\
}\
break;\
case NSFetchedResultsChangeMove:\
[aTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]\
withRowAnimation:UITableViewRowAnimationFade];\
[aTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]\
withRowAnimation:UITableViewRowAnimationFade];\
break;\
}\
}

/* Default implementation for a FRC, in a view controller with an UICollectionView property */
#define FRC_COLLECTIONVIEW_DEFAULT_IMPLEMENTATION                                           FRC_COLLECTIONVIEW_DEFAULT_IMPLEMENTATION_FOR_COLLECTIONVIEW(_collectionView)
#define FRC_COLLECTIONVIEW_DEFAULT_IMPLEMENTATION_FOR_COLLECTIONVIEW(aCollectionView)       FRC_COLLECTIONVIEW_DEFAULT_IMPLEMENTATION_FOR_COLLECTIONVIEW_UPDATE_SELECTOR(aCollectionView, nil)
#define FRC_COLLECTIONVIEW_DEFAULT_IMPLEMENTATION_UPDATE_SELECTOR(updateSelector)           FRC_COLLECTIONVIEW_DEFAULT_IMPLEMENTATION_FOR_COLLECTIONVIEW_UPDATE_SELECTOR(_collectionView, updateSelector)

#define FRC_COLLECTIONVIEW_DEFAULT_IMPLEMENTATION_FOR_COLLECTIONVIEW_UPDATE_SELECTOR(aCollectionView, updateSelector) \
static char const *__ ## aCollectionView ## sectionsKey;\
static char const *__ ## aCollectionView ## objectsKey;\
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {\
NSMutableArray *__objectsChanges = [[NSMutableArray alloc] init]; NSMutableArray *__sectionsChanges = [[NSMutableArray alloc] init]; objc_setAssociatedObject(self, &__ ## aCollectionView ## objectsKey, __objectsChanges, OBJC_ASSOCIATION_RETAIN_NONATOMIC); objc_setAssociatedObject(self, &__ ## aCollectionView ## sectionsKey, __sectionsChanges, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
}\
\
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {\
NSMutableArray *__objectsChanges = objc_getAssociatedObject(self, &__ ## aCollectionView ## objectsKey);\
NSMutableDictionary *change = [[NSMutableDictionary alloc] init];\
switch(type) \
{\
case NSFetchedResultsChangeInsert:\
change[@(type)] = newIndexPath;\
break;\
case NSFetchedResultsChangeDelete:\
change[@(type)] = indexPath;\
break;\
case NSFetchedResultsChangeUpdate:\
change[@(type)] = indexPath;\
break;\
case NSFetchedResultsChangeMove:\
change[@(type)] = @[indexPath, newIndexPath];\
break;\
}\
[__objectsChanges addObject:change];\
}\
\
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {\
NSMutableArray *__sectionsChanges = objc_getAssociatedObject(self, &__ ## aCollectionView ## sectionsKey);\
NSMutableDictionary *change = [[NSMutableDictionary alloc] init];\
switch(type)\
{\
case NSFetchedResultsChangeInsert:\
change[@(type)] = @[@(sectionIndex)];\
break;\
case NSFetchedResultsChangeDelete:\
change[@(type)] = @[@(sectionIndex)];\
break;\
default:\
break;\
}\
[__sectionsChanges addObject:change];\
}\
\
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {\
NSMutableArray *__objectsChanges = objc_getAssociatedObject(self, &__ ## aCollectionView ## objectsKey);\
NSMutableArray *__sectionsChanges = objc_getAssociatedObject(self, &__ ## aCollectionView ## sectionsKey);\
if ([__sectionsChanges count] > 0)\
{\
[aCollectionView performBatchUpdates:^{\
for (NSDictionary *change in __sectionsChanges)\
{\
[change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {\
NSFetchedResultsChangeType type = [key unsignedIntegerValue];\
switch (type)\
{\
case NSFetchedResultsChangeInsert:\
[aCollectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];\
break;\
case NSFetchedResultsChangeDelete:\
[aCollectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];\
break;\
case NSFetchedResultsChangeUpdate:\
[aCollectionView reloadSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];\
break;\
default:\
break;\
}\
}];\
}\
} completion:^(BOOL finished){\
if (updateSelector){\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
[self performSelector:updateSelector];\
_Pragma("clang diagnostic pop") }\
}];\
}\
if ([__objectsChanges count] > 0 && [__sectionsChanges count] == 0)\
{\
[aCollectionView performBatchUpdates:^{\
for (NSDictionary *change in __objectsChanges)\
{\
[change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {\
NSFetchedResultsChangeType type = [key unsignedIntegerValue];\
switch (type)\
{\
case NSFetchedResultsChangeInsert:\
[aCollectionView insertItemsAtIndexPaths:@[obj]];\
break;\
case NSFetchedResultsChangeDelete:\
[aCollectionView deleteItemsAtIndexPaths:@[obj]];\
break;\
case NSFetchedResultsChangeUpdate:\
[aCollectionView reloadItemsAtIndexPaths:@[obj]];\
break;\
case NSFetchedResultsChangeMove:\
[aCollectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];\
break;\
}\
}];\
}\
} completion:^(BOOL finished){\
if (updateSelector){\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
[self performSelector:updateSelector];\
_Pragma("clang diagnostic pop") }\
}];\
}\
objc_setAssociatedObject(self, &__ ## aCollectionView ## objectsKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
objc_setAssociatedObject(self, &__ ## aCollectionView ## sectionsKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
}
