global.__phgen_sprite_map = ds_map_create();
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
	var _map_string = __phgen_map_string("rect", _width, _height, _color, _outline_thickness, _outline_color);
	if(ds_map_find_value(global.__phgen_sprite_map, _map_string))
	{
		return global.__phgen_sprite_map[? _map_string];
	}
	else
	{
		var _surf = surface_create(_width, _height);
		surface_set_target(_surf);
		draw_clear_alpha(_outline_color, 1.0);
		draw_rectangle_color(x + _outline_thickness, y +  _outline_thickness, _width -  _outline_thickness, _height -  _outline_thickness, _color, _color, _color, _color, false);
		surface_reset_target();
		var _spr = sprite_create_from_surface(_surf, 0, 0, _width, _height, false, false, _width*global.__phgen_sprite_origin_relative[0], _height*global.__phgen_sprite_origin_relative[1]);
		ds_map_set(global.__phgen_sprite_map, _map_string, _spr);
		return _spr;
	}
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
	var _map_string = __phgen_map_string("circle", _radius, _color, _outline_thickness, _outline_color);
	if(ds_map_find_value(global.__phgen_sprite_map, _map_string))
	{
		return global.__phgen_sprite_map[? _map_string];
	}
	else
	{
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
		ds_map_set(global.__phgen_sprite_map, _map_string, _spr);
		return _spr;
	}
}

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
	var _map_string = __phgen_map_string("rect", _width, _height, _color, _outline_thickness, _outline_color);
	if(ds_map_find_value(global.__phgen_sprite_map, _map_string))
	{
		return global.__phgen_sprite_map[? _map_string];
	}
	else
	{
		var _surf = surface_create(_width, _height);
		surface_set_target(_surf);
		draw_clear_alpha(_outline_color, 1.0);
		draw_rectangle_color(x + _outline_thickness, y +  _outline_thickness, _width -  _outline_thickness, _height -  _outline_thickness, _color, _color, _color, _color, false);
		surface_reset_target();
		var _spr = sprite_create_from_surface(_surf, 0, 0, _width, _height, false, false, _width*global.__phgen_sprite_origin_relative[0], _height*global.__phgen_sprite_origin_relative[1]);
		ds_map_set(global.__phgen_sprite_map, _map_string, _spr);
		return _spr;
	}
}

/// @description Sets the relative origin of all newly made sprites (0,0 is top left, 1,1 is bottom right)
/// @param x_origin
/// @param y_origin
function phgen_set_default_relative_origin(_x_origin, _y_origin)
{
	global.__phgen_sprite_origin_relative[0] = _x_origin;
	global.__phgen_sprite_origin_relative[1] = _y_origin;
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