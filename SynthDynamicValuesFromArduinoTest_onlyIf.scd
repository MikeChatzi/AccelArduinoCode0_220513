SerialPort.devices;
~port = SerialPort.new("COM3", 57600);

(
~charArray = [ ];
~getValues = Routine.new({
	{
		~ascii = ~port.read.asAscii;
		if(~ascii.isDecDigit, {~charArray = ~charArray.add(~ascii)});
		if(~ascii == $d, {
			~vala = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ];
		    });
		if(~ascii == $e, {
			~valb = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ];
			});
		if(~ascii == $f, {
			~valc = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ];
		});
	}.loop;
}).play;
)

~vala;
~valb;
~valc;

~port.close;


s.boot;


(
SynthDef.new(\saw, {
    arg cutoff=1000;
	var sig;
	sig = Saw.ar([50,51]);
	sig = RLPF.ar(sig, cutoff.lag(0.02), 0.25, 0.2);
	Out.ar(0, sig);
}).add;
)

(
SynthDef.new(\saw1, {
    arg cutoff=500;
	var sig;
	sig = Saw.ar([49,52]);
	sig = RLPF.ar(sig, cutoff.lag(0.02), 0.25, 0.2);
	Out.ar(0, sig);
}).add;
)

(
SynthDef.new(\saw2, {
    arg cutoff=200;
	var sig;
	sig = Saw.ar([49,52]);
	sig = RLPF.ar(sig, cutoff.lag(0.02), 0.25, 0.2);
	Out.ar(0, sig);
}).add;
)


x = Synth.new(\saw);
y = Synth.new(\saw1);
w = Synth.new(\saw2);
x.free;
y.free;
w.free;

x.set(\cutoff,~vala.linexp(0, 255, 80, 4000));

(
~control = Routine.new({
	{
		x.set(\cutoff, ~vala.linexp(0, 255, 80, 4000));
		0.0001.wait;
		y.set(\cutoff, ~valc.linexp(0, 255, 120, 4000));
        0.0001.wait;
		w.set(\cutoff, ~valb.linexp(0, 255, 1000, 2000));
		0.0001.wait;
	}.loop;
}).play;

)

(
~control1 = Routine.new({
	{
        y.set(\cutoff, ~valc.linexp(0, 255, 120, 4000));
        0.0001.wait;
	}.loop;
}).play;
)

x.free;
y.free;