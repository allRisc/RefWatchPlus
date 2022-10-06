###########################################################################
# This file is part of RefWatchPlus                                       #
#                                                                         #
# RefWatchPlus is free software: you can redistribute it and/or modify    #
# it under the terms of the GNU General Public License as published by    #
# the Free Software Foundation, either version 3 of the License, or       #
# (at your option) any later version.                                     #
#                                                                         #
# RefWatchPlus is distributed in the hope that it will be useful,         #
# but WITHOUT ANY WARRANTY; without even the implied warranty of          #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           #
# GNU General Public License for more details.                            #
#                                                                         #
# You should have received a copy of the GNU General Public License       #
# along with RefWatchPlus.  If not, see <https://www.gnu.org/licenses/>.  #
###########################################################################

from io import TextIOWrapper
import yaml
import argparse

from common_builder import *

def main() :
  parser = argparse.ArgumentParser(description="Simple tool to create the AppSetting.mc file from a YAML dict")
  parser.add_argument("input", type=str, help="The input yaml file")
  parser.add_argument("output", type=str, help="The output MonkeyC file")
  args = parser.parse_args()

  with open(args.input, "r") as fin :
    data = yaml.safe_load(fin)

  with open(args.output, "w") as fout :
    fout.write(LICENSE_HEADER + "\n\n")

    writeImports(fout)
    fout.write("\n")

    fout.write("class AppSettings {\n")

    writeSettingVars(fout, data)

    fout.write("  function initialize() {\n")
    fout.write("    AppSettings.initAppSettings();\n")
    fout.write("  }\n\n")

    fout.write("  static function initAppSettings() as Void {\n")
    writeInitAppSettings(fout, data)
    fout.write("  }\n\n")

    fout.write(f"  static function get(id as String) as {getOrAllTypes(data)} {'{'}\n")
    fout.write("    switch (id) {\n")
    writeGet(fout, data)
    fout.write("    }\n")
    fout.write("  }\n\n")

    fout.write(f"  static function set(id as String, val as {getOrAllTypes(data)}) as Void {'{'}\n")
    fout.write("    switch (id) {\n")
    writeSet(fout, data)
    fout.write("    }\n")
    fout.write("  }\n\n")

    fout.write("  // Getter Methods\n")
    writeGetters(fout, data)

    fout.write("\n")

    fout.write("  // Setter Methods\n")
    writeSetters(fout, data)

    fout.write("}")


def writeImports(file:TextIOWrapper) :
  """Write the necessary 'using' statements
  """
  file.write("import Toybox.System;\n")
  file.write("import Toybox.Lang;\n")

  file.write("using Toybox.Application.Storage as Store;\n")
  file.write("using Toybox.WatchUi as Ui;\n")


def writeSettingVars(file:TextIOWrapper, data:dict) :
  """Write the 'hidden static vars' for each setting
  """
  for item in data :
    if (item['type'] == 'menu') :
      writeSettingVars(file, item['items'])
    else :
      file.write(f"  hidden static var {item['name']} as {item['type']}?;")
    file.write("\n")


def writeInitAppSettings(file:TextIOWrapper, data:dict) :
  """Write the 'initAppSettings' static function body
  """
  for item in data :
    if (item['type'] == 'menu') :
      writeInitAppSettings(file, item['items'])
    else :
      file.write(f"    {item['name']} = Store.getValue({getStorageId(item)});\n")
      file.write(f"    if ({item['name']} == null) {'{'}\n")
      file.write(f"      set{capFirstLetter(item['name'])}({str(item['default']).lower()});\n")
      file.write(f"    {'}'}\n\n")


def writeGet(file:TextIOWrapper, data:dict) :
  """Write the 'get(id)' static function body
  """
  for item in data :
    if (item['type'] == 'menu') :
      writeGet(file, item['items'])
    else :
      file.write(f"      case {getStorageIdStr(item)} :\n")
      file.write(f"        return {item['name']};\n")


def writeSet(file:TextIOWrapper, data:dict) :
  """Write the 'set(id, val)' static function body
  """
  for item in data :
    if (item['type'] == 'menu') :
      writeSet(file, item['items'])
    else :
      file.write(f"      case {getStorageId(item)} :\n")
      file.write(f"        if (val instanceof {item['type']}) {'{'} set{capFirstLetter(item['name'])}(val); {'}'} else {'{'} throw new UnexpectedTypeException(\"{item['name']} expected {item['type']}\", null, null); {'}'}\n")
      file.write(f"        break;\n")


def writeGetters(file:TextIOWrapper, data:dict) :
  """Write the 'getter' static functions
  """
  for item in data :
    if (item['type'] == 'menu') :
      writeGetters(file, item['items'])
    else :
      file.write(f"  static function get{capFirstLetter(item['name'])}() as {item['type']} {'{'}\n")
      file.write(f"    return {item['name']};\n")
      file.write(f"  {'}'}\n\n")


def writeSetters(file:TextIOWrapper, data:dict) :
  """Write the 'getter' static functions
  """
  for item in data :
    if (item['type'] == 'menu') :
      writeSetters(file, item['items'])
    else :
      file.write(f"  static function set{capFirstLetter(item['name'])}(val as {item['type']}) as Void {'{'}\n")
      file.write(f"    {item['name']} = val;\n")
      file.write(f"    Store.setValue({getStorageId(item)}, val);\n")
      file.write(f"  {'}'}\n\n")


if __name__ == "__main__" :
  main()