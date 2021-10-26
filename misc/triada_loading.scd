s.boot;

(
SynthDef(\help_sinegrain,
    { arg out=0.5, freq=60, sustain=0.8;
        var env;
		env = EnvGen.kr(Env.perc(0.001, 0.2, 0.5), doneAction: 0);
        Out.ar(out, SinOsc.ar(freq.midicps, 0, 20*env ))
}).add;
);

s.scope

(
Tdef(\target,{
	var tt, tt1, tt2, count0;
	tt = [0, 4, 7, 4, 0];
	tt1 = [4, 7, 9, 7, 4];
	tt2 = [7,9,11,7,4];
	count0 = -1;
	5.do{
		count0 = count0 + 1;
		Synth(\help_sinegrain).set(\freq,tt[count0]+60);
		Synth(\help_sinegrain).set(\freq,tt1[count0]+60);
		Synth(\help_sinegrain).set(\freq,tt2[count0]+60);
        0.1.wait;
	};
}).play;
);



(
Tdef(\toca,{
	var x1, x2;
    var countFiles = -1;
    30.do{
        var cont = -1;
        countFiles = countFiles + 1;
		x = CSVFileReader.readInterpret("/home/cooper-cooper/hackAI/learning_ev0/episode_"++countFiles.asString++".csv", true, true);
		x1 = CSVFileReader.readInterpret("/home/cooper-cooper/hackAI/learning_ev1/episode_"++countFiles.asString++".csv", true, true);
		x2 = CSVFileReader.readInterpret("/home/cooper-cooper/hackAI/learning_ev2/episode_"++countFiles.asString++".csv", true, true);
        5.do{
            var dice = rrand(0,100)/100;
            cont = cont + 1;
            Synth(\help_sinegrain).set(\freq,x[0][cont%x[0].size]);
			Synth(\help_sinegrain).set(\freq,x1[0][cont%x[0].size]);
			Synth(\help_sinegrain).set(\freq,x2[0][cont%x[0].size]);
            0.1.wait;
        };
        0.3.wait
    }
}).play;
);





