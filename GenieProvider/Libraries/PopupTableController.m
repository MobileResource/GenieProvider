
#import "PopupTableController.h"
#import "UIImageView+WebCache.h"

@implementation PopupTableController

@synthesize popupDelegate, itemsForDisplay, selectedItem, sourceView, selectByNone;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"";
    //self.contentSizeForViewInPopover = CGSizeMake(300.0, 280.0);

	// Initially, there is no active sample (RootViewController will specify this)
	selectedItem = @"";
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 40;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)viewDidUnload {
    [super viewDidUnload];
    self.itemsForDisplay = nil;
	self.selectedItem = nil;
}

- (CGSize)contentSize {
    CGSize size;
    size.width = [UIScreen mainScreen].bounds.size.width - 200;
    size.height = itemsForDisplay.count * self.tableView.rowHeight;
    return size;
}

- (void)setItemsForDisplay:(NSArray *)items {
    itemsForDisplay = items;
    [self.tableView reloadData];
    
    if (self.selectedItem) {
        NSInteger nRow = [self.itemsForDisplay indexOfObject:self.selectedItem];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:nRow inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
}

- (void)setSelectItemAndReload:(id)selectItem {
    selectedItem = selectItem;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemsForDisplay count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	// Set the tableview cell text to the name of the sample at the given index
	id cellName = [itemsForDisplay objectAtIndex:indexPath.row];
    cell.textLabel.text = cellName;
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.minimumScaleFactor = 0.6;
    
	if (!selectByNone && [selectedItem isEqual:cellName]) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	id cellName = [itemsForDisplay objectAtIndex:indexPath.row];
    // Notify the delegate if a row is selected (adding back file extension for delegate)
	if (popupDelegate && [popupDelegate respondsToSelector:@selector(popupTableController:didSelectString:)]) {
		[popupDelegate popupTableController:self didSelectString:cellName];
	}
    if (popupDelegate && [popupDelegate respondsToSelector:@selector(popupTableController:didSelectIndex:)]) {
        [popupDelegate popupTableController:self didSelectIndex:indexPath.row];
    }

	self.selectedItem = cellName;
	[self.tableView reloadData]; // refresh tableView cells for selection state change
}

@end

