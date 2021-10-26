

(
var countFiles = 0;
var agent = 0;
d = Dictionary.new;
3.do{

	d.add(agent -> CSVFileReader.readInterpret("/home/cooper-cooper/hackAI/AIdata/agent"++agent.asString++"/episode"++countFiles.asString++".csv", true, true));
	agent = agent + 1;
}
)


/// APPEND TO DICTIONARY

(
var c = 0;
var di;
var new;
di = Dictionary.new;
z = Array.new(10);
di.add(0 -> z);
new=di.at(0).add(10).postln;
di.add(0 -> new);
di.postln;
)



(
var agent = 0;
var values;
d = Dictionary.new;
3.do{

	d.add(agent -> Array.new(100));
	var countFiles = 0;
	99.do{
		values = CSVFileReader.readInterpret("/home/cooper-cooper/hackAI/AIdata/agent"++agent.asString++"/episode"++countFiles.asString++".csv", true, true);
	    new = d.at(agent).add(values);
	    d.add(agent -> new);
	    countFiles = countFiles + 1;
        };
	agent = agent + 1;
}
)
}



(
var agent = 0;
var values;
var countFiles;
var new;
d = Dictionary.new;
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
)


