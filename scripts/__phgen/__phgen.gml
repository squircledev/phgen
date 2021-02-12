global.__phgen_sprite_cache = ds_map_create();
global.__phgen_string_cache = ds_map_create();
global.__phgen_sprite_origin_relative = [0, 0];

/// @param ?width
/// @param ?height
/// @param ?color
/// @param ?outline_thickness
/// @param ?outline_color
function phgen_rectangle()
{
	var _width = (argument_count > 0) ? argument[0] : 16;
	var _height = (argument_count > 1) ? argument[1] : 16;
	var _color = (argument_count > 2) ? argument[2] : c_white;
	var _outline_thickness = (argument_count > 3) ? argument[3] : 1;
	var _outline_color = (argument_count > 4) ? argument[4] : _color;
	
	var _map_string = __phgen_map_string("sprRect", _width, _height, _color, _outline_thickness, _outline_color);
	var _map_value = ds_map_find_value(global.__phgen_sprite_cache, _map_string);
	if(_map_value != undefined)
	{
		return _map_value;
	}

	var _surf = surface_create(_width, _height);
	surface_set_target(_surf);
	draw_clear_alpha(_outline_color, 1.0);
	draw_rectangle_color(x + _outline_thickness, y +  _outline_thickness, _width -  _outline_thickness, _height -  _outline_thickness, _color, _color, _color, _color, false);
	surface_reset_target();
	var _spr = sprite_create_from_surface(_surf, 0, 0, _width, _height, false, false, _width*global.__phgen_sprite_origin_relative[0], _height*global.__phgen_sprite_origin_relative[1]);
	ds_map_set(global.__phgen_sprite_cache, _map_string, _spr);
	return _spr;
}

/// @param ?size
/// @param ?color
/// @param ?outline_thickness
/// @param ?outline_color
function phgen_square()
{
	var _width = (argument_count > 0) ? argument[0] : 16;
	var _height = (argument_count > 0) ? argument[0] : 16;
	var _color = (argument_count > 1) ? argument[1] : c_white;
	var _outline_thickness = (argument_count > 2) ? argument[2] : 1;
	var _outline_color = (argument_count > 3) ? argument[3] : _color;
	return phgen_rectangle(_width, _height, _color, _outline_thickness, _outline_color);
}

/// @param ?radius
/// @param ?color
/// @param ?outline_size
/// @param ?outline_color
function phgen_circle()
{
	var _radius = (argument_count > 0) ? argument[0] : 8;
	var _color = (argument_count > 1) ? argument[1] : c_white;
	var _outline_thickness = (argument_count > 2) ? argument[2] : 1;
	var _outline_color = (argument_count > 3) ? argument[3] : _color;
	
	var _map_string = __phgen_map_string("sprCircle", _radius, _color, _outline_thickness, _outline_color);
	var _map_value = ds_map_find_value(global.__phgen_sprite_cache, _map_string);
	if(_map_value != undefined)
	{
		return _map_value;
	}
	
	var _surf = surface_create(_radius * 2, _radius * 2);
	surface_set_target(_surf);
	draw_clear_alpha(c_black, 0.0);
	var _prev_color = draw_get_color();
	draw_set_color(_outline_color);
	draw_circle(_radius, _radius, _radius, false);
	draw_set_color(_color);
	draw_circle(_radius, _radius, _radius-_outline_thickness, false);
	surface_reset_target();
	draw_set_color(_prev_color);
	var _spr = sprite_create_from_surface(_surf, 0, 0, _radius * 2, _radius * 2, false, false,  _radius*2*global.__phgen_sprite_origin_relative[0],_radius*2*global.__phgen_sprite_origin_relative[1]);
	ds_map_set(global.__phgen_sprite_cache, _map_string, _spr);
	return _spr;
}

/*
/// @param ?width
/// @param ?height
/// @param ?color
/// @param ?outline_size
/// @param ?outline_color
function phgen_triangle()
{
	var _width = (argument_count > 0) ? argument[0] : 16;
	var _height = (argument_count > 1) ? argument[1] : 16;
	var _color = (argument_count > 2) ? argument[2] : c_white;
	var _outline_thickness = (argument_count > 3) ? argument[3] : 1;
	var _outline_color = (argument_count > 4) ? argument[4] : _color;
	
	var _map_string = __phgen_map_string("sprRect", _width, _height, _color, _outline_thickness, _outline_color);
	var _map_value = ds_map_find_value(global.__phgen_cache, _map_string);
	if(_map_value != undefined)
	{
		return _map_value;
	}
	
	var _surf = surface_create(_width, _height);
	surface_set_target(_surf);
	draw_clear_alpha(_outline_color, 1.0);
	draw_rectangle_color(x + _outline_thickness, y +  _outline_thickness, _width -  _outline_thickness, _height -  _outline_thickness, _color, _color, _color, _color, false);
	surface_reset_target();
	var _spr = sprite_create_from_surface(_surf, 0, 0, _width, _height, false, false, _width*global.__phgen_sprite_origin_relative[0], _height*global.__phgen_sprite_origin_relative[1]);
	ds_map_set(global.__phgen_cache, _map_string, _spr);
	return _spr;
}
*/

