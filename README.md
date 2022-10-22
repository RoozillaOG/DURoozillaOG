# DURoozillOG lua Code and Modules

# Overview

This repo contains a number of lua modules, PB and Display modules, helper powershell modules.

The Repo contains some mostly industrual management lua code for now. It also contains helper code for constructing, deconstructing PB and Display files.

The latter is for speed of development to/from the DU game and to allow for reuse of requires that are part of the repo (code deduplication if that is a word).

# Directories and Files

## Controllers
Right now there are two primary controllers. The ContainerManager and the MultipleStocker. Please see their individual README.md linked below for more details.

### [Controllers/ContainerManager](./Controllers/ContainerManager/README.md)
This is used to manage contrainer data via updating a DataBank. It also automatically transfers items from a source container to a destination container.

### [Controllers/MultipleStocker](./Controllers/MultipleStocker/README.md)
This is used to manage *n* Industry units (i.e. Metalworks, Refiner...) and maintain a desired quantity of output products in the output container as long as input resources are available.

### Notes
Read the Development Support section below to see how you can quickly update the source code and the game without a lot of manual updating.

## Development Support
### ./build2.psm1  
This is a powershell modules containing a number of helper cmdlets for working with lua element lists, constructing and deconstructing PB files and Display files. It contains a set of cmdlets. To use type:
```
Import-Module -Force ./Build2.psmq
```
---
#### Table Generation
```
ConvertTo-LuaTable [-Name] <string> [-Jsonfile] <string>  [<CommonParameters>]
```
This is used to convert json files downloaded from [du-lua.dev](https://du-lua.dev/#/items) and create a lua file containing tables of the elements from the list in order to map from display names to id and back. It creates a class with -Name that contains these and also a few helper methods for mapping.

```
getId(displayName)
getDisplayName(id)
```

You can see an example of this at [./Elements/PureResources.lua](./Elements/PureResources.lua)

---

#### Working with PB (Programing Board) files
These are useful for working with PB files to/from DU. In general they handle pulling in any requires you have referenced that are part of the same repo and replacing the code inline. Most of the code goes into the unit.* file which is globally available to PB at that point. It also handles updating the code in DU and in the repo depending on the command.

WARNING - when you have shared code here you need to make sure that you update the repo after you have made changes in the lua editor in DU on a per PB or Display basis. Because **requires** are shared between all of the other PB directories if you make updates to multiple the result code will be whatever the last deconstruct produced.

---

```
Invoke-PBDeconstruct [[-Path] <string>] [[-Overwrite] <bool>] [-FromClipboard]
```
This is used to port code from in game to the repository. It will parse the PB file, identify and update all the lua files including onces brought in by require. If you are curious you can see the --== sections in code that are used as hints to what file the code originated from. Make sure you do not remove these.

Typically this is a starting point for a new PB as well. You have set up a PB in DU, linked some things to it, and then you will run this command in a new directory to initialize.

The process is:

1. on the PB, right click and select advanced->Copy Lua configuration to clipboard
2. cd into the directory where you PB is, then run
```
Invoke-PBDeconstruct -FromClipboard
```
Thats it, hopefully.. :)

---

```
Invoke-PBConstruct [[-Path] <string>] [-ToClipboard]
```
This is used to do, well, the opposite of the previous command. You have made updates in Visual Studio Code or other editor, and now want to update that into the game.
Basically it will parse all of the lua files including requires and insert the code into the PB file.

1. Update your code
2. Run
```
Invoke-PBConstruct -ToClipboard
```
3. In DU, right click the PB, select advanced->Paste Lua configuration from clipboard
4. Deactivate and reactivate the PB to run the new code
5. In my case normally fix the error in the script reported by DU :)

---

#### Working with Displays/Screens
This is used similarly to the PB cmdlets to move code to/from the game and your development environment. For me, I am addicted to intellisense so I will do code first in VS code. It also allows to reuse of common elements (like UiTable.lua) and avoid copy/paste and duplicate code.

---

```
Invoke-DisplayDeconstruct [[-Path] <string>] [-FromClipboard]
```

This is used to take code from DU and update the repository with it. It also handles updating any code from the repo that was included with **require** statements.
1. Ctrl-L on your display
2. Ctrl-A, Ctrl-C to copy
3. cd into your directory where you keep this PB and run:
```
Invoke-DisplayDeconstruct -FromClipboard
```
4. Files should be updated
5. Recommend making a commit to preserve checkpoint
```
git add --all; git commit -m "checkpoint"
```

---

```
Invoke-DisplayConstruct [[-Path] <string>] [-ToClipboard]
```
This handles taking your code in the repo and constructing a single file that you can paste into the Screen/Display in DU
1. Make your code updates
2. Copy the merge code to clipboard
```
Invoke-DisplayConstruct -ToClipboard
```
3. Go into DU
4. Ctrl-l on the screen/display
5. Ctrl-a, Ctrl-v to paste the code into the display
5. Apply


## Lua Support

### [Utils](./Utils)
Contains some helper classes.

1. Resource files like [Products.json](./Utils/Products.json) used to provide mapping between **id**s and **Display Names** in DU.
2. [Utils.lua](./Utils/Utils.lua) used to house random helper functions

### [Data](./Data)
Contains some classes for working with DataGrids. These are used to serialize and deserialize between display and PB, specifically for use with setScriptInput() and getScriptInput(). The display stuff is pretty clunky and I would like to see that you could access a DataBank (maybe you can, I have not figured it out) in order to get the data you want and not hit the measly 1024 character limit.

1. [DataGrid](./Data/DataGrid.lua) is used to house a set of rows and columns. It is made up of [DataRows](./Data/DataRow.lua) This is also the data source for [UiTable2.lua](./Ui/UiTable2.lua) covered later.
2. [DataRow](./Data/DataRow.lua) is used to represent a single row in 

## Code Documentation
Documentation is available [here](./doc/index.html) using ldoc as the generator.
