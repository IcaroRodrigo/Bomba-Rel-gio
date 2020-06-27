;****************************** Programa modelo ******************************
;*******                       Nome do programa                    ***********
;*****************************************************************************

;*********************  Defini��o do processador *****************************

	#include p16F877.inc 
	__config _HS_OSC & _WDT_OFF & _LVP_OFF & _PWRTE_ON 
;*************************** Declara��o de vari�veis ******************************  
cblock 0x20 
 ANVAL   	;ANALOG VALUE OF AN0 INPUT
 CNT0 	 	;COUNTER IN BANK 00
 TMP_VALOR  ;VARIAVEL QUE ARMAZENA O VALOR TEMPORARIO DOS BOTOES
 CONTADOR
 DELAY   
 VEZES
 BUZZER
 DIGITO1
 DIGITO2
 DIGITO3
 DIGITO4
 CICLOS
 CICLOS_BOTAO
 CICLOS_FAIL
 LOOP_SEGUNDO ; excluir
 LOOP_FAIL    ; excluir
 TEMPO
 RESULTADO
 QUOCIENTE
 DIVISOR
 DIVIDENDO
 FIO_VERMELHO
 FIO_PRETO
 VAR_CORRETA
 A0										;armazena o conte�do de um dos n�meros a serem multiplicados
 B0										;armazena o conte�do de um dos n�meros a serem multiplicados
 C0										;byte menos significativo do resultado
 C1										;byte mais significativo do resultado
 R0
 R1
 AJT_POTENCIOMETRO
endc

cblock 0xA1
CNT1	 ;COUNTER IN BANK 01
endc
;************************** Mem�ria de programa ******************************
 ORG     0 

RESET 
 nop             
 goto   START 
;***************************** Interrup��o **********************************
 ORG 4 
;*************************** Inicio do programa ******************************

START 

 bsf     STATUS,RP0  ;vai para o Bank 1

;*************************** Configura��es ******************************
 movlw   b'11000011' ; Seta PORTA como sa�da
 movwf   TRISA       
 movlw b'00000000' ;coloca  0 em todos os bits da porta definindo como OUTUPT
 movwf TRISE
 movwf TRISD
 movlw b'00001111' ; SETA PORTB como saida/entrada
 movwf TRISB  
 movlw b'11111111'
 movwf TRISC  
;***************************VAI PARA O BANK 0***********************************  
 bcf   STATUS,RP0    ;vai para o Bank 0
 bsf PORTE,0

 movlw b'00000000'
 movwf BUZZER
 movwf DIGITO1
 movwf DIGITO2
 movwf DIGITO3
 movwf DIGITO4
 movwf RESULTADO
 movwf CONTADOR
 movwf PORTD
 movwf PORTA
 movwf FIO_PRETO
 movwf FIO_VERMELHO
 movwf LOOP_SEGUNDO
 movwf LOOP_FAIL
 movwf CICLOS
 movwf CICLOS_BOTAO
 movwf CICLOS_FAIL
 movwf AJT_POTENCIOMETRO
 movwf VAR_CORRETA
 movlw b'00010100'
 movwf TEMPO

;*************************** Programa principal ******************************



goto MAIN

;**********BLOCO DE LEITURA DOS BOTOES DO TECALDO MATRICIAL ********************
VERIFICAR_BOTAO
	
	movlw b'00000000'
	movwf CICLOS_BOTAO
	;PRIMEIRA LINHA
	movlw b'11101111'
	movwf PORTB
	btfss PORTB,0
	call  BOTAO0 
	btfss PORTB,1
	call  BOTAO1
	btfss PORTB,2
	call  BOTAO2
	btfss PORTB,3
	call  BOTAO3
   ;SEGUNDA LINHA	
  	movlw b'11011111'
  	movwf PORTB	
  	btfss PORTB,0
  	call  BOTAO4 
  	btfss PORTB,1
  	call  BOTAO5
  	btfss PORTB,2
  	call  BOTAO6
  	btfss PORTB,3
  	call  BOTAO7
	;TERCEIRA LINHA
  	movlw b'10111111'
  	movwf PORTB	
  	btfss PORTB,0
  	call  BOTAO8 
  	btfss PORTB,1
  	call  BOTAO9
	;btfss PORTB,2
	;call  BOTAOA
	;btfss PORTB,3
	;call  BOTAOB
	return

