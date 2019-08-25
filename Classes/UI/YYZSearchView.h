
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YYZSearchView;

@protocol YYZSearchViewDelegate <NSObject>

@optional
- (BOOL)searchView:(YYZSearchView *)searchView textFieldShouldBeginEditing:(UITextField *)textField;
- (void)searchView:(YYZSearchView *)searchView textFieldDidBeginEditing:(UITextField *)textField;
- (BOOL)searchView:(YYZSearchView *)searchView textFieldShouldEndEditing:(UITextField *)textField;
- (void)searchView:(YYZSearchView *)searchView textFieldDidEndEditing:(UITextField *)textField;

- (BOOL)searchView:(YYZSearchView *)searchView textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (void)searchView:(YYZSearchView *)searchView textFieldTextDidChange:(UITextField *)textField;

- (BOOL)searchView:(YYZSearchView *)searchView textFieldShouldClear:(UITextField *)textField;
- (BOOL)searchView:(YYZSearchView *)searchView textFieldShouldReturn:(UITextField *)textField;

@end

@interface YYZSearchView : UIView

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

@property (nonatomic, weak) id <YYZSearchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
