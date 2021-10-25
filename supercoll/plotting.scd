var time_plot;
time_plot = 0.02;
{ PinkNoise.ar(0.2) + SinOsc.ar(440, 0, 0.2) + Saw.ar(660, 0.2) }.play;
{ PinkNoise.ar(0.2) + SinOsc.ar(440, 0, 0.2) + Saw.ar(660, 0.2) }.plot(time_plot);




{ PinkNoise.ar(0.2) + SinOsc.ar(440, 0, 0.2) + Saw.ar(660, 0.2) }.scope;



{ [SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)] }.scope;


{ [SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)] }.scope(zoom: 10);


{ [SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)] }.play;
s.scope;


/// NOTE YOU CAN DO THIS IN PARALLEL WHILE CODING
