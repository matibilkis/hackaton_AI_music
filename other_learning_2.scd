// This (or Ctrl+B) boots the server
s.boot;
s.reboot;

s.options.blockSize = 16


thisProcess.platform.recordingsDir = "/home/cooper-cooper/hackAI/recordings/";




/// PRESENT THE INSTRUMENT!
// guitar
(
SynthDef(\guitar,{
  arg out=0.5, freq=60, sustain= 0.75, attacktime=0.01, releasetime=1, levelenv=0.75;
    var sig, env, delay, ff;
	ff = freq.midicps;
	delay = ff.reciprocal;
	env = EnvGen.kr(Env.perc(attacktime, releasetime, levelenv), doneAction:2);
	sig = Pluck.ar(SinOsc.ar(Line.ar(800, 500, 0.01)*env) , Impulse.ar(0), delay, delay, sustain, 0.5);
    Out.ar(out, sig*env)
}).add;
Synth(\guitar);
)




// Let's listen the target melody!
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
        Synth(\guitar).set(\freq,fplay+60);
		fplay.postln;
      };
      0.5.wait;
    };
}).play;
);





/// LOADING THE DATA OBTAINED BY TRAINING THE ROBOTS!///
(
var p, l;
var agent = -1;
var values;
var valuesGreedy;
var countFiles;
var new;
var newGreedy;

/// STAGE 1: how many episodes ???
p = Pipe.new("ls ~/hackAI/AIdata/agent0/ | wc -l", "r");
l = p.getLine;
p.close;
~numberTraj = l.asInt;
~numberTraj = ((~numberTraj)/2); //First line of each file is the target melody, and we save two files per episode


// STAGE 2: load the data into dictionaries!
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
"ROBOTIC SOUND-INSTRUCTIONS LOADED!".postln;
"There has been "++~numberTraj.asString++" training instances"
);


// Let's listen the target melody!
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
        Synth(\guitar).set(\freq,fplay+60);
		fplay.postln;
      };
      0.5.wait;
    };
}).play;
);




/// Let's listen what the agents do!!!
(
~time_between_melodies = 0.5; /// quick is 0.3  // slooower 0.5
~time_between_notes = 0.3; // quick 0.15;   // 0.3
Tdef(\soundOfLearning,{
  var agent, episode, note, fplay, step, aa;
	step = 5;
	episode = 0;
	aa = -1;
	(75).do{
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
						Synth(\guitar).set(\freq,fplay + 60);
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

s.stopRecording;
s.record;




