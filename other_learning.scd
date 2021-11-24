s.boot;
s.reboot;

s.options.blockSize = 16


thisProcess.platform.recordingsDir = "/home/cooper-cooper/hackAI/recordings/";


/// PRESENT THE INSTRUMENT!
// guitar
(
SynthDef(\guitar,{
  arg out=0.5, freq=60, sustain= 0.5;
    var sig, env, delay, ff;
	ff = freq.midicps;
	delay = ff.reciprocal;
	env = EnvGen.kr(Env.perc(0.001, sustain, 0.5), doneAction:2);
	sig = Pluck.ar(SinOsc.ar(Line.ar(1000, 50, 0.01)*env) , Impulse.ar(0), delay, delay, 5, 0.5);
    Out.ar(out, sig)
}).add;
Synth(\guitar);
)