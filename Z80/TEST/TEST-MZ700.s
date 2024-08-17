;
LETLN		EQU		0006H
PRNTS		EQU		000CH
PRTWRD		EQU		03BAH
PRTBYT		EQU		03C3H
DPCT		EQU		0DDCH
MONITOR_80K	EQU		0082H
MONITOR_700	EQU		00ADH

			ORG		12A0H
			
			LD		HL,0F000H		;F000h～FFFFhまでを検査、実際には0000hをテストした時にRAMの読出し異常で停止
			LD		DE,1000H

LP1:
			CALL	PRTWRD			;検査アドレス表示
			CALL	PRNTS
			LD		B,00H			;RAMへの書込みデータ、00h、FFh～01hまでを書き込み、読み出して一致するかをテスト
			LD		A,(HL)			;ROM読出し
			LD		C,A
			CALL	PRTBYT			;ROM読出しデータ表示
			CALL	PRNTS

LP2:		OUT		(0E1H),A		;RAM選択
			LD		A,B
			LD		(HL),A			;RAM書き込み
			OUT		(0E3H),A		;ROM選択

			PUSH	AF
			LD		A,(HL)			;ROM読出し
			PUSH	AF
			CALL	PRTBYT			;ROM読出しデータ表示
			CALL	PRNTS
			POP		AF
			CP		C				;さっき読み出したROMのデータと一致しているか?
			JR		NZ,ERR2			;不一致ならエラー
			POP		AF

			PUSH	AF
			CALL	PRTBYT			;RAM書き込みデータ表示
			CALL	PRNTS
			POP		AF
			OUT		(0E1H),A		;RAM選択
			LD		A,(HL)			;RAM読出し
			OUT		(0E3H),A		;ROM選択
			PUSH	HL
			PUSH	DE
			PUSH	AF
			CALL	PRTBYT			;RAM読出しデータ表示
			POP		AF
			CP		B				;RAM書き込みデータと読出しデータが一致しているか?
			JR		NZ,ERR1			;不一致ならエラー
			POP		DE
			POP		HL

			LD		A,0C4H			;カーソルを左に8文字戻す
			CALL	DPCT
			CALL	DPCT
			CALL	DPCT
			CALL	DPCT
			CALL	DPCT
			CALL	DPCT
			CALL	DPCT
			CALL	DPCT
			
			DJNZ	LP2				;ループ
			
			CALL	LETLN			;改行
			INC		HL				;アドレス+1
			DEC		DE
			LD		A,D
			OR		E
			JR		NZ,LP1			;ループ
			JR		MON
			
ERR2:		POP		AF
ERR1:		POP		DE
			POP		HL

MON:		LD		HL,014EH
			LD		A,(HL)
			CP		'P'             ;014EHが'P'ならMZ-80K
			JP		Z,MONITOR_80K
			CP		'N'             ;014EHが'N'ならFN-700
			JP		Z,MONITOR_80K
			LD		HL,06EBH
			LD		A,(HL)
			CP		'M'             ;06EBHが'M'ならMZ-700
			JP		Z,MONITOR_700
			JP		0000H           ;識別できなかったら0000Hへジャンプ

			END
