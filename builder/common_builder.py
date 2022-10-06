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

LICENSE_HEADER = """/***************************************************************************
 * This file is part of RefWatchPlus                                       *
 *                                                                         *
 * RefWatchPlus is free software: you can redistribute it and/or modify    *
 * it under the terms of the GNU General Public License as published by    *
 * the Free Software Foundation, either version 3 of the License, or       *
 * (at your option) any later version.                                     *
 *                                                                         *
 * RefWatchPlus is distributed in the hope that it will be useful,         *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 * GNU General Public License for more details.                            *
 *                                                                         *
 * You should have received a copy of the GNU General Public License       *
 * along with RefWatchPlus.  If not, see <https://www.gnu.org/licenses/>.  *
 ***************************************************************************/"""

XML_LICENSE_HEADER = """<!--########################################################################
 * This file is part of RefWatchPlus                                       *
 *                                                                         *
 * RefWatchPlus is free software: you can redistribute it and/or modify    *
 * it under the terms of the GNU General Public License as published by    *
 * the Free Software Foundation, either version 3 of the License, or       *
 * (at your option) any later version.                                     *
 *                                                                         *
 * RefWatchPlus is distributed in the hope that it will be useful,         *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 * GNU General Public License for more details.                            *
 *                                                                         *
 * You should have received a copy of the GNU General Public License       *
 * along with RefWatchPlus.  If not, see <https://www.gnu.org/licenses/>.  *
 #########################################################################-->"""

def getStorageKey(data:dict) :
  return f"{data['name']}_StorageID"


def getStorageId(data:dict) :
  """Returns the string used in Monkey C to get the storageID for the element
  """
  return f"Ui.loadResource(Rez.Strings.{getStorageKey(data)}).toString()"


def getStorageIdStr(data:dict) :
  """Returns the string used in Monkey C to get the storageID String for the element
  """
  return f"{getStorageId(data)}.toString()"


def defGetMenuLabelKey(data:dict) :
  return f"{data['name']}_MenuLabel"

def getMenuLabel(data:dict) :
  return f"Ui.loadResource(Rez.Strings.{data['name']}_MenuLabel)"

def getMenuLabelStr(data:dict) :
  return getMenuLabel(data) + ".toString()"


def getAllTypes(data:dict) :
  """Get all the types from the dict
  """
  lst = []

  for item in data :
    if item['type'] == "menu" :
      types = getAllTypes(item['items'])
      if not types is None :
        lst = lst + [t for t in types if t not in lst]
    else :
      if not item['type'] in lst :
        lst.append(item['type'])
  return lst

def getOrAllTypes (data:dict) :
  types = getAllTypes(data)
  ret = ""
  for t in types :
    ret += t + " or "
  return ret[:-3]

def capFirstLetter(s:str) :
  return s[0].upper() + s[1:]