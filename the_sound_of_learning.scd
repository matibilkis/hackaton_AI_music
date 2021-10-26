s.boot

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
);


(
SynthDef(\help_sinegrain,
  { arg out=0.5, freq=78, sustain=0.8;
    var env;
    env = EnvGen.kr(Env.perc(0.01, 1.0, 0.7, -2), doneAction: 2);
    Out.ar(out, SinOsc.ar(freq.midicps, 0, env ))
}).add;
Synth(\help_sinegrain)
);

(
var freqs;
~freqs = Array(3);
freqs.add(0);
freqs.add(12);
freqs.add(24);
);

(
Tdef(\tocaprim,{
	var note = -1;
	var episode = -1;
	var agent = -1;
	5.do{
      note = note + 1;
      agent = -1;
      3.do{
        agent = agent+1;
		play = d.at(agent)[episode][0][note];
        Synth(\help_sinegrain).set(\freq,play);
      };
      0.05.wait;
    };
   }).play;
);



(
Tdef(\toc,{
  var agent, episode, note, fplay;
  episode = -1;
  99.do{
    episode = episode + 1;
    note = -1;
    5.do{
      note = note + 1;
      agent = -1;
      3.do{
        agent = agent+1;
				fplay = d.at(agent)[episode][0][note];//*(freqs[agent]);
        Synth(\help_sinegrain).set(\freq,fplay);
      };
      0.05.wait;
    };
    0.08.wait;
  };
}).play;
);