;**********************DEFINE EM QUAL DISPLAY O VALOR SERA EXIBIDO********************
DEFINE_DISPLAY
	movlw b'00000000'
	subwf CONTADOR,W
	btfsc STATUS,Z
	call ATRIBUIR_DIGITO1
	
	movlw b'00000001'
	subwf CONTADOR,W
	btfsc STATUS,Z
	call ATRIBUIR_DIGITO2

	movlw b'00000010'
	subwf CONTADOR,W
	btfsc STATUS,Z
	call ATRIBUIR_DIGITO3

	movlw b'00000011'
	subwf CONTADOR,W
	btfsc STATUS,Z
	call ATRIBUIR_DIGITO4
	
	incf CONTADOR
	return

;**************************SETA O VALOR DE CADA DIGITO******************/
ATRIBUIR_DIGITO1
	movf TMP_VALOR,0
	movwf DIGITO1
	call LIGAR_BUZZER
	return

ATRIBUIR_DIGITO2
	movf TMP_VALOR,0
	movwf DIGITO2
	call LIGAR_BUZZER
	return

ATRIBUIR_DIGITO3
	movf TMP_VALOR,0
	movwf DIGITO3
	call LIGAR_BUZZER
	return

ATRIBUIR_DIGITO4
	movf TMP_VALOR,0
	movwf DIGITO4
	call LIGAR_BUZZER
	return

;**********************************DEFINE AS A��ES DE CADA BOT�O DO TECLADO************************************************
BOTAO0                            
	movlw b'00000000'
	movwf TMP_VALOR
	call DEFINE_DISPLAY
	call PERSISTENCIA
	return
BOTAO1
	movlw b'00000001'
	movwf TMP_VALOR
	call DEFINE_DISPLAY
	call PERSISTENCIA
	return
BOTAO2
	movlw b'00000010'
	movwf TMP_VALOR
	call DEFINE_DISPLAY
	call PERSISTENCIA
	return
BOTAO3
	movlw b'00000011'
	movwf TMP_VALOR
	call DEFINE_DISPLAY
	call PERSISTENCIA
	return
BOTAO4
	movlw b'00000100'
	movwf TMP_VALOR
	call DEFINE_DISPLAY
	call PERSISTENCIA
	return
BOTAO5
	movlw b'00000101'
	movwf TMP_VALOR
	call DEFINE_DISPLAY
	call PERSISTENCIA
	return
BOTAO6
	movlw b'00000110'
	movwf TMP_VALOR
	call DEFINE_DISPLAY
	call PERSISTENCIA
	return
BOTAO7
	movlw b'00000111'
	movwf TMP_VALOR
	call DEFINE_DISPLAY
	call PERSISTENCIA
	return
BOTAO8
	movlw b'00001000'
	movwf TMP_VALOR
	call DEFINE_DISPLAY
	call PERSISTENCIA
	return
BOTAO9
	movlw b'00001001'
	movwf TMP_VALOR
	call DEFINE_DISPLAY
	call PERSISTENCIA
	return

