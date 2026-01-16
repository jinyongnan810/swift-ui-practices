# Price Card Practice

E-commerce style price card component with discount display.

## Techniques & Tips

### Optional Discount Handling
- `let discount: Int?` for optional discount value
- Computed property `priceAferDiscount` calculates final price
- Conditional UI rendering with `if discount != nil`

### Strikethrough Original Price
- `.strikethrough()` modifier on original price text
- Displays both original and discounted prices side by side

### Rotated Discount Badge
- `.rotationEffect(.degrees(-15))` for tilted badge effect
- `.offset(y: -40)` positions badge above card
- `.frame(maxWidth: .infinity, alignment: .trailing)` aligns to right

### String Formatting
- `specifier: "%.2f"` for currency formatting with 2 decimal places
- Consistent price display format

### Card Styling
- `RoundedRectangle` with consistent `cornerRadius`
- White stroke border over colored background
- `.shadow()` on discount badge for depth

### Layout Structure
- `VStack` for vertical content arrangement
- `HStack` with `Spacer()` for left-right alignment
- Nested `HStack` for price display grouping

## Key APIs
- Optional binding (`if let`, `!= nil`)
- Computed properties
- `.strikethrough()`
- `.rotationEffect()`
- `.offset()`
- `Text` with `specifier` for number formatting
- `RoundedRectangle`
- `.clipShape()` / `.stroke()`
