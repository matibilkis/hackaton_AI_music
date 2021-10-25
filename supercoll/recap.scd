//Recall that anything in the code that begins with an uppercase letter is a class.


//When looking at these it is important to understand that these objects are just client-side representations of parts of the server's architecture, and should not be confused with those parts themselves. Server abstraction objects are simply conveniences.

s.loca


//SynthDef, which is short for 'synth definition'.

//Synths on the server are basically just things that make or process sound, or produce control signals to drive other synths


//SynthDef-new takes a number of arguments. The first is a name, usually in the form of a String as above. The second is in fact a Function. This argument is called a UGen Graph Function, as it tells the server how to connect together its various UGens.


//first the Function
{ SinOsc.ar(440, 0, 0.2) }.play;

// now here's an equivalent SynthDef
SynthDef.new("tutorial-SinOsc", { Out.ar(0, SinOsc.ar(440, 0, 0.2)) }).play;




(
SynthDef.new("tutorial-SinOsc-stereo", { var outArray;
    outArray = [SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)];
    Out.ar(0, outArray)
}).play;
)



/// PROBLEM WITH BUSSES number
x = { SinOsc.ar(660, 0, 0.2) }.play;
y = SynthDef.new("tutorial-SinOsc", { Out.ar(0, SinOsc.ar(440, 0, 0.2)) }).play;
x.free;    // free just x
y.free;    // free just y

(
var bus;
bus = 10;
x = SynthDef.new("tuto",{Out.ar(0, SinOsc.ar(440,0,0.2)) }, bus).play;
x.free
)






//This is more efficient than repeatedly calling play on the same Function, as it saves the effort of evaluating the Function, compiling the byte code, and sending it multiple times. In many cases this saving in CPU usage is so small as to be largely insignificant, but when doing things like 'mass producing' synths, this can be important.

// execute first, by itself
SynthDef.new("tutorial-PinkNoise", { Out.ar(0, PinkNoise.ar(0.3)) }).add;

// then:
x = Synth.new("tutorial-PinkNoise");
y = Synth.new("tutorial-PinkNoise");
x.free; y.free;


//// VARIETY

SynthDef("tutorial-Rand", { Out.ar(0, SinOsc.ar(Rand(440, 660), 0, 0.2)) }).add;
x = Synth("tutorial-Rand");
y = Synth("tutorial-Rand");
z = Synth("tutorial-Rand");
x.free; y.free; z.free;


(
SynthDef("tutorial-args", { arg freq = 440, out = 0;
    Out.ar(out, SinOsc.ar(freq, 0, 0.2));
}).add;
);
x = Synth("tutorial-args");                // no args, so default values
y = Synth("tutorial-args", ["freq", 660]);        // change freq
z = Synth("tutorial-args", ["freq", 880, "out", 1]);    // change freq and output channel
x.free; y.free; z.free;


(
SynthDef.new("tutorial-args", { arg freq = 440, out = 0;
    Out.ar(out, SinOsc.ar(freq, 0, 0.2));
}).add;
)
s.scope

x = Synth.new("tutorial-args");
x.set("freq", 660);
x.set("freq", 880, "out", 1);
x.set("freq", 60, "out",0);

y = Synth.new("tutorial-args");
y.set("freq",440,"out",1)




