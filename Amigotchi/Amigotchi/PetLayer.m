//
//  PetLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PetLayer.h"


@implementation PetLayer
@synthesize pet = _pet, view = _view;
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PetLayer *layer = [PetLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	
	// return the scene
	return scene;
}
-(void) dealloc {
    [_pet release];
    [_view release];
    
    [super dealloc];
}
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize]; 
        
        // add a pet model
        self.pet = [[AmigoPet alloc] init];
        
        [self.pet addObserver:self forKeyPath:@"bathroom" options:(NSKeyValueObservingOptionNew |
                                                         NSKeyValueObservingOptionInitial) context:nil];
        [self.pet addObserver:self forKeyPath:@"happiness" options:(NSKeyValueObservingOptionNew |
                                                                   NSKeyValueObservingOptionInitial) context:nil];
        [self.pet addObserver:self forKeyPath:@"age" options:(NSKeyValueObservingOptionNew |
                                                                    NSKeyValueObservingOptionInitial) context:nil];
        [self.pet addObserver:self forKeyPath:@"hunger" options:(NSKeyValueObservingOptionNew |
                                                                    NSKeyValueObservingOptionInitial) context:nil];
        [self.pet addObserver:self forKeyPath:@"accessory" options:(NSKeyValueObservingOptionNew |
                                                                 NSKeyValueObservingOptionInitial) context:nil];
        
        //add a pet view
        self.view = [[AmigoPetView alloc] initWithHappiness:self.pet.happiness
                                                  andHunger:self.pet.hunger
                                                andBathroom:self.pet.bathroom
                                                     andAge:self.pet.age
                                               andAccessory:self.pet.accessory];
        self.view.scale = .5;
        self.view.position = ccp(size.width/2, size.height - MENU_HEIGHT - self.view.mySprite.contentSize.height/2);
        [self addChild:self.view z:PET_LAYER];
        
        //listen for notifications
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputFromView:) name:PETVIEWCHANGE object:nil];
        
        [[CCScheduler sharedScheduler] scheduleSelector:@selector(step:) forTarget:self.pet interval:60.0f paused:NO];
        
        
	}
	return self;
}

-(void)inputFromView:(NSNotification *)notification{
    
   // NSLog([[notification userInfo] description]);
    //NSLog([[notification object] description]);
    //NSLog(@"inputFromView:: received %@.\n", [notification object]);
    if([[notification object] isEqualToString:@"poke"])
    {
        //[self.pet updateHappiness:2];
    }
    
    if([[notification object] isEqualToString:@"acc:cowboy hat"])
    {
        self.pet.accessory = @"cowboy hat";
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"Obtained Bellardo Hat!"]];
    }
    else if([[notification object] isEqualToString:@"acc:glasses"])
    {
        self.pet.accessory = @"glasses";
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"Obtained Bellardo Glasses!"]];
    }
    else if([[notification object] isEqualToString:@"acc:none"])
    {
        self.pet.accessory = @"none";
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    /*NSLog(@"keypath is: %@", keyPath);
    NSLog(@"object is: %@", [object description]);
    NSLog(@"change is: %@", [change description]);*/
    if([keyPath isEqualToString:@"hunger"])
    {
    }
    //NSLog(@"KVO!\n");
    [self.view refreshSpriteswithHappiness:self.pet.happiness andHunger:self.pet.hunger andBathroom:self.pet.bathroom andAge:self.pet.age andAccessory:self.pet.accessory];
}



/*- (void) foodButtonCallback {
    NSLog(@"PetLayer::foodButtonCallback");
    self.pet.hunger--;
}
- (void) checkinButtonCallback {
    NSLog(@"PetLayer::checkinButtonCallback");
    if(self.pet.bathroom < MAX_BATHROOM)
        self.pet.bathroom++;
}
- (void) mapButtonCallback {
    NSLog(@"PetLayer::mapButtonCallback");
    
}
- (void) toiletButtonCallback
{
    NSLog(@"PetLayer::toiletButtonCallback");
    [self.pet cleanBathroom];
}*/
         
@end