;*********************************PERSIST�NCIA *******************************************************
PERSISTENCIA
	call PERDE_TEMPO2
	;PERSISTENCIA DIGITO 1
	movlw b'00100000'
	movwf PORTA

	movlw b'00000000'
	SUBWF DIGITO1,W  
	BTFSC STATUS,Z
	CALL ZERO

	movlw b'00000001'
	SUBWF DIGITO1,W  
	BTFSC STATUS,Z
	CALL UM

	movlw b'00000010'
	SUBWF DIGITO1,W
	BTFSC STATUS,Z
	CALL DOIS

	movlw b'00000011'
	SUBWF DIGITO1,W
	BTFSC STATUS,Z
	CALL TRES

	movlw b'00000100'
	SUBWF DIGITO1,W
	BTFSC STATUS,Z
	CALL QUATRO

	movlw b'00000101'
	SUBWF DIGITO1,W
	BTFSC STATUS,Z
	CALL CINCO

	movlw b'00000110'
	SUBWF DIGITO1,W
	BTFSC STATUS,Z
	CALL SEIS
	
	movlw b'00000111'
	SUBWF DIGITO1,W
	BTFSC STATUS,Z
	CALL SETE

	movlw b'00001000'
	SUBWF DIGITO1,W
	BTFSC STATUS,Z
	CALL OITO

	movlw b'00001001'
	SUBWF DIGITO1,W
	BTFSC STATUS,Z
	CALL NOVE

	call PERDE_TEMPO2
	;PERSISTENCIA DIGITO 2
	movlw b'00010000'
	movwf PORTA

	movlw b'00000000'
	SUBWF DIGITO2,W
	btfsc STATUS,Z
	CALL ZERO

	movlw b'00000001'
	subwf DIGITO2,W  
	BTFSC STATUS,Z
	CALL UM

	movlw b'00000010'
	subwf DIGITO2,W
	BTFSC STATUS,Z
	CALL DOIS

	movlw b'00000011'
	SUBWF DIGITO2,W
	BTFSC STATUS,Z
	CALL TRES

	movlw b'00000100'
	SUBWF DIGITO2,W
	BTFSC STATUS,Z
	CALL QUATRO

	movlw b'00000101'
	SUBWF DIGITO2,W
	BTFSC STATUS,Z
	CALL CINCO

	movlw b'00000110'
	SUBWF DIGITO2,W
	BTFSC STATUS,Z
	CALL SEIS

	movlw b'00000111'
	SUBWF DIGITO2,W
	BTFSC STATUS,Z
	CALL SETE

	movlw b'00001000'
	SUBWF DIGITO2,W
	BTFSC STATUS,Z
	CALL OITO

	movlw b'00001001'
	SUBWF DIGITO2,W
	BTFSC STATUS,Z
	CALL NOVE
	
	call PERDE_TEMPO2
	;PERSISTENCIA DIGITO 3
	movlw b'00001000'
	movwf PORTA

	movlw b'00000000'
	SUBWF DIGITO3,W
	btfsc STATUS,Z
	CALL ZERO

	movlw b'00000001'
	subwf DIGITO3,W  
	BTFSC STATUS,Z
	CALL UM

	movlw b'00000010'
	subwf DIGITO3,W
	BTFSC STATUS,Z
	CALL DOIS

	movlw b'00000011'
	SUBWF DIGITO3,W
	BTFSC STATUS,Z
	CALL TRES

	movlw b'00000100'
	SUBWF DIGITO3,W
	BTFSC STATUS,Z
	CALL QUATRO

	movlw b'00000101'
	SUBWF DIGITO3,W
	BTFSC STATUS,Z
	CALL CINCO

	movlw b'00000110'
	SUBWF DIGITO3,W
	BTFSC STATUS,Z
	CALL SEIS

	movlw b'00000111'
	SUBWF DIGITO3,W
	BTFSC STATUS,Z
	CALL SETE

	movlw b'00001000'
	SUBWF DIGITO3,W
	BTFSC STATUS,Z
	CALL OITO

	movlw b'00001001'
	SUBWF DIGITO3,W
	BTFSC STATUS,Z
	CALL NOVE

	call PERDE_TEMPO2
	;PERSISTENCIA DIGITO 4
	movlw b'00000100'
	movwf PORTA

	movlw b'00000000'
	SUBWF DIGITO4,W
	btfsc STATUS,Z
	CALL ZERO

	movlw b'00000001'
	subwf DIGITO4,W  
	BTFSC STATUS,Z
	CALL UM

	movlw b'00000010'
	subwf DIGITO4,W
	BTFSC STATUS,Z
	CALL DOIS

	movlw b'00000011'
	SUBWF DIGITO4,W
	BTFSC STATUS,Z
	CALL TRES

	movlw b'00000100'
	SUBWF DIGITO4,W
	BTFSC STATUS,Z
	CALL QUATRO

	movlw b'00000101'
	SUBWF DIGITO4,W
	BTFSC STATUS,Z
	CALL CINCO

	movlw b'00000110'
	SUBWF DIGITO4,W
	BTFSC STATUS,Z
	CALL SEIS

	movlw b'00000111'
	SUBWF DIGITO4,W
	BTFSC STATUS,Z
	CALL SETE

	movlw b'00001000'
	SUBWF DIGITO4,W
	BTFSC STATUS,Z
	CALL OITO

	movlw b'00001001'
	SUBWF DIGITO4,W
	BTFSC STATUS,Z
	CALL NOVE

	movlw b'00000100'
	subwf CONTADOR,W
	btfsc STATUS,Z
	goto VERIFICAR_SENHA
	return

