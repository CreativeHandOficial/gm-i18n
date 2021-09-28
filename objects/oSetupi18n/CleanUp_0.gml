/// Deleting Structures and Data Structures

// Data Structures
if (ds_exists(global.__localizationStringCache, ds_type_map)) ds_map_destroy(global.__localizationStringCache);
if (ds_exists(global.__languageStatics, ds_type_map)) ds_map_destroy(global.__languageStatics);

// Struct
delete global.__translator;
delete global.__translatorFallBackLocale;

show_debug_message("HERE");