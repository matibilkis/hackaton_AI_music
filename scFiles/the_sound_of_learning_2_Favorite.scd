s.boot;

~metaEpisode = 0; // this variable will keep a record of the swap number


(
var p, l;
p = Pipe.new("ls ~/hackAI/AIdata/agent0/ | wc -l", "r");
l = p.getLine;
p.close;
~numberTraj = l.asInt;
~numberTraj = ((~numberTraj)/2); // Recall that we have played and greedy, and first line of each is the target melody (you should skip that when loading)
("Number of trajectories: "++(~numberTraj).asString).postln;
)



/// LOADING THE DATA ///

(
var agent = -1;
var values;
var valuesGreedy;
var countFiles;
var new;
var newGreedy;



/// this is the "instrument"
(
SynthDef(\take2,{
  arg out=0.5, freq=60, sustain= 0.75;
    var sig, env;
  sig = Saw.ar([freq.midicps,freq.midicps+2],0.5);
    env = EnvGen.kr(Env.perc(0.001, sustain, 0.5), doneAction: 2);
    Out.ar(out, sig * env )
}).add;
//Synth(\take2);
);



(
SynthDef(\ambient,{
  arg duration = 0.5, freq = 60;
  var masterVolume = -6.dbamp;
  var rootFreq = freq.midicps;
  var depthMod = LFSaw.kr(0.05).exprange(0.05, 5.0);
  var gate = EnvGen.ar(Env([0, 1, 1, 0], [0.1, duration * 0.9, 0.25]), gate: 1, doneAction: 2);
  var leveler = LinLin.ar(LFTri.ar(duration.reciprocal, 3), -1, 1, -24, 6).dbamp;
  var sig = HPF.ar(
    ({ |k|
      Pan2.ar(({ |i|
        SinOsc.ar(i * k + 2 / (k + 1) * rootFreq * (i + 1))} ! 4).product
      * (k+1).reciprocal
      * LFSaw.kr(
        (k + 5).nthPrime.reciprocal * rootFreq * 0.25, k/7 * 2
      ).exprange(-24.dbamp, 1),
      LFTri.ar((k + 1).nthPrime * rootFreq)
      )
    } ! 16).sum * -18.dbamp,
    40
  );
  var siggap = Amplitude.ar(sig).reciprocal.min(0.0625);
  var verb = GVerb.ar(
    sig.sum,
    roomsize: [80, 135, 283],
    revtime: depthMod * 2,
    drylevel: 0,
    taillevel: 0.dbamp * siggap,
    earlyreflevel: -6.dbamp * siggap,
    add: sig
  ).sum * leveler * gate;
  var env = DetectSilence.ar(verb, doneAction: 2);
  verb * masterVolume;
  Out.ar(0,verb*masterVolume);
}).add;
);






~dict = Dictionary.new; //global variable
~dictGreedy = Dictionary.new;

3.do{
	agent = agent +1;
	~dict.add(agent -> Array.new(1000));
	~dictGreedy.add(agent -> Array.new(1000));
	countFiles = 0;
	(~numberTraj).do{
		values = CSVFileReader.readInterpret("/home/cooper-cooper/hackAI/AIdata/agent"++agent.asString++"/played_episode_"++countFiles.asString++".csv", true, true);
		valuesGreedy = CSVFileReader.readInterpret("/home/cooper-cooper/hackAI/AIdata/agent"++agent.asString++"/greedy_episode_"++countFiles.asString++".csv", true, true);
		countFiles = countFiles + 1;
		new = ~dict.at(agent).add(values);
		newGreedy = ~dictGreedy.at(agent).add(valuesGreedy);
	    ~dict.add(agent -> new);
		~dictGreedy.add(agent -> newGreedy);
	};
};
);

(
Tdef(\targetMelody,{
  var agent, episode, note, fplay;
    note = -1;
    5.do{
      note = note + 1;
      agent = -1;
      3.do{
        agent = agent+1;
		fplay = ~dict.at(agent)[0][0][note]; /// recall that trajectory 0 is the target one!
        Synth(\ambient).set(\freq,fplay + 60);
		fplay.postln;
      };
      0.5.wait;
    };
}).play;
);




(
~time_between_melodies = 0.2;
~time_between_notes = 0.1;
Tdef(\soundOfLearning,{
  var agent, episode, note, fplay, step, aa;
	step = 5;
	episode = 0;
	aa = -1;
	(~numberTraj-1).do{
		note = -1;
		if ( episode%step == 0,
			{
				("Listening episode "++(episode).asString ++ "/" ++ (~numberTraj -1).asString).postln;
				3.do{
					aa = aa +1;
					("Agent "++aa.asString++ " plays " ++ (~dict.at(aa)[episode+1][0]).asString).postln;
				};
				aa= -1;
				5.do{
					note = note + 1;
					agent = -1;
					3.do{
						agent = agent+1;
						fplay = ~dict.at(agent)[episode+1][0][note];
						Synth(\take2).set(\freq,fplay + 60);
					};
					~time_between_notes.wait;
				};
				~time_between_melodies.wait;

			},
			{
			};
	);
	episode = episode + 1;
	}; //end IF

}).play;
);


















(
Tdef(\toc,{
  var agent, episode, note, fplay;
  episode = 0;
	(~numberTraj-1).do{
		("Listening episode "++(episode+1).asString ++ "/" ++ (~numberTraj.asString)).postln;
    episode = episode + 1;
    note = -1;
		if ( episode%2 == 0,
			{

			}

    5.do{
      note = note + 1;
      agent = -1;
      3.do{
        agent = agent+1;
				fplay = ~dict.at(agent)[episode][0][note];
				Synth(\take2).set(\freq,fplay + 60).set(\sustain,0.2);
      };
      0.1.wait;
    };
    0.15.wait;
  };
}).play;
);


s.record;