;**********************VERIFICA A SENHA DIGITADA*******************
VERIFICAR_SENHA
  	movlw b'00000000'
  	addwf DIGITO1,0
  	addwf DIGITO2,0
  	addwf DIGITO3,0
  	addwf DIGITO4,0
  	movwf RESULTADO
  	movlw b'00000100'
  	subwf RESULTADO,W
  	btfsc STATUS,Z
  	goto SENHA_CORRETA
  	goto SENHA_ERRADA

;*************************A��O DA SENHA CORRETA****************
SENHA_CORRETA

	btfss VAR_CORRETA,0
	call REGRA_DE_TRES
	
	;comandos
	call ADC_INIT
	call ADC_READ
	;movf ANVAL, W
	movf AJT_POTENCIOMETRO,W
	subwf ANVAL,W
	btfsc STATUS,C
	call LIGAR

	call PERDE_MUITO_TEMPO
	bsf VAR_CORRETA,0
 	goto MAIN
;*************zz**************REGRA DE TRES********************************
REGRA_DE_TRES
	movf TEMPO,W
	movwf A0
	movlw b'11111111'
	movwf B0
	call MULT

	movlw b'00010100'
	movwf DIVISOR

	movf	C0,W
    movwf   DIVIDENDO
	call 	DIV
	movwf 	R0

	movf	C1,W
    movwf   A0
	movf 	R0,W
	movwf 	B0
	call 	MULT
	movf 	C0,W
	movwf AJT_POTENCIOMETRO
	

	return
;*************************A��O DA SENHA ERRADA***************************
SENHA_ERRADA
	call LIGAR_BUZZER_FAIL
	goto FAIL
	

	;call LIGAR_BUZZER
	;call LIGAR_BUZZER
	;call LIGAR_BUZZER_FAIL
    ;goto SENHA_ERRADA


 
;********************************MONTA OS NUMEROS NO DISPLAY 7 SEGMENTOS******************************
ZERO
	movlw b'00111111'
	movwf PORTD
	return

UM
	movlw b'00000110'
	movwf PORTD
	return

DOIS
	movlw b'01011011'
	movwf PORTD
	return

TRES
	movlw b'01001111'
	movwf PORTD
	return

QUATRO
	movlw b'01100110'
	movwf PORTD
	return

CINCO
	movlw b'01101101'
	movwf PORTD	
	return

SEIS
	movlw b'01111101'
	movwf PORTD
	return

SETE
	movlw b'00000111'
	movwf PORTD
	return

OITO
	movlw b'01111111'
	movwf PORTD	
	return

NOVE
	movlw b'01101111'
	movwf PORTD
	return

