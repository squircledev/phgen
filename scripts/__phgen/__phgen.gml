global.__phgen_sprite_cache = ds_map_create();
global.__phgen_string_cache = ds_map_create();

/// @param {number} width=16
/// @param {number} height=16
/// @param {int} color=c_white
/// @param {number} outline_size=1
/// @param {int} outline_color=color
/// @param {number} x_origin_relative=0
/// @param {number} y_origin_relative=0
/// @returns {sprite} sprite_index
function phgen_rectangle(_width=16, _height=16, _color=c_white, _outline_size=1, _outline_color=_color, _x_origin_relative=0, _y_origin_relative=0)
{
	__phgen_map_check();

	var _map_string = __phgen_map_string("sprRect", _width, _height, _color, _outline_size, _outline_color);
	var _map_value = ds_map_find_value(global.__phgen_sprite_cache, _map_string);
	if(_map_value != undefined)
	{
		return _map_value;
	}

	var _surf = surface_create(_width, _height);
	surface_set_target(_surf);
	draw_clear_alpha(_outline_color, 1.0);
	draw_rectangle_color(_outline_size, _outline_size, _width -  _outline_size - 1, _height -  _outline_size - 1, _color, _color, _color, _color, false);
	surface_reset_target();
	var _spr = sprite_create_from_surface(_surf, 0, 0, _width, _height, false, false, _x_origin_relative, _y_origin_relative);
	ds_map_set(global.__phgen_sprite_cache, _map_string, _spr);
	return _spr;
}

/// @param {number} size=16
/// @param {int} color=c_white
/// @param {number} outline_size=1
/// @param {int} outline_color=color
/// @param {number} x_origin_relative=0
/// @param {number} y_origin_relative=0
/// @returns {sprite} sprite_index
function phgen_square(_size=16, _color=c_white, _outline_size=1, _outline_color=_color, _x_origin_relative=0, _y_origin_relative=0)
{
	__phgen_map_check();
	
	return phgen_rectangle(_size, _size, _color, _outline_size, _outline_color, _x_origin_relative, _y_origin_relative);
}

/// @param {number} radius=8
/// @param {int} color=c_white
/// @param {number} outline_size=1
/// @param {int} outline_color=color
/// @param {number} x_origin_relative=0
/// @param {number} y_origin_relative=0
/// @returns {sprite} sprite_index
function phgen_circle(_radius=8, _color=c_white, _outline_size=1, _outline_color=_color, _x_origin_relative=0, _y_origin_relative=0)
{
	__phgen_map_check();
	
	var _map_string = __phgen_map_string("sprCircle", _radius, _color, _outline_size, _outline_color);
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
	draw_circle(_radius, _radius, _radius-_outline_size, false);
	surface_reset_target();
	draw_set_color(_prev_color);
	var _spr = sprite_create_from_surface(_surf, 0, 0, _radius * 2, _radius * 2, false, false,  _x_origin_relative, _y_origin_relative);
	ds_map_set(global.__phgen_sprite_cache, _map_string, _spr);
	return _spr;
}

