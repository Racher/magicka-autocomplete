;https://www.autohotkey.com/download/
#Warn
#SingleInstance Force
#UseHook
global CACHE:=""
;Your spellbook, feel free to customize
global SPELLBOOK:="
(
aaaaa	aqaaaaa	ass,asf	awda	adaaaaa	aeqqfaaa	afafa	arara
qaqqqqq	qqqqq,qqdrrrr,qqrrqqrr	qsqsqsqq	qwwww	qdqqqq	qeqq	qfasa	qrdsr,qrqrqrqr,qrrqrrqq
sadfqaas	sqfqsqss	sssss,ssdss	swsssss	sde,sdsd	se	sfsfs	srsrs
wa	wqwww	wswwwww	wwwww	wdwwww	weewae	wfwwww	wrwwww
daddddd	dqqqq	dssssqq	dwwww	ddddd	dedqrqr	dffss	drsss
eaqrqaaa	eqqqq,eqqqqsssr,eqqqqff,eqqqqrr	esssrq	ewwww	eddrqrq	ee	efffd	errdrq
faqqaaaa	fqasa	fsfss	fwwww	fdssf	fessf	fffff,ffdff,ffsaa	frfffff
rasqqsar	rqdsr,rqrqrrqq,rqqrqqrr	rsrss	rwwww	rdssr	ressr	rfrrrrr	rrrrr,rrdqqrr,rrqqrrqq
)"
SetKeyDelay, 0, 24
SoundBeep
MySend(k) {
	Loop {
		CACHE:=CACHE k
		Send % k
		nextletters:=""
		Loop, Parse, SPELLBOOK, % ", `t`n"
			If RegExMatch(A_LoopField, CACHE)=1 {
				c:=SubStr(A_LoopField "_", StrLen(CACHE)+1, 1)
				if RegExMatch(nextletters, c)<=0
					nextletters:=nextletters c
			}
		if StrLen(nextletters)!=1
			Break
		k:=StrReplace(nextletters, "_")
	}
}
#If WinActive("ahk_exe Magicka2.exe")
F4::Suspend,Toggle
F5::Reload
a::MySend("a")
q::MySend("q")
s::MySend("s")
w::MySend("w")
d::MySend("d")
e::MySend("e")
f::MySend("f")
r::MySend("r")
+~LButton::
!~LButton::
^~LButton::
*~RButton::
*~MButton::
*~XButton1::
*~XButton2::
*~2::
*~Space::
CACHE:=""
Return