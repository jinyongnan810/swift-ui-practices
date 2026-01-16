# Image Explore Example

Various image handling techniques including content modes, async loading, grids, and clipping.

## Content Mode (ScaleFitOrFill)

### aspectRatio Content Modes
- `.aspectRatio(contentMode: .fit)` - maintains aspect ratio, may have letterboxing
- `.aspectRatio(contentMode: .fill)` - fills frame, may crop edges

### Image Resizing
- `.resizable()` required before sizing modifiers
- Without it, image uses intrinsic size

## Scroll Through Images

### Horizontal ScrollView
- `ScrollView(.horizontal)` for side-scrolling gallery
- `showsIndicators: false` hides scroll bars

## AsyncImage

### Loading Remote Images
- `AsyncImage(url:) { phase in }` for URL-based images
- Handle loading states with `AsyncImagePhase`

### Phase Handling
- `.empty` - show `ProgressView()` while loading
- `.failure` - show placeholder on error
- `.success(image)` - display loaded image
- `@unknown default` - handle future cases

## LazyVGrid

### Grid Layout
- `LazyVGrid(columns:)` for efficient grid rendering
- `GridItem(.flexible())` for adaptive column sizing
- `Array(repeating:count:)` for uniform columns

### Performance
- "Lazy" means views created on-demand during scroll
- Efficient for large image collections

## Clip Image

### Shape Clipping
- `.clipShape(.circle)` clips to circular shape
- `.clipShape(Capsule())` for pill shape
- Any `Shape` can be used for clipping

### Overlay on Clipped Image
- `.overlay {}` adds content on top
- Overlay respects clip shape bounds

## Key APIs
- `.resizable()`
- `.aspectRatio(contentMode:)`
- `AsyncImage`
- `AsyncImagePhase`
- `ScrollView(.horizontal)`
- `LazyVGrid`
- `GridItem`
- `.clipShape()`
- `.cornerRadius()`
- `.shadow()`