/// @param {number} width=32
/// @param {number} height=16
/// @param {int} color=c_white
/// @param {number} outline_size=1
/// @param {int} outline_color=color
/// @param {number} x_origin_relative=0
/// @param {number} y_origin_relative=0
/// @returns {sprite} sprite_index
function phgen_pill(_width=32, _height=16, _color=c_white, _outline_size=1, _outline_color=_color, _x_origin_relative=0, _y_origin_relative=0)
{
	__phgen_map_check();
	
	var _map_string = __phgen_map_string("sprPill", _width, _height, _color, _outline_size, _outline_color);
	var _map_value = ds_map_find_value(global.__phgen_sprite_cache, _map_string);
	if(_map_value != undefined)
	{
		return _map_value;
	}
	
	var _radius = min(_width, _height) / 2;
	
	if(_height < _width)
	{
		var _c1x = _radius;
		var _c1y = _radius;
		
		var _c2x = _width - _c1x;
		var _c2y = _radius;
		
		var _rx1 = _c1x;
		var _ry1 = 0;
		var _rx2 = _c2x;
		var _ry2 = _height - 1;
	}
	else
	{
		var _c1x = _radius;
		var _c1y = _radius;
		
		var _c2x = _radius;
		var _c2y = _height - _c1y;
		
		var _rx1 = 0;
		var _ry1 = _c1y;
		var _rx2 = _width - 1;
		var _ry2 = _c2y;
	}
	
	var _surf = surface_create(_width, _height);
	surface_set_target(_surf);
	draw_clear_alpha(c_black, 0.0);
	var _prev_color = draw_get_color();
	draw_set_color(_outline_color);
	draw_circle(_c1x, _c1y, _radius, false);
	draw_circle(_c2x, _c2y, _radius, false);
	draw_rectangle(_rx1, _ry1, _rx2, _ry2, false);
	draw_set_color(_color);
	draw_circle(_c1x, _c1y, _radius - _outline_size, false);
	draw_circle(_c2x, _c2y, _radius - _outline_size, false);
	draw_rectangle(_rx1 + _outline_size, _ry1 + _outline_size, _rx2 - _outline_size, _ry2 - _outline_size, false);
	surface_reset_target();
	draw_set_color(_prev_color);
	var _spr = sprite_create_from_surface(_surf, 0, 0, _width, _height, false, false,  _x_origin_relative, _y_origin_relative);
	ds_map_set(global.__phgen_sprite_cache, _map_string, _spr);
	return _spr;
}

/// @param {int} length=6
/// @returns {string}
function phgen_word(_length=6)
{
	__phgen_map_check();

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

/// @param {int} length=6
/// @returns {string}
function phgen_number_string(_length=6)
{
	__phgen_map_check();
	
	var _map_string = __phgen_map_string("strNumbers", _length);
	var _map_value = ds_map_find_value(global.__phgen_string_cache, _map_string);
	if(_map_value != undefined)
	{
		return _map_value;
	}
	
	var _s = "";
	for(var i = 0; i < _length; i++)
	{
		_s += __phgen_random_number();
	}
	ds_map_set(global.__phgen_string_cache, _map_string, _s);
	return _s;
}

/// @param {int} character_count=20
/// @param {bool} punctuation=true
/// @param {int} word_length_min=3
/// @param {int} word_length_max=10
/// @returns {string}
function phgen_sentence(_character_count=20, _punctuation=true, _word_length_min=3, _word_length_max=10)
{
	__phgen_map_check();
	
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

/// @function phgen_cache_remove_sprite(sprite_index)
/// @description Removes generated sprite from the cache, but this is costly so dont do it too often... but it's also placeholder stuff so who cares really?
/// @param sprite_index
function phgen_cache_remove_sprite(_sprite_index)
{
	__phgen_map_check();
	
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
	if(sprite_exists(_sprite_index))
	{
		sprite_delete(_sprite_index);
	}
	if(_found_key != undefined)
	{
		ds_map_delete(global.__phgen_sprite_cache, _found_key);
	}
}

/// @function phgen_cache_remove_string(string)
/// @description Removes generated string from the cache, but this is costly so dont do it too often... but it's also placeholder stuff so who cares really?
/// @param string
function phgen_cache_remove_string(_string)
{
	__phgen_map_check();
	
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
	if(_found_key != undefined)
	{
		ds_map_delete(global.__phgen_string_cache, _found_key);
	}
}

function phgen_cache_clear()
{
	__phgen_map_check();
	var _keys = ds_map_keys_to_array(global.__phgen_sprite_cache);
	for(var i = 0; i < array_length(_keys); i++)
	{
		sprite_delete(ds_map_find_value(global.__phgen_sprite_cache, _keys[i]));
	}
	ds_map_clear(global.__phgen_sprite_cache);
	ds_map_clear(global.__phgen_string_cache);
}

function __phgen_map_check()
{
	if(ds_exists(global.__phgen_sprite_cache, ds_type_map) == false)
	{
		global.__phgen_sprite_cache = ds_map_create();
	}
	if(ds_exists(global.__phgen_string_cache, ds_type_map) == false)
	{
		global.__phgen_string_cache = ds_map_create();
	}
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

function __phgen_random_number()
{
	return chr(irandom_range(48, 57));
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