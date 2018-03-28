//Indice:
// 1 -Ferramentas para Visualização do Som : Linha 14
//2 - Tipos de Onda: Linha 23
//3 - Controle de Frequência: Linha 91
//4 -Síntese Aditiva: Linha 138
//5 - Controle de Amplitude: Linha 199


//
//Para executar os códigos, clique na linha que você escolher e aperte "ctrl" + "ENTER"
//Para parar de executar: "ctrl" + "."
// Para Iniciar o Server:
s.boot


// 1 -Ferramentas para Visualização do Som
//Abaixo estão as ferramentas para auxiliar na visualização do som
//Escopo de Frequencias
FreqScope.new(400, 200, 0, server: s);

//Osciloscópio
s.scope


// 2 - Tipos de Onda
//Aqui estão os os synths com os formatos de onda principais
//Repare que eles estão dentro de parenteses (), e isto quer dize que quando você pressionar "Ctrl" + "Enter", todas as linhas dentro do parenteses serão executadas.
//Cada tipo de onda tem sua textura própria, além de uma representação que pode ser exibida pelo osciloscópio e pelo frequenciômetro
//Senóide
(
SynthDef("sin", {
	var sig;
	sig = SinOsc.ar(440);
	Out.ar(0, sig);
}).play;
)

//Dente de Serra
(
SynthDef("saw", {
	var sig;
	sig = LFSaw.ar(45);
	Out.ar(0, sig);
}).play;
)

//Triangular
(
SynthDef("tri", {
	var sig;
	sig = LFTri.ar(44);
	Out.ar(0, sig);
}).play;
)

//Quadrada
(
SynthDef("square", {
	var sig;
	sig = Pulse.ar(40);
	Out.ar(0, sig);
}).play;
)

//Whitenoise
(
SynthDef("wn", {
	var sig;
	sig = WhiteNoise.ar(1);
	Out.ar(0, sig);
}).play;
)

//BrownNoise
(
SynthDef("bn", {
	var sig;
	sig = BrownNoise.ar(1);
	Out.ar(0, sig);
}).play;
)

//PinkNoise
(
SynthDef("pn", {
	var sig;
	sig = PinkNoise.ar(1);
	Out.ar(0, sig);
}).play;
)

//3 - Controle de Frequencia
//Repare que em todos os instrumentos existe uma variavel sig que recebe o tipo de onda ( ex: SinOsc.ar) e existe um novo parenteses que contém um numero. Esse numero é a frequencia, e você pode altera-la
// Execute o exemplo abaixo, aguarde e observe o osciloscópio e o escopo de fequencias

(
SynthDef("sin", {
	var sig;
	sig = SinOsc.ar(XLine.kr(10,10000,20));
	Out.ar(0, sig);
}).play;
)


// Com a função XLine a frequencia variou de 10 a 1000 hertz em 20 segundos. Experimente alterar os numeros que estão dentro da função XLine.

//No exemplo abaixo, uma senóide ( SinOsc.kr)  é usada para controlar a variação do valor da frequencia de uma segunda senóide que é responsável por gera o som.
(
SynthDef("sin", {
	var sig;
	sig = SinOsc.ar(( 1 + SinOsc.kr(0.5)) * 700);
	Out.ar(0, sig);
}).play;
)

// A Senóide varia entre os valores de -1 e 1, então posso multiplica-la por um valor qualquer ( no exemplo 1000) e isso resulta em valores de frequencia que variam entre 0 e 1000. Experimente substituir os valores de frequencia da senóide.


-----
//Obs:
//Você já deve ter reparado que o som está sendo projetado em apenas um dos lados (do fone ou do speaker que vc estiver usando)
//O exemplo abaixo é a repetição do último, mas dessa vez sendo reproduzido em ambos os lados do seu speaker

(
SynthDef("sin", {
	var sig;
	sig = SinOsc.ar(( 1 + SinOsc.kr(10)) * 700)!2;
	Out.ar(0, sig);
}).play;
)

// Com o osciloscópio aberto é possivel ver a diferença gráficamente.
//O "!2" define que o som será reproduzido nos 2 canais
// Se fosse "!3" seria reproduzido em 3 canais e assim por diante
//Execute o seguinte comando e veja o som sendo reproduzido nos diferentes canais
s.meter
-----

//4 - Sintese Aditiva
//Além de modificar a frequencia, como vimos nos exemplos anteriores, existe a possibilidade de executar uma adição entre diferentes osciladores a fim de gerar novas ondas. Reproduza o exemplo abaixo:
(
SynthDef("sin", {
	var sig;
	sig = SinOsc.ar(310) + SinOsc.ar(300);
	Out.ar(0, sig!2);
}).play;
)

//Uma Senóide de 310 hertz está sendo adicionada a outra de 300 hertz. Mas poderiamos fazer assim:

(
SynthDef("sin", {
	var sig;
	sig = SinOsc.ar(310) + LFSaw.ar(300);
	Out.ar(0, sig!2);
}).play;
)