/// @description Sets the relative origin of all newly made sprites (0,0 is top left, 1,1 is bottom right)
/// @param x_origin
/// @param y_origin
function phgen_set_default_relative_origin(_x_origin, _y_origin)
{
	global.__phgen_sprite_origin_relative[0] = _x_origin;
	global.__phgen_sprite_origin_relative[1] = _y_origin;
}

/// @param ?length
function phgen_word(_length)
{
	if (_length == undefined) _length = 6;
	
	var _map_string = __phgen_map_string("strWord", _length);
	var _map_value = ds_map_find_value(global.__phgen_string_cache, _map_string);
	if(_map_value != undefined)
	{
		return _map_value;
	}
	
	var _s = "";
	for(var i = 0; i < _length; i++)
	{
		_s += __phgen_random_letter_lowercase();
	}
	ds_map_set(global.__phgen_string_cache, _map_string, _s);
	return _s;
}

/// @param ?character_count
/// @param ?punctuation
/// @param ?word_length_min
/// @param ?word_length_max
function phgen_sentence(_character_count, _punctuation, _word_length_min, _word_length_max)
{
	if (_character_count == undefined) _character_count = 20;
	if (_punctuation == undefined) _punctuation = true;
	if (_word_length_min == undefined) _word_length_min = 3;
	if (_word_length_max == undefined) _word_length_max = 10;
	
	var _map_string = __phgen_map_string("strSentence", _character_count, _punctuation, _word_length_min, _word_length_max);
	var _map_value = ds_map_find_value(global.__phgen_string_cache, _map_string);
	if(_map_value != undefined)
	{
		return _map_value;
	}
	
	var _s = "";
	if(_punctuation)
	{
		for(var i = 0; i < _character_count; i++)
		{
			var _capitalize = (i == 0);
			var _random_word = __phgen_random_word(irandom_range(_word_length_min, _word_length_max), _capitalize) + choose(" ", ", ", "; ");
			if(string_length(_s + _random_word) >= _character_count - _word_length_min)
			{
				_random_word = __phgen_random_word(_character_count - string_length(_s) - 1, false);
				_random_word += ".";
			}
			_s += _random_word;
			i += string_length(_random_word);
		}
	}
	else
	{
		for(var i = 0; i < _character_count; i++)
		{
			var _random_word = __phgen_random_word(irandom_range(_word_length_min, _word_length_max), false);
			if(i + string_length(_random_word) >= _character_count - _word_length_min)
			{
				_random_word = __phgen_random_word(_character_count - i, false);
			}
			_s += _random_word;
			i += string_length(_random_word);
		}
	}
	
	ds_map_set(global.__phgen_string_cache, _map_string, _s);
	return _s;
}

/// @description Removes generated sprite from the cache, but this is costly so dont do it too often... but it's also placeholder stuff so who cares really?
/// @param sprite_index
function phgen_cache_remove_sprite(_sprite_index)
{
	var _keys = ds_map_keys_to_array(global.__phgen_sprite_cache);
	var _found_key = undefined;
	for(var i = 0; i < array_length(_keys); i++)
	{
		if(ds_map_find_value(global.__phgen_sprite_cache, _keys[i]) == _sprite_index)
		{
			_found_key = _keys[i];
			break;
		}
	}
	sprite_delete(_sprite_index);
	ds_map_delete(global.__phgen_sprite_cache, _found_key);
}

/// @description Removes generated string from the cache, but this is costly so dont do it too often... but it's also placeholder stuff so who cares really?
/// @param string
function phgen_cache_remove_string(_string)
{
	var _keys = ds_map_keys_to_array(global.__phgen_string_cache);
	var _found_key = undefined;
	for(var i = 0; i < array_length(_keys); i++)
	{
		if(ds_map_find_value(global.__phgen_string_cache, _keys[i]) == _string)
		{
			_found_key = _keys[i];
			break;
		}
	}
	ds_map_delete(global.__phgen_string_cache, _found_key);
}

/// @param ...values
function __phgen_map_string()
{
	var _s = "";
	for(var i = 0; i < argument_count; i++)
	{
		_s += string(argument[i]);
	}
	return _s;
}

function __phgen_random_letter_uppercase()
{
	return chr(irandom_range(65, 90));
}

function __phgen_random_letter_lowercase()
{
	return chr(irandom_range(97, 122));
}

function __phgen_random_word(_length, _capital_first)
{
	var _w = "";
	var _i = 0;
	if(_capital_first)
	{
		_w += __phgen_random_letter_uppercase();
		_i += 1;
	}
	
	for(var i = _i; i < _length; i++)
	{
		_w += __phgen_random_letter_lowercase();
	}
	return _w;
}