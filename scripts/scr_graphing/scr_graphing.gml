/// @description						Graphs the data contained in the array.
/// @param {Array<Real>}	_arr		A numerical array.
/// @param {Real}			_x			The x coordinate of the upper-left corner of the graph.
/// @param {Real}			_y			The y coordinate of the upper-left corner of the graph.
/// @param {Real}			_w			The width of the graphing area.
/// @param {Real}			_h			The height of the graphing area.
/// @param {Real}			[_cushion]	The distance between the max value and the top of the graph.
/// @param {Real}			[_maxValue]	The maximum value for the data. If not set, the max value will be automatically determined.
/// @returns							Returns the y position of the final point on the graph.

function graph(_arr, _x, _y, _w, _h, _cushion = 0, _maxValue = undefined) {
    var xStep = _w / array_length(_arr)
	if (_maxValue == undefined) {
		_maxValue = _arr[0]
		for (var i = 1; i < array_length(_arr); ++i) {
		    if (_arr[i] > _maxValue)
				_maxValue = _arr[i]
		}
	}
	var minimum = _arr[0]
	for (var i = 0; i < array_length(_arr) - 1; ++i) {
	    draw_line_width(_x + xStep * i, _y + _h - (_h - _cushion) * (_arr[i] / _maxValue), 
				_x + xStep * (i + 1), _y + _h - (_h - _cushion) * (_arr[i + 1] / _maxValue), 2)
				
		if (_arr[i] < minimum)
			minimum = _arr[i]
	}
	return {
		_maxValue: _maxValue,
		_minValue: minimum,
	    _yFinal: _y + _h - (_h - _cushion) * (array_last(_arr) / _maxValue)
	}
}

function multigraph(_arrs, _x, _y, _w, _h, _cushion = 0, _colors = undefined, _maxValues = undefined) {
    for (var i = 0; i < array_length(_arrs); ++i) {
		if (_colors != undefined) {
		    draw_set_color(_colors[i])
		}
	    graph(_arrs[i], _x, _y, _w, _h, _cushion * (i + 1), (_maxValues != undefined) ? _maxValues[i] : undefined)
	}
}

function multigraph_full(_arrs, _x, _y, _w, _h, _cushion = 0, _bkg = undefined, _colors = undefined, _maxValues = undefined) {
   	var graphCutoff = array_length(_arrs) * 15
	_w -= graphCutoff
	_h -= graphCutoff
	
	draw_set_color((_bkg == undefined) ? c_black : _bkg)
	draw_rectangle(_x, _y, _x + _w, _y + _h, false)
	
	draw_set_color(c_white)
	draw_line(_x, _y, _x, _y + _h)
	draw_line(_x, _y + _h, _x + _w, _y + _h)
	
	for (var i = 0; i < array_length(_arrs); ++i) {
		if (_colors != undefined) {
		    draw_set_color(_colors[i])
		}
	    var data = graph(_arrs[i], _x, _y, _w, _h, _cushion * (i + 1), (_maxValues != undefined) ? _maxValues[i] : undefined)
		draw_line_width(_x + _w, data._yFinal, _x + _w + 15 * i + 5, _y + _h, 2)
		draw_text_transformed(_x + _w + 15 * (i + 1), _y + _h, string(array_last(_arrs[i])), 1, 1, 270)
		
		draw_rectangle(_x, _y + _h + i * 15 + 5, _x + 10, _y + _h + i * 15 + 15, false)
		draw_text(_x + 15, _y + _h + i * 15, string(data._minValue) + " to " + string(data._maxValue))

	}
}