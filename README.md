# Vooroows
_(It's a mix of Voodoo and Arrows, one of the worst word play I've ever done)_

### Contact
First of all, feel free to reach out by mail ([maxime.dechalendar@me.com](mailto:maxime.dechalendar@me.com)) or by phone directly ([+ 33 7 60 98 02 77](tel:+33760980277).  
I would be more than happy to discuss about this assignment, and give some context about the project, my thought process and decision making.

### Product decision
Since I've moved away from a timer-based game over system to a life-based one, 
I found that the game was less fun, because since I could just take my time and
get some good scores.  

Therefore, I implemented a time limit for each individual arrow, shorten based on
the difficulty level.  
I figured this made the most sense given the requirements.  

I also added a _streak_ system, as a separate ways of counting score, which (in 
additions of lives), gives the player an incentive of being correct rather than fast.  

### Design
As asked in the requirements, I've downloaded Duolingo and played with it before getting 
started.  
It just _feels_ right, animations are everywhere, but subtle enough not to distract you, 
the whole product has some strong design choices and consistency that makes it feel 'comfy'.  

I won't lie, design is _not_ my strong suit, and you'll see it by looking at the demo.  
I've tried to match the requirements as closely as possible, given the timeframe, the time 
that _I_ could allocate it, and my own design skills.  

For instance, I've used system-provided assets ([SF Symbols](https://developer.apple.com/sf-symbols/)) and fonts, 
where we should probably have our own custom assets that makes our app feel uniq.  
With more time, I could have digged around icon finder websites to get something fancier, 
but given the timeframe, this felt like a waste of time. 

Anyway, I strongly think that a product designer, especially in a game environment, would
be a very valuable position.  
Of course, I'll always be happy to give some inputs on what can easily be done on iOS, or 
what can/should be improved in my opinion (see _ideas_ below), but creating a whole new 
game brand from scratch is not in my skillset right now.  

### Ideas
I think that there's _a lot_ to improve on what I've done.  
I won't focus on the design (assets, fonts, colors...) here because I've already talked about it, so here are some ideas, on top of my head, in no particular order:  
- Increase the difficulty as the game goes on
- Add an `Extreme` difficulty, with custom shapes (clockwise / anti clockwise, `Z` shape, etc.)
- Draw a graph of your previous results overtime (as does Impulse)
- Add some sounds in the gameplay
- Add some fancy [Rive](https://rive.app) or [Lottie](https://lottiefiles.com) animations