//A Senóide de 310 hertz está sendo adicionada a uma Saw de 300 hertz.
//Utilizando essa mesma técnica podemos fazer tríades, por exemplo:

(
//Um Dó maior
SynthDef("sin", {
	var sig;
	// a frequencia está sendo definida pela conversão em ciclos por segundo (frequencia) do valor 60 do midi, que é equivalente a nota dó. 64 a nota mi e 67 a nota sol
	sig = SinOsc.ar(60.midicps) + SinOsc.ar(64.midicps) + SinOsc.ar(67.midicps);
	// nessa linha eu controlo a amplitude da onda, então multiplicando por 0.2 eu diminuo a amplitude dela em 80%
	sig = sig * 0.2;
	Out.ar(0, sig!2);
}).play;
)

(
//Um Dó menor
SynthDef("sin", {
	var sig;
	// a frequencia está sendo definida pela conversão em ciclos por segundo (frequencia) do valor 60 do midi, que é equivalente a nota dó. 63 a nota mi bemol e 67 a nota sol
	sig = SinOsc.ar(60.midicps) + SinOsc.ar(63.midicps) + SinOsc.ar(67.midicps);
	// nessa linha eu controlo a amplitude da onda, então multiplicando por 0.2 eu diminuo a amplitude dela em 80%
	sig = sig * 0.2;
	Out.ar(0, sig!2);
}).play;
)

//Poderiamos fazer tétrades:
(
//Um Dó menor com 7a
SynthDef("sin", {
	var sig;
	// a frequencia está sendo definida pela conversão em ciclos por segundo (frequencia) do valor 60 do midi, que é equivalente a nota dó. 63 a nota mi bemol e 67 a nota sol
	sig = SinOsc.ar(60.midicps) + SinOsc.ar(63.midicps) + SinOsc.ar(67.midicps) + SinOsc.ar(70.midicps) ;
	// nessa linha eu controlo a amplitude da onda, então multiplicando por 0.2 eu diminuo a amplitude dela em 80%
	sig = sig * 0.2;
	Out.ar(0, sig!2);
}).play;
)

// 5 - Controle de Amplitude
//Como você já deve ter percebido, até agora os synths são continuos. Uma vez executados, eles só são interrompidos através do "ctrl" + ".". Podemos fazer com o que um synth tenha uma duração determinada através do controle de amplitude. Vejamos este exemplo:
(
//Um Dó menor com 7a
SynthDef("sin", {
	var sig;
	sig = SinOsc.ar(60.midicps) + SinOsc.ar(63.midicps) + SinOsc.ar(67.midicps) + SinOsc.ar(70.midicps) ;
	sig = sig * XLine.kr(0.3,0.00001,3);
	Out.ar(0, sig!2);
}).play;
)
//Através da XLine, a amplitude vai de 0.3 a 0.00001 em 3 segundos.
//Aos nossos ouvidos o som some, porém, o sintetizados continua sendo executado pelo servidor.
//Execute o sintetizador (varias vezes) novamente e veja ele sendo executado através do comando abaixo
 s.queryAllNodes
//Para pausar "ctrl" + "."

//Afim de fazer o controle da amplitude de modo correto, usamos os envelopes. Nele podemos definir basicamente 3 parametros, que são servem para desenhar a maneira com que a  amplitude vai variar. Esses parametros são: ataque, sustain e release. O ataque vai controlar o tempo em que a onda vai chegar a sua amplitude máxima, o sustain controla o tempo em que o onda vai permanecer em amplitude máxima e o release o tempo em que a onda vai retornar a sua amplitude minima. Nem sempre as três variáveis vão ser usadas, mas ataque e release sempre estarão presentes.

(
SynthDef("sin", {
	arg ataque = 1, release = 2;
	var sig, env;
	// o parametro doneAction no valor 2 define que o synth será descartado depois de usado
	env = EnvGen.ar(Env.perc(ataque, release,1), doneAction: 2);
	sig = SinOsc.ar(310);
	Out.ar(0, sig!2);
}).play;
)

//No exemplo abaixo,é usada uma senóide para definir o desenho da amplitude (Env.sine), com um valor aleatório entre 3 e 5 hertz. O resultado é um som que simula vagamente uma onda marinha quebrando

(
SynthDef("onda", {arg out = 0, amp = 1, pan = 0, gate = 1;
	var env, snd;
	// aqui é definida a função de envelopagem
	env = EnvGen.ar(Env.sine(Rand(3.5,5)),gate, doneAction:2);
	// aqui adiciono tipos de noise
	snd = BrownNoise.ar(Rand(0.1,0.8)) + PinkNoise.ar *amp;
	snd = snd * env;
	Out.ar(0, snd!2);
}).add;

o = Synth.new(\onda);
)

//Para executar a onda em loop:
(
~onda = Pbind(\instrument, "onda",
	\dur, Prand([4,5,5.5],inf),
	\amp, 1,
	\gate, 1,
	\pan, 0,
).play
)
//Mas isso será tema de uma outra aula ;)
