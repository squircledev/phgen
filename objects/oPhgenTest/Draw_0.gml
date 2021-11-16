draw_sprite(phgen_rectangle(64, 32, c_red, 3, c_purple), 0, 0, 0);
draw_sprite(phgen_square(64, c_orange, 16, c_blue), 0, 0, 64);
draw_sprite(phgen_circle(32, c_yellow, 12, c_maroon), 0, 0, 128);
draw_sprite(phgen_rectangle(), 0, 0, 192);
draw_sprite(phgen_pill(256, 48, c_black, 5, c_red), 0, 0, 216);

draw_text(0, 256, phgen_word());
draw_text(0, 256+64, phgen_sentence());