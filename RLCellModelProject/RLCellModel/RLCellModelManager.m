//
//  RLCellModelManager.m
//  RLCellModelProject
//
//  Created by Richard Liang on 2017/4/17.
//
//

#import "RLCellModelManager.h"
#import "UITableView+FDTemplateLayoutCell.h"

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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rl_scrollViewWillBeginDragging:)]) {
        [self.delegate rl_scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rl_scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.delegate rl_scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rl_scrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegate rl_scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rl_scrollViewWillBeginDecelerating:)]) {
        [self.delegate rl_scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rl_scrollViewDidEndDecelerating:)]) {
        [self.delegate rl_scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rl_scrollViewDidEndScrollingAnimation:)]) {
        [self.delegate rl_scrollViewDidEndScrollingAnimation:scrollView];
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
    
    if (cellModel.cellRefreshBlock) {
        cellModel.cellRefreshBlock(cell, cellModel.boundModel, indexPath);
    }else{
        if (_globalReuseCellBlock) {
            _globalReuseCellBlock(cell, cellModel, indexPath);
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
    }else if(cellModel.cellHeight == UITableViewAutomaticDimension){
        return [tableView fd_heightForCellWithIdentifier:cellModel.cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
            if (cellModel.cellRefreshBlock) {
                cellModel.cellRefreshBlock(cell, nil, indexPath);
            }
        }];
    }else if (cellModel.cellHeight!=0) {
        return cellModel.cellHeight;
    }else{
        return _globalHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RLCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    if (cellModel.cellSelectedBlock) {
        cellModel.cellSelectedBlock(nil, cellModel.boundModel, indexPath);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:rl_didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView rl_didSelectRowAtIndexPath:indexPath];
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
