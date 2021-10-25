//
(
SynthDef(\help_sinegrain,
    { arg out=0.5, freq=60, sustain=0.7;
        var env;
        env = EnvGen.kr(Env.perc(0.01, sustain, 0.5), doneAction: Done.freeSelf);
        Out.ar(out, SinOsc.ar(freq.midicps, 0, env * 20))
}).add;
);
//Synth(\help_sinegrain)

~melodia = [60,64,67,64,60];
(
Tdef(\toca,{
	var cont = -1;
        5.do{
            cont = cont + 1;
            Synth(\help_sinegrain).set(\freq,x[0][cont%x[0].size]);
            0.25.wait;
        };
        1.wait
})
);
//--------------------------------------------------------------------


Tdef(\toca).play