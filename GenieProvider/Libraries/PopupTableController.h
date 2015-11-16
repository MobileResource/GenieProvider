
#import <UIKit/UIKit.h>

@class PopupTableController;

// Delegate protocol for communicating popover results back to root
@protocol PopupTableDelegate <NSObject>
// Sent when the user selects a row in the samples list.
@optional
- (void)popupTableController:(PopupTableController *)controller didSelectString:(NSString *)selectedItem;
- (void)popupTableController:(PopupTableController *)controller didSelectIndex:(NSInteger)selectedIndex;
@end


@interface PopupTableController : UITableViewController <UIActionSheetDelegate> {
    id <PopupTableDelegate>  delegate;          // our delegate
    NSArray                 *itemsForDisplay;     // list of popup items for UI
 	NSString                *selectedItem;    // current document
}

@property (nonatomic, strong) id <PopupTableDelegate> popupDelegate;
@property (nonatomic, strong) NSArray   *itemsForDisplay;
@property (nonatomic, strong) NSString  *selectedItem;
@property (nonatomic, strong) UIView    *sourceView;
@property (nonatomic, readwrite) BOOL   selectByNone;//NO: check, YES: no check

- (void)setSelectItemAndReload:(id)selectItem;
- (CGSize)contentSize;

@end
