{ SinOsc.ar([440, 442, 44,440, 442, 445 ], 0, 0.2) }.play;


/// CHOOSE RANDOMLY EXECUTE

(
{ var freq;
    freq = [[660, 880], [440, 660], 1320, 880].choose;
    SinOsc.ar(freq, 0, 0.2);
}.play;
)


/// PAN OSCILLATING
{ Pan2.ar(PinkNoise.ar(0.5), SinOsc.kr(0.5)) }.play;




/// PAN LEFT
{ Pan2.ar(PinkNoise.ar(0.5), -1) }.play;


/// PAN RIGHT
{ Pan2.ar(PinkNoise.ar(0.5), 1) }.play;

