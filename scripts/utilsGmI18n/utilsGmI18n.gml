/// @function gmi18n_importJson(file_name, func)
/// @param {string} _file_name		the file to get the json data from
/// @param {func}	_func			the function to use on the string
function gmi18n_importJson(_file_name, _func) {
	if (file_exists(_file_name)) {
    var _buffer = buffer_load(_file_name);
    var _json_string = buffer_read(_buffer, buffer_string);
    buffer_delete(_buffer);
		return script_execute(_func, _json_string);
	}
	return undefined;
}
	
	
/// @function gmi18n_exportJson(file_name, data, func)
/// @param {string} _file_name		the file to save the json data to
/// @param {struct/array/map} _data	the data to save as json data
/// @param {func}	_func			the function to use on the data
function gmi18n_exportJson(_file_name, _data, _func) {
	var _data_string = script_execute(_func, _data);
    var _buffer = buffer_create(string_byte_length(_data_string) + 1, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, _data_string);
    buffer_save(_buffer, _file_name);
}


/// @function gmi18n_explode(_delimiter, _string)
/// @description  Returns an array of strings parsed from a given 
/// string of elements separated by a delimiter.
///
/// @param	{string} _delimiter   delimiter character
/// @param  {string} _string      group of elements
/// @author GMLscripts.com/license
function gmi18n_explode() {
    var arr;
    var del = argument[0];
    var str = argument[1] + del;
    var len = string_length(del);
    var ind = 0;
    repeat (string_count(del, str)) {
        var pos = string_pos(del, str) - 1;
        arr[ind] = string_copy(str, 1, pos);
        str = string_delete(str, 1, pos + len);
        ind++;
    }
    return arr;
}