# school-finder-cli
Ruby app for finding the best schools within an area

## Objectives

1. Create zip code object which will contain the zip code and the median income for this zip code. The zip code object can always have other information added later.
2. Create a school object that will contain the ranking and other information for a given school. This object will contain a zip code object as one of its attributes.
3. Implement web scraping to gather this information.
4. Create a CLI to query the user for the desired zip code and optionally income information.

## Overview

People often decide to move from one part of the country to another for various reasons. Many times it is a new job opportunity or a desire to raise their children in a different environment.

One of the biggest concerns that most parents have is finding a good school for their children to attend. This can be difficult if they are moving to an unfamiliar area and don't have information on the local schools. The cost of living in a particular school district may also be a factor in deciding where to relocate.

This application tries to simplify this process. It queries the user for a zip code. This would typically be the zip code for the business where they will be working. The user is asked to specify a radius up to thirty miles from this zip code to search for schools. It then asks for their income. This information is optional but will help in deciding if they are able to afford a certain school district. Finally, the user is asked how many results they wish to see.

### The `ZipCode` Class


#### The `setZip` Method
    Obtains the zip code from the user then obtain demographic information for the specified zip code.

#### The `demographics` Method
    Scrapes the web for demographic information.
    
#### The 'getRange' Method
    Scrapes the web for a list of zip codes within a given radius.
    
#### The 'range' Method
    Returns the range array
    
#### The '.all' Method
    This class method should return the contents of the `@@all` array.


### The `School` Class

#### The `get_schoolInfo` Method
    Scrapes the web for school information.

#### The `.summary` Method

    This class method should return the contents of the `@@summary` array.

#### The `.list` Method

    This class method should return the contents of the `@@list` array.


#### The `SchoolFinder` Class

#### The 'call' Method

    Main method called by program. Gets user input and calls school_list method
    
#### The 'check' Method

    Tests the user input and prompts the user to re-enter if it is invalid.
    
#### The 'school_list' Method

    Creates sorted arrays with summary and detail information.
    
#### The 'display_school' Method

    Displays initial list of schools and detailed information for selected school.


The program can be either run from the executable bin/school-finder or installed as a gem.

The user is prompted for the required information and a listing of schools by rank is given. Unranked schools are listed after
ranked schools. The user can then select the individual schools for more information.

If anyone would like to expand on the functionality of the program please use one of the existing branches or create a new one.
There is a rich set of information being extracted that may be useful so please check the detailed output for ideas.