/**
 *  Copyright (C) 2010-2015 The Catrobat Team
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

#import "Changesizebynbrick.h"
#import "Formula.h"
#import "Script.h"
#import "Pocket_Code-Swift.h"

@implementation ChangeSizeByNBrick

- (Formula*)formulaForLineNumber:(NSInteger)lineNumber andParameterNumber:(NSInteger)paramNumber
{
    return self.size;
}

- (void)setFormula:(Formula*)formula forLineNumber:(NSInteger)lineNumber andParameterNumber:(NSInteger)paramNumber
{
    self.size = formula;
}

- (void)setDefaultValuesForObject:(SpriteObject*)spriteObject
{
    self.size = [[Formula alloc] initWithInteger:10];
}

- (NSString*)brickTitle
{
    return kLocalizedChangeSizeByN;
}

- (SKAction*)action
{
    return [SKAction runBlock:[self actionBlock]];
}

- (dispatch_block_t)actionBlock
{
    return ^{
        NSDebug(@"Performing: %@", self.description);
        double sizeInPercent = [self.size interpretDoubleForSprite:self.script.object];
        [self.script.object.spriteNode setXScale:(CGFloat)(self.script.object.spriteNode.xScale + sizeInPercent/100.0)];
        [self.script.object.spriteNode setYScale:(CGFloat)(self.script.object.spriteNode.yScale + sizeInPercent/100.0)];
        //for touch issue
        CGImageRef image = [self.script.object.spriteNode.currentUIImageLook CGImage];
        self.script.object.spriteNode.currentUIImageLook = [UIImage imageWithCGImage:image scale:(CGFloat)(self.script.object.spriteNode.xScale + 1.0f/(sizeInPercent/100.0f)) orientation:UIImageOrientationUp];
    };

}

#pragma mark - Description
- (NSString*)description
{
    return [NSString stringWithFormat:@"ChangeSizeByN (%f%%)", [self.size interpretDoubleForSprite:self.script.object]];
}

@end