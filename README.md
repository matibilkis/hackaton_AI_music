## Talk
https://youtu.be/Y1urPDJekxY?t=1445


## Inspiration
Do you imagine how many learning curves have AlphaGo team had to look at, when training their models? This can be fun, but also extremely boring. The idea of this project is to listen the learning progress, and open the doors to create music aided by machine learning.


## What it does
The robot is given a melody, and asked to reproduce it. It's not a very smart robot, and can't do Fourier transforms to guess the notes and the correct ordering. Thus, it needs to do trial and error, pretty much the way we humans do when learning how to play an instrument from scratch. We believe our approach opens the door to explore live-coding in a semi-automatic fashion, where an ensemble of robots is asked to "copy" the melody that its partner has played before: the randomness introduced from the learning curve, aided with hyperparameter tuning done by the live-coder-human musician, can potentially give rise to very funny musical pieces!

## How we built it
We use an algorithm inspired in how pets are trained (see for example, Pavlov's dog story); a reward is given to the robot if the right note is played, an a penalty is given otherwise. Specifically we use Q-learning, which is a reinforcement learning algorithm inspired in the concept of a 'fixed point' of a mathematical map. As the robot explores the space of possible melodies, it learns which was the right note to play at each time, and thanks to SuperCollider we are able to reproduce the melody played by the robot at each trial.

## Challenges we ran into
Live coding was entirely new to the three of use, and we had no skills regarding software manipulation in this area (such as OSC, or SuperCollider). It was pretty challenging to incorporate all the ideas we had, but thanks to the expertise from the mentors, we managed to come up with a proof of concept.

## Accomplishments that we're proud of
We're pretty proud of being able to wake up a Sunday morning! Also, it is quite amazing to have a proof of concept of something we had no idea it even exists a day ago. All in all, it's been a great experience.

## What we learned
We learned the basics of live-coding, and take out home a lot (really, a lot) of resources, ideas, and fiends!

## What's next for Learning the art & The art of learning
We'd like to explore the interaction between agents that are a priori independent, but asked to copy the melodies the remaining ones have learned; the latter combined with hyperparameter tuning - we believe - can potentially give rise to an interesting symbiosis between humans and AI-machines in the context of live-coding.