FAIL
	movlw b'00100000'
	movwf PORTA
	movlw b'01110001'			;VALOR PARA INPRESS�O NO DISPLAY 7 SEGMENTOS 
	movwf PORTD
	CALL PERDE_TEMPO2

	movlw b'00010000'
	movwf PORTA
	movlw 0x77			;VALOR PARA INPRESS�O NO DISPLAY 7 SEGMENTOS 
	movwf PORTD
	CALL PERDE_TEMPO2

	movlw b'00001000'
	movwf PORTA
	movlw b'00110000'			;VALOR PARA INPRESS�O NO DISPLAY 7 SEGMENTOS 
	movwf PORTD
	CALL PERDE_TEMPO2

	movlw b'00000100'
	movwf PORTA
	movlw b'00111000'			;VALOR PARA INPRESS�O NO DISPLAY 7 SEGMENTOS 
	movwf PORTD
	CALL PERDE_TEMPO2


		
	
	movlw b'10000000'
	incf CICLOS_FAIL,1
	subwf CICLOS_FAIL,0
	btfsc STATUS,Z
	goto LIMPAR_DISPLAY

	goto FAIL

BOOM
	call LIGAR_BUZZER_FAIL
	movlw b'00100000'
	movwf PORTA
	movlw 0X7c 		;VALOR PARA INPRESS�O NO DISPLAY 7 SEGMENTOS 
	movwf PORTD
	CALL PERDE_TEMPO2

	movlw b'00010000'
	movwf PORTA
	movlw 0x3f		;VALOR PARA INPRESS�O NO DISPLAY 7 SEGMENTOS 
	movwf PORTD
	CALL PERDE_TEMPO2

	movlw b'00001000'
	movwf PORTA
	movlw 0x3f		;VALOR PARA INPRESS�O NO DISPLAY 7 SEGMENTOS 
	movwf PORTD
	CALL PERDE_TEMPO2




	goto BOOM

UFA
   	movlw b'00100000'
	movwf PORTA
	movlw b'00111110'			;VALOR PARA INPRESS�O NO DISPLAY 7 SEGMENTOS 
	movwf PORTD
	CALL PERDE_TEMPO2 

	movlw b'00010000'
	movwf PORTA
	movlw b'01110001'			;VALOR PARA INPRESS�O NO DISPLAY 7 SEGMENTOS 
	movwf PORTD
	CALL PERDE_TEMPO2

	movlw b'00001000'
	movwf PORTA
	movlw 0x77			;VALOR PARA INPRESS�O NO DISPLAY 7 SEGMENTOS 
	movwf PORTD
	CALL PERDE_TEMPO2

	goto UFA
;*************************************LIMPA O DISPLAY SETA TODOS OS DIGITOS COMO 0*************************************
LIMPAR_DISPLAY
	movlw b'00000000'
	movwf PORTD
    movwf BUZZER
 	movwf DIGITO1
 	movwf DIGITO2
 	movwf DIGITO3
 	movwf DIGITO4
 	movwf RESULTADO
 	movwf CONTADOR
 	movwf PORTD
 	movwf PORTA
    goto MAIN
;*************************************LIGAR BUZZER****************************


LIGAR_BUZZER
	BCF PORTE,0
	call PERDE_TEMPO
	BSF PORTE,0
	return

LIGAR_BUZZER_FAIL
	BCF PORTE,0
	call PERDE_MUITO_TEMPO
	
	BSF PORTE,0
	return

LIGAR_BUZZER_TIMER
	decf TEMPO
	movlw b'00000000'
	movwf CICLOS
	movwf LOOP_SEGUNDO
	BCF PORTE,0
	call PERDE_TEMPO2
	BSF PORTE,0
	return
;**************************************ROTINA DE DIVIS�O DE VALORES***********************************
DIV
	clrf	QUOCIENTE							;limpa registrador C0


DIV_LOOP
	movf		DIVISOR,W						;Copia divisor para W
	subwf		DIVIDENDO,F						;subtrai divisor B0 do dividendo A0
	btfss		STATUS,C					;testa para ver se houve carry
	goto		DIV_MENOR					;dividendo menor que zero, desvia para label div_menor
	incf		QUOCIENTE,F						;se dividendo maior que zero incrementa o quociente
	goto		DIV_LOOP					;retorna para novo ciclo de subtra��o
	
DIV_MENOR

	movf QUOCIENTE,0
	
	;incf		C0,F						;se dividendo for menor ou igual a zero, incrementa quociente
	return

