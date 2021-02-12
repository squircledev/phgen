# phgen
a placeholder asset generation script for Game Maker Studio 2.3+

![placeholder examples](https://i.imgur.com/KDXZ3u2.png)

# Description

This script will generate cached sprites and strings for you. As long as you use the same settings, they will stay the same and won't come at a large performance cost. Due to how sprite_create_from_surface works, there will still be a performance hit, but since this is for prototyping, that isn't be much of an issue.

# Usage

## Sprites

phgen_rectangle (and the other sprite generators) generate a sprite_index.

``draw_sprite(phgen_rectangle(), 0, 0, 0);``

The above code will draw a default rectangle sprite it generates, and then on all subsequent calls with the same settings, uses a cached sprite.

## Strings

phgen_word and phgen_sentence generate cached strings for you. 

``draw_text(0, 0, phgen_sentence());``

As long as you use the same settings, the sentence will stay the same. If you want the sentence to change, do this:

``phgen_cache_remove_string(phgen_sentence());``

This will clear the cache of that string and generate a new one next time you call the string generator function with the same settings.
