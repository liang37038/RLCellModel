//
//  RLCellModel.h
//  RLCellModelProject
//
//  Created by Richard Liang on 2017/1/5.
//
//

#import <Foundation/Foundation.h>

typedef void(^RLVoldBlock)();

typedef void(^RLRefreshBlock)(id cell, ...);

@interface RLCellModel : NSObject


@property (strong, nonatomic) NSString *cellIdentifier;

/**
 Cell生成规则的字典
 */
@property (strong, nonatomic) NSDictionary *cellGenerateRuleDict;


/**
 Cell被点击的时候触发的Block
 */
@property (copy, nonatomic) RLVoldBlock cellSelectedBlock;


/**
 Cell被刷新的时候触发的Block
 */
@property (copy, nonatomic) RLRefreshBlock refreshBlock;


/**
 每个Cell对应的Cell Height
 */
@property (strong, nonatomic) NSNumber *cellHeight;

@end
