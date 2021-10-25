///. If you don't specify a server, you'll get the default one, which you'll recall is stored in the variable 's' and is set at startup to be the localhost server.
{ SinOsc.ar(440, 0, 0.2) }.play;


//All classes begin with upper-case letters, so it's pretty easy to identify them in code.


//So what about 'mul'? Mul is a special argument that almost all UGens have. It's so ubiquitous that it's usually not even explained in the documentation. It just means a value or signal by which the output of the UGen will be multiplied

{ SinOsc.ar(800, 0, 1) }.play;


//This waveform loops, creating the output signal. 'ar' means make the instance audio rate. SuperCollider calculates audio in groups of samples, called blocks. Audio rate means that the UGen will calculate a value for each sample in the block. There's another method, 'kr', which means control rate. This means calculate a single value for each block of samples. This can save a lot of computing power, and is fine for (you guessed it) signals which control other UGens, but it's not fine enough detail for synthesizing audio signals.
(
{ var ampOsc;
    ampOsc = SinOsc.kr(0.5, 1.5pi, 0.5, 0.5);
    SinOsc.ar(440, 0, ampOsc);
}.play;
)

SinOsc.kr(0.5, 1.5pi, 0.5, 0.5);