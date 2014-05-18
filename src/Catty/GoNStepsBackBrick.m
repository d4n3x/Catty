/**
 *  Copyright (C) 2010-2013 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

#import "Gonstepsbackbrick.h"
#import "Formula.h"

@implementation GoNStepsBackBrick

@synthesize steps = _steps;

- (NSString*)brickTitle
{
    return kBrickCellMotionTitleGoNStepsBack;
}

-(SKAction*)action
{

    return [SKAction runBlock:[self actionBlock]];

}

-(dispatch_block_t)actionBlock
{
    return ^{
        NSDebug(@"Performing: %@", self.description);
        CGFloat zValue = self.object.zPosition;
        int steps = [self.steps interpretIntegerForSprite:self.object];
        NSDebug(@"%f",self.object.zPosition-steps);
        self.object.zPosition = MAX(1, self.object.zPosition-steps);
        for(SpriteObject *obj in self.object.program.objectList){
            if ((obj.zPosition < zValue) && (obj.zPosition >= self.object.zPosition) && (obj != self.object)) {
                obj.zPosition +=1;
            }
        }
    };
    
}


#pragma mark - Description
- (NSString*)description
{
    return [NSString stringWithFormat:@"GoNStepsBack (%d)", [self.steps interpretIntegerForSprite:self.object]];
}


@end
