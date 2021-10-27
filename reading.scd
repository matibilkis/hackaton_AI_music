(
var p, l, m;
p = Pipe.new("ls ~/hackAI/AIdata/agent0/ | wc -l", "r");
l = p.getLine;                    // get the first line
while({l.notNil}, {l.postln; l = p.getLine; });
p.close;
~m = l;
)

~m.postln;