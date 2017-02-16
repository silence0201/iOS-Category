//
//  SIViewMacros.h
//  Category
//
//  Created by 杨晴贺 on 16/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

// Update current frame
#define UPDATE_FRAME_X(newX)						do{CGRect __tmpFrame = self.frame; __tmpFrame.origin.x = (newX); self.frame = __tmpFrame;}while(0)
#define UPDATE_FRAME_Y(newY)						do{CGRect __tmpFrame = self.frame; __tmpFrame.origin.y = (newY); self.frame = __tmpFrame;}while(0)
#define UPDATE_FRAME_WIDTH(newWidth)				do{CGRect __tmpFrame = self.frame; __tmpFrame.size.width = (newWidth); self.frame = __tmpFrame;}while(0)
#define UPDATE_FRAME_HEIGHT(newHeight)				do{CGRect __tmpFrame = self.frame; __tmpFrame.size.height = (newHeight); self.frame = __tmpFrame;}while(0)
#define UPDATE_FRAME_SIZE(newSize)                  do{CGRect __tmpFrame = self.frame; __tmpFrame.size = (newSize); self.frame = __tmpFrame;}while(0)
#define UPDATE_FRAME_ORIGIN(newOrigin)				do{CGRect __tmpFrame = self.frame; __tmpFrame.origin = (newOrigin); self.frame = __tmpFrame;}while(0)

// Update a view frame
#define UPDATE_VIEW_FRAME_X(aView, newX)			do{CGRect __tmpFrame = aView.frame; __tmpFrame.origin.x = (newX); aView.frame = __tmpFrame;}while(0)
#define UPDATE_VIEW_FRAME_Y(aView, newY)			do{CGRect __tmpFrame = aView.frame; __tmpFrame.origin.y = (newY); aView.frame = __tmpFrame;}while(0)
#define UPDATE_VIEW_FRAME_WIDTH(aView, newWidth)	do{CGRect __tmpFrame = aView.frame; __tmpFrame.size.width = (newWidth); aView.frame = __tmpFrame;}while(0)
#define UPDATE_VIEW_FRAME_HEIGHT(aView, newHeight)	do{CGRect __tmpFrame = aView.frame; __tmpFrame.size.height = (newHeight); aView.frame = __tmpFrame;}while(0)
#define UPDATE_VIEW_FRAME_SIZE(aView,newSize)       do{CGRect __tmpFrame = aView.frame; __tmpFrame.size = (newSize); aView.frame = __tmpFrame;}while(0)
#define UPDATE_VIEW_FRAME_ORIGIN(aView,newOrigin)   do{CGRect __tmpFrame = aView.frame; __tmpFrame.origin = (newOrigin); aView.frame = __tmpFrame;}while(0)

// Update current bounds
#define UPDATE_BOUNDS_X(newX)						do{CGRect __tmpBounds = self.bounds; __tmpBounds.origin.x = (newX); self.bounds = __tmpBounds;}while(0)
#define UPDATE_BOUNDS_Y(newY)						do{CGRect __tmpBounds = self.bounds; __tmpBounds.origin.y = (newY); self.bounds = __tmpBounds;}while(0)
#define UPDATE_BOUNDS_WIDTH(newWidth)				do{CGRect __tmpBounds = self.bounds; __tmpBounds.size.width = (newWidth); self.bounds = __tmpBounds;}while(0)
#define UPDATE_BOUNDS_HEIGHT(newHeight)				do{CGRect __tmpBounds = self.bounds; __tmpBounds.size.height = (newHeight); self.bounds = __tmpBounds;}while(0)
#define UPDATE_BOUNDS_SIZE(newSize)                 do{CGRect __tmpBounds = self.bounds; __tmpBounds.size = (newSize); self.bounds = __tmpBounds;}while(0)
#define UPDATE_BOUNDS_ORIGIN(newOrigin)				do{CGRect __tmpBounds = self.bounds; __tmpBounds.origin = (newOrigin); self.bounds = __tmpBounds;}while(0)

// Update a view bounds
#define UPDATE_VIEW_BOUNDS_X(aView, newX)			do{CGRect __tmpBounds = aView.bounds; __tmpBounds.origin.x = (newX); aView.bounds = __tmpBounds;}while(0)
#define UPDATE_VIEW_BOUNDS_Y(aView, newY)			do{CGRect __tmpBounds = aView.bounds; __tmpBounds.origin.y = (newY); aView.bounds = __tmpBounds;}while(0)
#define UPDATE_VIEW_BOUNDS_WIDTH(aView, newWidth)	do{CGRect __tmpBounds = aView.bounds; __tmpBounds.size.width = (newWidth); aView.bounds = __tmpBounds;}while(0)
#define UPDATE_VIEW_BOUNDS_HEIGHT(aView, newHeight)	do{CGRect __tmpBounds = aView.bounds; __tmpBounds.size.height = (newHeight); aView.bounds = __tmpBounds;}while(0)
#define UPDATE_VIEW_BOUNDS_SIZE(aView,newSize)      do{CGRect __tmpBounds = aView.bounds; __tmpBounds.size = (newSize); aView.bounds = __tmpBounds;}while(0)
#define UPDATE_VIEW_BOUNDS_ORIGIN(aView,newOrigin)  do{CGRect __tmpBounds = aView.bounds; __tmpBounds.origin = (newOrigin); aView.bounds = __tmpBounds;}while(0)

// Update current center
#define UPDATE_CENTER_X(newX)						do{CGPoint __tmpCenter = self.center; __tmpCenter.x = (newX); self.center = __tmpCenter;}while(0)
#define UPDATE_CENTER_Y(newY)						do{CGPoint __tmpCenter = self.center; __tmpCenter.y = (newY); self.center = __tmpCenter;}while(0)

// Update a view center
#define UPDATE_VIEW_CENTER_X(aView, newX)			do{CGPoint __tmpCenter = aView.center; __tmpCenter.x = (newX); aView.center = __tmpCenter;}while(0)
#define UPDATE_VIEW_CENTER_Y(aView, newY)			do{CGPoint __tmpCenter = aView.center; __tmpCenter.y = (newY); aView.center = __tmpCenter;}while(0)

// Autoresizing mask
#define UIViewAutoresizingTopAlign                  (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth)
#define UIViewAutoresizingBottomAlign               (UIViewAutoresizingFlexibleTopMargin    | UIViewAutoresizingFlexibleWidth)
#define UIViewAutoresizingCentered                  (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin)
#define UIViewAutoresizingFill                      (UIViewAutoresizingFlexibleHeight       | UIViewAutoresizingFlexibleWidth)

// Default components size
#define STATUS_BAR_DEFAULT_HEIGHT                   20
#define NAVIGATION_BAR_DEFAULT_HEIGHT               44
#define TOOLBAR_DEFAULT_HEIGHT                      44
#define TABBAR_DEFAULT_HEIGHT                       56
