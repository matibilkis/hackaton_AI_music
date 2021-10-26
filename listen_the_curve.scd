s.boot();

//LOAD DATA
(
var agent = 0;
var values;
var countFiles;
var new;
~d = Dictionary.new; //global variable
3.do{
	d.add(agent -> Array.new(100));
	countFiles = 0;
	99.do{
		values = CSVFileReader.readInterpret("/home/cooper-cooper/hackAI/AIdata/agent"++agent.asString++"/episode"++countFiles.asString++".csv", true, true);
		countFiles = countFiles + 1;
		new = d.at(agent).add(values);
	    d.add(agent -> new);
	};
	agent = agent +1;
};
d.at(2).postln;
);

d.at(0)[0][0].postln;


(
SynthDef(\help_sinegrain,
    { arg out=0.5, freq=60, sustain=0.8;
        var env;
		env = EnvGen.kr(Env.perc(0.001, 0.2, 0.5), doneAction: 1);
        Out.ar(out, SinOsc.ar(freq.midicps, 0, 20*env ))
}).add;
);


(
Tdef(\toc,{
	var agent, episode, note, fplay;
	episode = 0;
	99.do{
		note = 0;
		5.do{
			agent = 0;
			3.do{
				fplay = d.at(agent)[episode][0][note];
				Synth(\help_sinegrain).set(\freq,fplay);
				agent = agent+1;
			};
			0.1.wait;
			note = note + 1;
		};
		episode = episode + 1;
		0.3.wait;
	};
}.play;
)
);
