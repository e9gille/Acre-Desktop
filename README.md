#  ![](/images/logo/logo32.png) Acre Desktop

## Introduction
Acre Desktop is an enhancement to the Dyalog APL IDE, delivered as a small set of user commands,
that introduces the concept of a **project**, and stores code outside the workspace in plain text files.
It makes working with 3rd party source code management (SCM) systems like Git easy.
However, while one of  Acre Desktop’s main purposes is to facilitate SCM using text files,
it has tremendous value as a simple addition to the IDE, eliminating many of the downsides of workspaces,
while keeping all of the benefits.

## Installation
Acre Desktop is distributed as a compressed folder that contains a folder named acre.
To install, uncompress, and put the acre folder anywhere.
Inside this folder is a workspace named acre.dws.
Load this workspace once, and restart the APL session.
Acre Desktop is now installed as a set of user commands.  

## The Project
Acre Desktop introduces to the IDE the concept of a project.
In the workspace, a project is represented by a namespace. This is called the **project space**.
On disk, a project is represented by a folder. This is called the **project folder**.
A project is created from an existing namespace using the CreateProject command. For example:

~~~
]acre.CreateProject c:/Projects/MyProject #.MyProject
~~~

This writes out the all of the code in the namespace #.MyProject into the folder c:/Projects/MyProject. 
An existing project is opened using the OpenProject command:

~~~
]acre.OpenProject   c:/Projects/MyProject
~~~

This instantiates the namespace #.MyProject back into the workspace.
Thus, the project folder knows its associated project namespace.
However, a project may be instantiated in any namespace by specifying an additional parameter to the OpenProject command:

~~~
]acre.OpenProject c:/Projects/MyProject #.MyCompany.MyProject
~~~

Items (functions, operators, classes, variables, etc.) in an open project are added and edited using the IDE as one normally would.
Acre Desktop saves all changes. There is no concept of saving a project.  The traditional system command )SAVE is not used.
A typical work session thus involves starting up the interpreter, opening one or more projects, editing and creating items and then )OFF.
While Opening a project brings the project code into the workspace and tells AcreDesktop to monitor the project,
a project may also be loaded, rather than opened using the Load command:

~~~
]acre.LoadProject   c:/Projects/MyProject
~~~

This brings the code into the workspace, but Acre Desktop does not monitor it.

## Project Internals
A project folder can have any number of arbitrary files or folders in it. 
However, there are two folder names and one file name that Acre Desktop reserves.
The first reserved folder is named **APLSource.** This folder contains the APL source code in text files,
in a folder hierarchy mirroring the project namespace structure.
You can create this folder yourself, and populate it with text files that contain the source for APL items.
Most of the time, however, this folder is created for you by the CreateProject command.
The second reserved folder is **.acre**. This folder contains Acre Desktop related stuff. 
In general, there are no user serviceable parts in this folder, and you cannot create it yourself.
The reserved file is **acreconfig.txt**. This is a text file (JSON or scripted namespace),
that contains configuration parameters for the project. 
This file is created for you when the CreateProject command is used to create the project, but it is easy to create it by hand. 
Thus it is simple to create a project outside of the Dyalog IDE and Acre Desktop if you so choose. 
Simply create a folder for your project, create a sub folder named APLSource, and populate with source code text files.

## The APLSource Folder
The APLSource folder contains the APL Source code. 
Each APL item, be it a class, namespace script, function or variable, is in a .dyalog text file,
in a folder hierarchy that mimics the namespace structure.
Because APL names are case sensitive, while some operating file systems are not,
folder and file names must conform to a simple convention.
The @ symbol indicates that the single following character is uppercase,
and the ! symbol indicates that all of the following characters are uppercase.
Thus, the encoding of the APL name DataTable is @data@table, and the encoding of DATATABLE is !DATATABLE,
while no encoding is needed for the lowercase name datatable.
Note that there is a [Chrome plug-in](https://github.com/the-carlisle-group/Acre-Desktop-Chrome-Extension) that decodes names for better viewing experience in the browser.

## The Acre Config File
This text file contains acre parameters specific to the project. It may be JSON or a Dyalog scripted namespace. For example:

~~~
{ 
     "ProjectName":  "MyProject"
     "ProjectSpace": "#.Library.MyProject"
     "Open":         ["MyOtherProject1","MyOtherProject2"]
     "Load":         ["../APLTeam/Utils","../APLTeam/LogDog"]
     "StartUp":      "Initialize"    
}
~~~

The ProjectName is the simple name Acre Desktop uses to refer to the project when open. It should be a valid APL name.
Acre commands that operate on open projects require this name. If not present, this defaults to the last node of the project folder.
Acre will not open two projects with the same name at the same time, even if their project namespaces differ.
No such restriction holds for loading a project.  
The ProjectSpace parameter is the namespace for the project code.
If not present, this defaults to #.ProjectName. 

The Open parameter is a list of additional projects to open. 
The Load parameter is a list of additional projects to load. 
An item in either list is the project folder alone, or a project folder and a project space. 
Together, the two lists are **included** projects.
The StartUp parameter is an expression to be executed in the project namespace after the project
and all of the included projects are open or loaded. 

