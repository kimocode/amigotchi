//
//  EnvironmentLayer.h
//  Amigotchi
//
//  Created by Elliott Kipper on 4/19/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EnvironmentView.h"
//#import "Environment.h"


@interface EnvironmentLayer : CCNode {
    
}

//@property (nonatomic, retain) Environment * model;
@property (nonatomic, retain) EnvironmentView * view;
@end
