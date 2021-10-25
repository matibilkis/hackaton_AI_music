// Boot the server
s.boot;
//Declare effects
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




// declare the file
(
SynthDef(\help_sinegrain,
    { arg out=0.7, freq=50, sustain=0.4;
        var env;
        env = EnvGen.kr(Env.perc(0.01, sustain, 0.5), doneAction: Done.freeSelf);
        Out.ar(out, SinOsc.ar(freq.midicps, 0, env * 20))
}).add;
)
//Synth(\help_sinegrain)
(
Tdef(\toca,{
    var countFiles = -1;
    30.do{
        var cont = -1;
        countFiles = countFiles + 1;
        x = CSVFileReader.readInterpret("/home/ejbejaranos/Desktop/AI_Music_Hack/camaleon/dataTrain/episode_"++countFiles.asString, true, true);
        x[0] = x[0][1..];
        //x[1] = x[1][1..];
        5.do{
            var dice = rrand(0,100)/100;
            cont = cont + 1;
			if(dice<0.6){2.do{Synth('closedhat')}};
            Synth(\help_sinegrain).set(\freq,x[0][cont%x[0].size]);
			if(dice<0.2){2.do{Synth('openhat')}};
            ¨0.25.wait;
        };
        1.wait
    }
}).play;
)