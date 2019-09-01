
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YYZSearchView;

@protocol YYZSearchViewDelegate <NSObject>

@optional
- (BOOL)searchViewShouldBeginEditing:(YYZSearchView *)searchView;
- (void)searchViewDidBeginEditing:(YYZSearchView *)searchView;
- (BOOL)searchViewShouldEndEditing:(YYZSearchView *)searchView;
- (void)searchViewDidEndEditing:(YYZSearchView *)searchView;

- (BOOL)searchView:(YYZSearchView *)searchView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (void)searchViewTextDidChange:(YYZSearchView *)searchView;

- (BOOL)searchViewShouldClear:(YYZSearchView *)searchView;
- (BOOL)searchViewShouldReturn:(YYZSearchView *)searchView;

@end

@interface YYZSearchView : UIView

@property (nonatomic, weak) id <YYZSearchViewDelegate> delegate;

/** 请勿使用textField的代理，用YYZSearchView的代理代替 */
@property (nonatomic, readonly, strong) UITextField *textField;
@property (nonatomic, readonly, strong) UIButton *cancelButton;

/**
 搜索icon颜色，默认值 #999999
 */
@property (nonatomic, strong) UIColor *searchIconColor;

/**
 输入框背景色，默认值 #DDDDDD
 */
@property (nonatomic, strong) UIColor *inputBackgroundColor;

@end

NS_ASSUME_NONNULL_END
