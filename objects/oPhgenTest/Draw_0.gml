draw_sprite(phgen_rectangle(64, 32, c_red, 8, c_purple), 0, 0, 0);
draw_sprite(phgen_square(64, c_orange, 16, c_blue), 0, 0, 64);
draw_sprite(phgen_circle(32, c_yellow, 12, c_maroon), 0, 0, 128);
draw_sprite(phgen_rectangle(), 0, 0, 192);
var _sentence = phgen_sentence();
if(string_length(_sentence) != 20)
{
    show_error("YOU FUCKED UP ITS SUPPOSED TO BE 20 NOT " + string(string_length(_sentence)), true);
}
draw_text(0, 256, phgen_word());
phgen_cache_remove_string(phgen_word());
draw_text(0, 256+64, phgen_sentence());
phgen_cache_remove_string(phgen_sentence());