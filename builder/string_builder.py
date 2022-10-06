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
  parser.add_argument("output", type=str, help="The output XML file")
  args = parser.parse_args()

  with open(args.input, "r") as fin :
    data = yaml.safe_load(fin)

  with open(args.output, "w") as fout :
    fout.write(XML_LICENSE_HEADER + "\n\n")

    fout.write("<strings>\n")

    writeStorageIdStrings(fout, data)

    writeMenuStrings(fout, data)

    fout.write("</strings>\n")


def writeStorageIdStrings(file:TextIOWrapper, data:dict) :
  """Write the Storage ID Strings for each setting
  """
  for item in data :
    if (item['type'] == 'menu') :
      writeStorageIdStrings(file, item['items'])
    else :
      file.write(f"  <string id=\"{getStorageKey(item)}\">{item['name']}</string>")
    file.write("\n")


def writeMenuStrings(file:TextIOWrapper, data:dict) :
  """Write the Menu Label Strings for each setting
  """
  for item in data :
    if (item['type'] == 'menu') :
      file.write(f"  <string id=\"{defGetMenuLabelKey(item)}\">{item['label']}</string>\n")
      writeMenuStrings(file, item['items'])
    else :
      file.write(f"  <string id=\"{defGetMenuLabelKey(item)}\">{item['label']}</string>")
    file.write("\n")


if __name__ == "__main__" :
  main()