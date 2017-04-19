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

typedef NSNumber *(^RLDynamicCellHeightBlock)(NSIndexPath *indexPath);

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
 当需要动态计算某个Cell的高度时候，实现这个Block，会在UITableView的计算高度Delegate中得到调用
 优先级 dynamicCellHeightBlock > cellHeight > RLCellModelManager's globalHeight
 */
@property (copy, nonatomic) RLDynamicCellHeightBlock dynamicCellHeightBlock;


/**
 每个Cell对应的Cell Height
 */
@property (strong, nonatomic) NSNumber *cellHeight;

@end
