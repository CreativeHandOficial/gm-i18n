/// @function importJson(file_name, func)
/// @param {string} _file_name		the file to get the json data from
/// @param {func}	_func			the function to use on the string
/// @description imports json data form a file. Pass json_decode
///			to return the data as maps and lists. Pass json_parse to 
///			return the data as arrays and structs.
function importJson(_file_name, _func) {
	if (file_exists(_file_name)) {
		var _file, _json_string;
		_file = file_text_open_read(_file_name);
		_json_string = "";
		while (!file_text_eof(_file)) {
			_json_string += file_text_read_string(_file);
			file_text_readln(_file);
		}
		file_text_close(_file);
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
function exportJson(_file_name, _data, _func) {
	var _file = file_text_open_write(_file_name);
	file_text_write_string(_file, script_execute(_func, _data));
	file_text_close(_file);
}

function deleteLocalesFiles() {
	if (file_exists(FILE_LOCALE)) {
		file_delete(FILE_LOCALE);
		show_debug_message("//////// INFO ////////");
		show_debug_message(string(FILE_LOCALE) + "Has deleted!")
		show_debug_message("////////////////");
	}
}
