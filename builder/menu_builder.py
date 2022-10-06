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
from operator import sub
import yaml
import argparse

from common_builder import *

def main() :
  parser = argparse.ArgumentParser(description="Simple tool to create the AppSetting.mc file from a YAML dict")
  parser.add_argument("input", type=str, help="The input yaml file")
  parser.add_argument("output", type=str, help="The output menu directory")
  args = parser.parse_args()

  with open(args.input, "r") as fin :
    data = yaml.safe_load(fin)

  with open(args.output + "Menus.mc", "w") as fout :
    fout.write(LICENSE_HEADER + "\n\n")

    fout.write("using Toybox.WatchUi as Ui;\n\n")
    fout.write("import Toybox.Lang;\n\n")

    fout.write("module Menus {\n")
  
    fout.write("  function itemId(item as Ui.MenuItem) as Symbol {\n")
    fout.write("    return item.getId();\n")
    fout.write("  }\n\n")

    writeMenuFunc(fout, data)
    fout.write("}")

  for m in data :
    createDelegates(args.output, m)


def writeMenuFunc(file:TextIOWrapper, data:dict) :
  """Write the 'get*Menu' function for each Menu
  """
  sub_menus = []


  for m in data :
    if (m['type'] != 'menu') :
      continue
    file.write(f"  function get{capFirstLetter(m['name'])}() as Ui.Menu2 {'{'}\n")
    file.write(f"    var menu = new Ui.Menu2({'{'}:title=>\"{m['label']}\"{'}'});\n\n")
    if (m['has_exit']) :
      file.write(f"    menu.addItem(\n      new Ui.MenuItem(\"{m['exit_label']}\", null, :Exit_MenuID, null)\n    );\n\n")
    for item in m['items'] :
      file.write(f"    menu.addItem(\n")
      if (item['type'] == 'Boolean') :
        file.write(f"      new Ui.ToggleMenuItem(Rez.Strings.{defGetMenuLabelKey(item)}.toString(), null, :{capFirstLetter(item['name'])}_MenuID, AppSettings.get{capFirstLetter(item['name'])}(), null)\n")
      else :
        file.write(f"      new Ui.MenuItem(Rez.Strings.{defGetMenuLabelKey(item)}.toString(), null, :{capFirstLetter(item['name'])}_MenuID, null)\n")
      file.write("    );\n\n")
      if (item['type'] == 'menu') :
        sub_menus.append(item)
    file.write("    return menu;\n")
    file.write("  }\n\n")
    writeMenuFunc(file, sub_menus)


def createDelegates(dir:str, data:dict) :
  if (data['type'] != 'menu') :
    return

  delegateName = capFirstLetter(data['name']) + "InputDelegate"

  with open(dir + delegateName + ".mc", "w") as fout :
    fout.write(LICENSE_HEADER + "\n\n")
    fout.write("using Toybox.WatchUi as Ui;\n\n")
    fout.write("using Menus;\n\n")
    fout.write(f"class {delegateName} extends Ui.Menu2InputDelegate {'{'}\n")
    fout.write("  function initialize() {\n")
    fout.write("    Menu2InputDelegate.initialize();\n")
    fout.write("  }\n\n")

    fout.write("  function onSelect(item as Ui.MenuItem) as Void {\n")

    fout.write("    switch (Menus.itemId(item)) {\n")

    if (data['has_exit']) :
      fout.write("      case :Exit_MenuID :\n")
      fout.write(f"        Ui.pushView(new Ui.Confirmation(\"{data['exit_label']}?\"),\n")
      fout.write(f"                    new ExitConfirmationDelegate(),\n")
      fout.write(f"                    Ui.SLIDE_IMMEDIATE);\n")
      fout.write(f"        break;\n\n")

    for item in data['items'] :
      itemHandler(fout, item)
      if (item['type'] == 'menu') :
        createDelegates(dir, item)

    fout.write("    }\n") # End of Switch

    fout.write("    Ui.requestUpdate();\n")
    fout.write("  }\n") # End of onSelect()

    fout.write("}") # End of class


def itemHandler(file:TextIOWrapper, data:dict) :
  """Write the case statement to handle item selection
  """

  if (data['type'] == 'menu') :
    file.write(f"      case :{capFirstLetter(data['name'])}_MenuID :\n")
    file.write(f"        Ui.pushView(Menus.get{capFirstLetter(data['name'])}(),\n")
    file.write(f"                    new {capFirstLetter(data['name'])}InputDelegate(),\n")
    file.write(f"                    Ui.SLIDE_LEFT);\n")
    file.write(f"        break;\n\n")
  elif (data['type'] == 'Number') :
    file.write(f"      case :{capFirstLetter(data['name'])}_MenuID :\n")
    file.write(f"        Ui.pushView(new NumPicker({getMenuLabelStr(data)}, {getStorageId(data)}),\n")
    file.write(f"                    new NumPickerDelegate({getStorageId(data)}),\n")
    file.write(f"                    Ui.SLIDE_LEFT);\n")
    file.write(f"        break;\n\n")
  elif (data['type'] == 'Boolean') :
    file.write(f"      case :{capFirstLetter(data['name'])}_MenuID :\n")
    file.write(f"        if (item instanceof Ui.ToggleMenuItem) {'{'} AppSettings.set{capFirstLetter(data['name'])}(item.isEnabled()); {'}'}\n")
    file.write(f"        else {'{'} throw new UnexpectedTypeException(\"ToggleMenuItem required to set Boolean {data['name']}\", null, null); {'}'}\n")
    file.write(f"        break;\n\n")
  else :
    raise TypeError(f"Invalid Menu Item Type: {data['type']}")



if __name__ == "__main__" :
  main()