;*************************************ROTINA DE MULTIPLICA��O****************************************
MULT
	clrf		C0							;limpa conte�do do registrador C0
	clrf		C1							;limpa conte�do do registrador C1
	movf		A0,W						;envia o conte�do de A0 para W
	movwf		C0							;envia o conte�do de W para C0
	
LOOP_MULT
	decf		B0,F						;decrementa B0
	btfsc		STATUS,Z					;B0 igual a zero?
	return									;Sim, retorna
	movf		A0,W						;copia A0 para W
	addwf		C0,F						;Soma A0 com C0 e armazena resultado em C0
	btfsc		STATUS,C					;Houve transbordo em C0?
	incf		C1,F						;Sim, incrementa C1
	goto		LOOP_MULT					;Vai para label loop_mult

;********************************VALIDA OS FRIOS ****************************************
VALIDAR_FIO_VERMELHO
	btfsc FIO_VERMELHO,0
	return
	movf    TEMPO,W
    movwf   DIVIDENDO
	call DIV
	movwf TEMPO
 	btfss PORTC,0
	incf FIO_VERMELHO
	return

VALIDAR_FIO_PRETO
	btfsc FIO_PRETO,0
	return
	movf    TEMPO,W
    movwf   DIVIDENDO
	call DIV
	movwf TEMPO
 	btfss PORTC,5
	incf FIO_PRETO
	return
	
;****************************************CONTROLE DOS POTENCIOMETROS******************************************
ADC_INIT
	BSF STATUS, 5 ;SELECIONA BANCO 01
	MOVLW B'10000000'
	MOVWF ADCON1

	BCF STATUS, 5 ;SELECIONA O BANCO 00

	MOVLW B'10000001'
	MOVWF ADCON0

	RETURN

;;;;ADC READ PROC;;;;
ADC_READ
	BCF STATUS, 5 ;SELECT BANK 00

	BSF ADCON0, 2 ;START CONVERTION PROCESS (WE SET THE GO BIT)
WAIT:
	BTFSC ADCON0, 2
	GOTO WAIT ;WAIT FOR CONVERTION TO FINISH (WAIT FOR GO BIT TO CLEAR)

	;;;WE SAVE RESULT INTO AN 8BIT REGISTER TO USE FOR OUTPUT (WE DROP THE TWO LESS SIGNIFICANT BITS);;;

	;FIRST WE PROCESS THE HIGH BYTE OF RESULT
	MOVLW 0x06
	MOVWF CNT0
AGAIN_0:
	BCF STATUS, C ;WE WANT SHIFT (NOT ROTATE), SO WE CLEAR CARRY
	RLF ADRESH, 1 ;SHIFT LEFT 6 BITS A/D RESULT HIGH BYTE
	DECFSZ CNT0
	GOTO AGAIN_0

	MOVF ADRESH, W ;MOVE ADRESH TO W
	MOVWF ANVAL ;MOVE W TO ANVAL


	;NOW WE PROCESS THE LOW BYTE OF RESULT
	BSF STATUS, 5 ;SELECT BANK 01
	MOVLW 0x02
	MOVWF CNT1
AGAIN_1:
	BCF STATUS, C ;WE WANT SHIFT (NOT ROTATE), SO WE CLEAR CARRY
	RRF ADRESL, 1 ;SHIFT RIGHT 2 BITS A/D RESULT LOW BYTE
	DECFSZ CNT1
	GOTO AGAIN_1

	MOVF ADRESL, W ;MOVE ADRESL TO W
	BCF STATUS, 5 ;SELECT BANK 00
	ADDWF ANVAL, 1 ;ADD W TO ANVAL

	RETURN 

;potenciometro2
ADC_INIT2
	BSF STATUS, 5 ;SELECIONA BANCO 01
	MOVLW B'10000000'
	MOVWF ADCON1

	BCF STATUS, 5 ;SELECIONA O BANCO 00

	MOVLW B'10001001'
	MOVWF ADCON0

	RETURN

;;;;ADC READ PROC;;;;
ADC_READ2
	BCF STATUS, 5 ;SELECT BANK 00

	BSF ADCON0, 2 ;START CONVERTION PROCESS (WE SET THE GO BIT)
