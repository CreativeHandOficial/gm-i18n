/// @function importJson(file_name, func)
/// @param {string} _file_name		the file to get the json data from
/// @param {func}	_func			the function to use on the string
/// @description imports json data form a file. Pass json_decode
///			to return the data as maps and lists. Pass json_parse to 
///			return the data as arrays and structs.
/// @author https://github.com/samspadegamedev
function importJson(_file_name, _func) {
	if (file_exists(_file_name)) {
        var _buffer = buffer_load(_file_name);
        var _json_string = buffer_read(_buffer, buffer_string);
        buffer_delete(_buffer);
		return script_execute(_func, _json_string);
	}
	return undefined;
}
	
	
/// @function exportJson(file_name, data, func)
/// @param {string} _file_name		the file to save the json data to
/// @param {struct/array/map} _data	the data to save as json data
/// @param {func}	_func			the function to use on the data
/// @description saves json data to a file. Pass a map and json_encode
///			to return save json data stored as maps and lists. Pass an 
///			array or struct and json_parse to save the data stored 
///			as arrays and structs.	
/// @author https://github.com/samspadegamedev
function exportJson(_file_name, _data, _func) {
    var _buffer = buffer_create(string_byte_length(_data)+1, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, script_execute(_func, _data));
    buffer_save(_buffer, _file_name);
}


/// @function explode(_delimiter, _string)
/// @description  Returns an array of strings parsed from a given 
/// string of elements separated by a delimiter.
///
/// @param	{string} _delimiter   delimiter character
/// @param  {string} _string      group of elements
/// @author GMLscripts.com/license
function explode() {
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