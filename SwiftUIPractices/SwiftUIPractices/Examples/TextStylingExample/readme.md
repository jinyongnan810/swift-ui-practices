# Text Styling Example

Comprehensive text formatting including markdown, attributed strings, custom renderers, and rich text editing.

## String Interpolation
- Embed `Text` views in strings: `Text("Hello \(styledText)")`
- Combine styled text segments

## Markdown Support

### Inline Markdown
- `Text("**bold** *italic* ~~strike~~")` renders markdown
- Links: `[title](url)` creates tappable links

### LocalizedStringKey for Dynamic Markdown
- `Text(LocalizedStringKey(markdownString))` parses dynamic strings
- Regular String literal auto-parses, String variable requires LocalizedStringKey

### Custom Link Handling
- `.environment(\.openURL, OpenURLAction { url in })` intercepts links
- Return `.systemAction` for default behavior
- Return `.handled` to block navigation

## Attributed String

### Basic AttributedString
- `var str = AttributedString("text")`
- Properties: `.foregroundColor`, `.backgroundColor`, `.font`

### Per-Character Styling
- Loop through characters, create attributed string per char
- `.baselineOffset` for wave effects
- Timer-driven animation for dynamic styling

## TextAttribute & TextRenderer

### Custom TextAttribute
- `struct MyAttribute: TextAttribute {}` marks text segments
- `.customAttribute(MyAttribute())` applies to text

### Custom TextRenderer
- Implement `TextRenderer` protocol
- `func draw(layout: Text.Layout, in ctx: inout GraphicsContext)`
- Access lines with `layout.flatMap(\.self)`
- Check for custom attributes: `line[MyAttribute.self]`

### Shader Effects
- `GraphicsContext.Filter.blur(radius:)` for blur
- `GraphicsContext.Filter.distortionShader()` for custom Metal shaders
- `ctx.addFilter()` applies to context

## Rich Text Editor

### TextEditor with AttributedString
- `TextEditor(text: $attributedText, selection: $selection)`
- `AttributedTextSelection` tracks selection

### Transforming Attributes
- `text.transformAttributes(in: &selection) { container in }`
- Modify: `.font`, `.foregroundColor`, `.underlineStyle`, `.strikethroughStyle`, `.baselineOffset`, `.alignment`

### Font Resolution
- `@Environment(\.fontResolutionContext)` for font inspection
- `font.resolve(in: context)` gets resolved font properties
- Check `.isBold`, `.isItalic` for toggle behavior

### Selection-Aware UI
- `selection.typingAttributes(in: text)` gets current attributes
- Update UI (pickers, buttons) based on selection

## Key APIs
- `Text` with markdown
- `LocalizedStringKey`
- `.environment(\.openURL)`
- `AttributedString`
- `TextAttribute` protocol
- `TextRenderer` protocol
- `GraphicsContext.Filter`
- `TextEditor(text:selection:)`
- `AttributedTextSelection`
- `.transformAttributes()`
- `.fontResolutionContext`
