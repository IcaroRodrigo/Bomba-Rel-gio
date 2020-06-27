# Bomba Relógio

<p>A proposta do desenvolvimento de um circuito e da programação em Assembly que simule o comportamento (previamente descrito nas orientações) de uma bomba relógio, foi desenvolvida utilizando como hardware o microprocessador PIC 16F877A e a placa de aprendizado HJ-5G.</p>

 <p>A bomba relógio do modelo proposto deve possuir um contador regressivo de 120 segundos, teclado matricial, um fio vermelho, um fio preto e dois potenciômetros que servirão como  entrada de dados. Para a saída de dados  serão utilizados displays de 7 segmentos e um buzzer.</p>
<p>Um bip deve ser emitido a cada segundo que passar, quando a senha for digitada os números vão aparecer no display de sete segmentos exibindo a combinação se a combinação estiver errada um bip longo sera emitido e a mensagem FAIL será exibida, em seguida o display é apagado e a contagem continua.</p>
<p>Ao cortar o fio vermelho o tempo é divido em 2 ao cortar o preto é digito por 4, se ambos forem cortados o tempo sera dividido por 2 e depois por 4 sucessivamente, se o tempo esgotar a mensagem de BOOM irá aparecer e sucessivos bips serão emitidos indicando que a bomba foi detonada.</p>
<p>Para realizar o desarme da bomba a senha deve ser digitada corretamente, quando isso acontecer a senha fica salva no display, o potenciômetro 1 deve ser ajustado para o valor analógico equivalente ao tempo restante para a detonação da bomba, quando isso for realizado um bip sera emitido indicando que o ajuste esta correto, para finalizar o desarme o potenciômetro 2 deve ser ajustado em 100%. Se todos os ajustes forem realizado dentro do prazo a mensagem de UFA vai aparecer indicando o sucesso do desarme.			</p>
<p>O software possui um registrador comum denominado tempo que armazena o valor em segundos do tempo que a bomba levara para detonar, esse registrador é decrementado a cada segundo. </p>
<p>Foram utilizado os seguintes registradores do microcontrolador:<br/>
    • Registrador TRISB,  foi definido como entrada para poder  realizar a leitura da entrada de dados do teclado matricial;<br/>
    • Registrador TRISA, foi utilizado com dupla função entrada e saída, os bits de entrada são utilizados para receber os valores analógicos emitidos pelos potenciômetros e os bits de saída são utilizados para ligar os displays de sete segmentos;<br/>
    • Registrador TRISE, foi definido como saída e utilizado para ligar e desligar o buzzer;<br/>
    • Registrador TRISD, foi utilizado como saída sua finalidade foi ligar os segmentos do display e assim formar os números e letras;<br/>
    • Registrador TRISC, foi utilizado como entrada ele recebe o sinal dos fios, dessa forma é possível saber quando eles são cortados;<br/></p>
<p>Utilizando os dados capturados através dos registradores a lógica desenvolvida realiza as operações descritas na orientação do comportamento da bomba;
</p>


