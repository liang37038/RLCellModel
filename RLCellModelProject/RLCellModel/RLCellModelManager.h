//
//  RLCellModelManager.h
//  RLCellModelProject
//
//  Created by Richard Liang on 2017/4/17.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RLCellModel.h"

@protocol RLCellModelManagerDelegate <NSObject>

@optional
- (void)rl_scrollViewDidScroll:(UIScrollView *)scrollView;
- (CGFloat)tableView:(UITableView *)tableView rl_heightForFooterInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView rl_heightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView rl_viewForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView rl_viewForFooterInSection:(NSInteger)section;

@end

typedef void(^GlobalReuseCellBlock)(id cell, RLCellModel *cellModel, NSIndexPath *indexPath);

typedef RLCellModel *(^CustomExtractCellModelBlock)(NSArray *datasource, NSIndexPath *indexPath);

@interface RLCellModelManager : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *cellModels;

@property (assign, nonatomic) id<RLCellModelManagerDelegate> delegate;

- (instancetype)initWithGlobalCellIdentifier:(NSString *)identifier
                                globalHeight:(CGFloat)height
                        globalReuseCellBlock:(GlobalReuseCellBlock)block;

- (instancetype)initWithGlobalCellIdentifier:(NSString *)identifier
                                globalHeight:(CGFloat)height
                        globalReuseCellBlock:(GlobalReuseCellBlock)reuseBlock
                 customExtractCellModelBlock:(CustomExtractCellModelBlock)extractBlock;

@end
