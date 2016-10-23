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


#### The `#` Method

#### The `#` Method

### The `School` Class

#### The `#`

##### The `#` Method

#### The `#` Method

#### The `.all` Method

This class method should return the contents of the `@@all` array.

## Our Code in Action

Now that you have all your tests passing, you can run our executable file, which relies on our `CommandLineInterface` class.
