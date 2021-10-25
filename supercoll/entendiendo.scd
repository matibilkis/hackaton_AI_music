s.boot
(
SynthDef(\help_sinegrain,
    { arg out=0, freq=60, sustain=0.5;
        var env;
        env = EnvGen.kr(Env.perc(0.01, sustain, 0.5), doneAction: Done.freeSelf);
        Out.ar(out, SinOsc.ar(freq.midicps, 0, env * 2))
    }).add;
)
Synth(\help_sinegrain)
~un_array = [0.5,1,1];
~notas =   [60,64,72];
(
Tdef(\toca,{
	var cont = -1;
	100.do{
		var dice = rrand(0,10)/10;
		cont = cont + 1;
		if(dice <= ~un_array[cont%~un_array.size]){	Synth(\help_sinegrain).set(\freq,~notas[cont%~notas.size])
		};
		0.25.wait;
	}
}).play
);
~un_array1 = [1,0.5,0.5];
~notas1 =    [64,68,74];
(
Tdef(\toca1,{
	var cont = -1;
	100.do{
		var dice = rrand(0,10)/10;
		cont = cont + 1;
		if(dice <= ~un_array1[cont%~un_array1.size]){	Synth(\help_sinegrain).set(\freq,~notas1[cont%~notas1.size])
		};
		0.25.wait;
	}
}).play
)