# ShopifyWordSearch

Hello AJ and Shopifolk Devs,

This is my submission for the Mobile Dev Intern Challenge. I actually had a fun time building this, as well as exploring the different ways to improve the project past the original requirements.

Some things I added:
- Reset button to reset the game, and randomize the grid
- Omnidirectional word placement 
- Score count
- Remaining word count
- Overlapping word placement
- Word input through a JSON file, maybe we can connect this with an API that spits out words to make things harder lol
- Algorithm tests out random combinations to place words, sometimes the grid size or word size / count makes things impossible so a different amount of words always get spit out
- Completion animation with confetti :D
- Dynamic list of words left to search
- Very minimal dependencies (nothing really tbh, no spriteKit or cocoapods, etc...) 
- MVC with custom views and cells

Some minor things I encountered:
- Used section and row to layout a 2d uicollectionview grid, but had some trouble with the footer. Therefore footer is added as an additional section instead of a uicollectionreusableview
- Landscape orientation, wordsearch games are seldomly played in landscape (i think, sorry to alienate the 1% of the potential userbase lol)
- Swiping to find words. Due to the size of the screen it seems easy to missswipe in the wrong direction, and thought it would be better and more exact to tap on the letters to select
- Putting the title in the navbar, but do games really use iOS navbars? Unsure about this but hey, I can use the navbar lol

Anywho, thanks for taking the time to look into this, I look forward to collaborating and working with you guys! I'm open to any constructive criticism and am always looking to improve.
