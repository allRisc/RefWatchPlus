
SOURCE_FILE := menus.yaml

STRINGS_FILE := ../resources/strings/setting_strings.xml
SETTINGS_FILE := ../source/AppSettings.mc
MENU_FILE := ../source/ui/menus/menus.mc

all : ${STRINGS_FILE} ${SETTINGS_FILE} ${MENU_FILE}

${STRINGS_FILE} : ${SOURCE_FILE} string_builder.py
	python string_builder.py $< $@

${SETTINGS_FILE} : ${SOURCE_FILE} settings_builder.py
	python settings_builder.py $< $@

${MENU_FILE} : ${SOURCE_FILE} menu_builder.py
	python menu_builder.py $< $(dir $@)