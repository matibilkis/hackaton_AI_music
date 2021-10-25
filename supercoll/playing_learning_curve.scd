s.boot;
s.recHeaderFormat="wav";

(
SynthDef('closedhat', {

		var hatosc, hatenv, hatnoise, hatoutput;

		hatnoise = {LPF.ar(WhiteNoise.ar(0.5),6000)};

		hatosc = {HPF.ar(hatnoise,3000)};
		hatenv = {Line.ar(1, 0, 0.08)};

		hatoutput = (hatosc * hatenv);

		Out.ar(0,
			Pan2.ar(hatoutput, 0)
		)

	}).add;
);



(
SynthDef('openhat', {

    var hatosc, hatenv, hatnoise, hatoutput;

    hatnoise = {LPF.ar(WhiteNoise.ar(1),6000)};

    hatosc = {HPF.ar(hatnoise,2000)};
    hatenv = {Line.ar(1, 0, 0.3)};

    hatoutput = (hatosc * hatenv);

		Out.ar(0,
			Pan2.ar(hatoutput, 0)
		)

	}).add;
);

(
SynthDef(\help_sinegrain,
    { arg out=0.5, freq=60, sustain=0.8;
        var env;
		env = EnvGen.kr(Env.perc(0.001, 0.2, 0.5), doneAction: 0);
        Out.ar(out, SinOsc.ar(freq.midicps, 0, 20*env ))
}).add;
);

// this will record to the disk
(SynthDef("help-Diskout", {arg bufnum;
    DiskOut.ar(bufnum, In.ar(0,2));
}).add;

// this will play it back
SynthDef("help-Diskin-2chan", { arg bufnum = 0;
    Out.ar(0, DiskIn.ar(2, bufnum));
}).add;
)



/// record
b= Buffer.alloc(s, 65536, 2);
b.write("~/didi.aiff".standardizePath, "aiff", "int16", 0, 0, true);

d = Synth.tail(nil, "help-Diskout", ["bufnum", b]);
d.free;






(
Tdef(\toca1,{
	var tt, count0;
	tt = [0, 4, 7, 4, 0];
	count0 = -1;
	5.do{
		count0 = count0 + 1;
		Synth(\help_sinegrain).set(\freq,tt[count0]+60);
        0.1.wait;
		tt[count0]+60.postln;
	};
	0.8.wait;
	5.do{Synth('closedhat');
		0.1.wait;};
}).play;
);



(
Tdef(\toca,{
    var countFiles = -1;
    30.do{
        var cont = -1;
        countFiles = countFiles + 1;
		x = CSVFileReader.readInterpret("/home/cooper-cooper/hackAI/learning_ev0/episode_"++countFiles.asString++".csv", true, true);
        x[0] = x[0][1..];
        5.do{
            var dice = rrand(0,100)/100;
            cont = cont + 1;
            Synth(\help_sinegrain).set(\freq,x[0][cont%x[0].size]);
			x[0][cont%x[0].size].postln;
            0.1.wait;
        };
        0.3.wait
    }
}).play;
);





