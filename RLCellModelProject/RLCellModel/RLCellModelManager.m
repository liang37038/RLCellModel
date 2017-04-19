//
//  RLCellModelManager.m
//  RLCellModelProject
//
//  Created by Richard Liang on 2017/4/17.
//
//

#import "RLCellModelManager.h"

@implementation RLCellModelManager
{
    NSString                        *_globalIdentifier;
    CGFloat                         _globalHeight;
    GlobalReuseCellBlock            _globalReuseCellBlock;
    CustomExtractCellModelBlock     _extractCellModelBlock;
}

- (instancetype)initWithGlobalCellIdentifier:(NSString *)identifier globalHeight:(CGFloat)height globalReuseCellBlock:(GlobalReuseCellBlock)reuseBlock{
    return [self initWithGlobalCellIdentifier:identifier globalHeight:height globalReuseCellBlock:reuseBlock customExtractCellModelBlock:nil];
}

- (instancetype)initWithGlobalCellIdentifier:(NSString *)identifier globalHeight:(CGFloat)height globalReuseCellBlock:(GlobalReuseCellBlock)reuseBlock customExtractCellModelBlock:(CustomExtractCellModelBlock)extractBlock{
    if (self = [super init]) {
        _globalIdentifier = identifier;
        _globalHeight = height;
        _globalReuseCellBlock = reuseBlock;
        _extractCellModelBlock = extractBlock;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rl_scrollViewDidScroll:)]) {
        [self.delegate rl_scrollViewDidScroll:scrollView];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:rl_viewForHeaderInSection:)]) {
        return [self.delegate tableView:tableView rl_viewForHeaderInSection:section];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:rl_viewForFooterInSection:)]) {
        return [self.delegate tableView:tableView rl_viewForFooterInSection:section];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:rl_heightForFooterInSection:)]) {
        return [self.delegate tableView:tableView rl_heightForFooterInSection:section];
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:rl_heightForHeaderInSection:)]) {
        return [self.delegate tableView:tableView rl_heightForHeaderInSection:section];
    }
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    RLCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    
    UITableViewCell *cell = nil;
    
    if (cellModel.cellIdentifier && cellModel.cellIdentifier.length > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellModel.cellIdentifier forIndexPath:indexPath];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:_globalIdentifier forIndexPath:indexPath];
    }
    
    if (cellModel.refreshBlock) {
        cellModel.refreshBlock(cell);
    }else{
        if (_globalReuseCellBlock) {
            _globalReuseCellBlock(cell, cellModel);
        }
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([[_cellModels firstObject] isKindOfClass:[NSArray class]]) {
        return _cellModels.count;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[_cellModels firstObject] isKindOfClass:[NSArray class]]) {
        return [[_cellModels objectAtIndex:section]count];
    }else{
        return _cellModels.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RLCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    if (cellModel.dynamicCellHeightBlock) {
        return cellModel.dynamicCellHeightBlock(indexPath).floatValue;
    }else if (cellModel.cellHeight.floatValue != 0) {
        return cellModel.cellHeight.floatValue;
    }else{
        return _globalHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RLCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    if (cellModel.cellSelectedBlock) {
        cellModel.cellSelectedBlock();
    }
}

- (RLCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexPath{
    RLCellModel *cellModel = nil;
    if (_extractCellModelBlock) {
        cellModel = _extractCellModelBlock(_cellModels, indexPath);
    }else{
        cellModel = [_cellModels objectAtIndex:indexPath.row];
    }
    return cellModel;
}

@end
