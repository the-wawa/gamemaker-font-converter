Use Gamemaker-built fonts in Roblox
===

This simple utility was built for UNDERTALE fonts specifically! I have no clue if it's universal, but UNDERTALE fonts are converted perfectly well.

How to use
---

1. Extract the font you're looking to use from the game files
    * This should be fairly trivial given you know what you're doing. For example, here's the [UNDERTALE Wingdings font](https://github.com/fachinformatiker/undertale/blob/master/fonts/fnt_wingdings.font.gmx). It has a `.font.gmx` extension.
    * Then, you also want the font sprite! In the case with UNDERTALE, it's a `.png` file. Here's the [UNDERTALE Wingdings sprite](https://github.com/fachinformatiker/undertale/blob/master/fonts/fnt_wingdings.png)
2. Once you have both obtained, look at the file with font data.
    * You're likely to see a bunch of XML data. What you want, is the glyph chunk. ![Image](https://github.com/the-wawa/gamemaker-font-converter/blob/main/images/glyph_data.png?raw=true)
3. Copy everything between `<glyphs>` and `</glyphs>`, then mash it into the `GLYPH_DATA_CHUNK` string.
4. You're basically done! Select the instance you want the module to appear in (default to ServerStorage), paste the script into the console and run it. A `FontData` module will be created with all the data extracted.
5. Final step is to upload the font sprites & set the `image` value in the font data. Past that, your extracted data is ready to use.


What format is the symbol data stored in?
---

The `maxHeight` field corresponds to the maximum height a symbol may have. It can be used for calculating the Y offset to prevent overflowing out of screen bounds.  
The `symbols` table uses the ASCII code as the key, and a table with data as the value.

The symbol data is structured as such:
1. `<Vector2> position` - corresponds to `ImageLabel.ImageRectOffset`
2. `<Vector2> size` - corresponds to `ImageLabel.ImageRectSize`
3. `<Vector2> xOffset` - how far away should the next symbol be displayed