WAIT2:
	BTFSC ADCON0, 2
	GOTO WAIT2 ;WAIT FOR CONVERTION TO FINISH (WAIT FOR GO BIT TO CLEAR)

	;;;WE SAVE RESULT INTO AN 8BIT REGISTER TO USE FOR OUTPUT (WE DROP THE TWO LESS SIGNIFICANT BITS);;;

	;FIRST WE PROCESS THE HIGH BYTE OF RESULT
	MOVLW 0x06
	MOVWF CNT0
AGAIN_02:
	BCF STATUS, C ;WE WANT SHIFT (NOT ROTATE), SO WE CLEAR CARRY
	RLF ADRESH, 1 ;SHIFT LEFT 6 BITS A/D RESULT HIGH BYTE
	DECFSZ CNT0
	GOTO AGAIN_02

	MOVF ADRESH, W ;MOVE ADRESH TO W
	MOVWF ANVAL ;MOVE W TO ANVAL


	;NOW WE PROCESS THE LOW BYTE OF RESULT
	BSF STATUS, 5 ;SELECT BANK 01
	MOVLW 0x02
	MOVWF CNT1
AGAIN_12:
	BCF STATUS, C ;WE WANT SHIFT (NOT ROTATE), SO WE CLEAR CARRY
	RRF ADRESL, 1 ;SHIFT RIGHT 2 BITS A/D RESULT LOW BYTE
	DECFSZ CNT1
	GOTO AGAIN_12

	MOVF ADRESL, W ;MOVE ADRESL TO W
	BCF STATUS, 5 ;SELECT BANK 00
	ADDWF ANVAL, 1 ;ADD W TO ANVAL

	RETURN 
;*********************************************************************************
LIGAR
	call LIGAR_BUZZER
	call PERDE_MUITO_TEMPO

	call ADC_INIT2
	call ADC_READ2
	movlw b'10000000'
	subwf ANVAL,W
	btfsc STATUS,C
	goto UFA


	return

DESLIGAR
	movlw b'00000000'
	movwf PORTD
	return

PERDE_TEMPO 
   MOVLW d'25' 
   MOVWF VEZES 
   CALL LOOP_VEZES
   RETURN 

PERDE_TEMPO2 
   MOVLW d'25' 
   MOVWF VEZES 
   CALL LOOP_VEZES
   RETURN 

PERDE_MUITO_TEMPO 
   MOVLW d'255' 
   MOVWF VEZES 
   CALL LOOP_VEZES
   RETURN 

LOOP_VEZES 
   MOVLW d'255' 
   MOVWF DELAY 
   
   CALL  DELAY_US 
   DECFSZ VEZES,1          
   GOTO LOOP_VEZES 
   RETURN 

DELAY_US  
   NOP 
   DECFSZ DELAY,1          
   GOTO DELAY_US         
   RETURN 

MAIN
	;Ativa o buzzer a cada segundo
	movlw b'01000000'
	incf CICLOS,1
	subwf CICLOS,0
	btfsc STATUS,Z
	call LIGAR_BUZZER_TIMER

   ;controla do tempo da chamada da fun��o verificadora de bot�o
	movlw b'00001000'
	incf CICLOS_BOTAO,1
	subwf CICLOS_BOTAO,0
	btfsc STATUS,Z
	call VERIFICAR_BOTAO

    ;chama fun��o que exibe os numeros nos displays
	call PERDE_TEMPO
	call PERSISTENCIA

	;DETONA A BOMBA SE O TEMPO ACABAR
    movlw b'00000000'
    subwf TEMPO,0
	btfsc STATUS,Z
	call BOOM
	 
	movlw b'00000010'
	movwf DIVISOR

	movlw b'11111111'
	movwf PORTC

	btfss PORTC,0
	call VALIDAR_FIO_VERMELHO
	
	movlw b'00000100'
	movwf DIVISOR

	btfss PORTC,5
	call VALIDAR_FIO_PRETO

 goto MAIN 
 end
