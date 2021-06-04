;dependency: https://www.autohotkey.com/download/
;Element combination autocomplete (Magicka2)
;Concept:
;The script is set up with a custom list of combinations. (wa,wwwww,qqdrrrrr,qqqqq,...)
;Whenever an element is pressed, if the next element(s) are obvious they are pressed automatically.
;For example:
;ww(www)
;qqd(rrrrr) Ice Tornado
;eq(qqq)s(ssr) poison armor
;ea(qrqaaa) lightning armor
;ae(qfqaaa) lightning curtain
;sa(qfqaas) lightning beam
#Warn
#UseHook, Off
#SingleInstance Force
;The spellbook. Feel free to customize. (Reload the script with ingame F5. Try adding Push(qe)) (Delimiter variations and order does not matter this is just a list)
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
global CACHE:="" ;This is what the script thinks your current element combination is. Use RButton to reset when it de-syncs. (Ex: death, cutscene while spelling)
SetKeyDelay, 0, 24 ;24 seems to work well for me. Try increasing the delay if your game seems to drop inputs or to make it more human-like.
SoundBeep ;Reload(F5) notification.
QueuedHold(m,k) ;Triggers have to 1) Clear the CACHE. 2) Be delayed until the current spelling is finished.
{
	CACHE:=""
	Send % m "{" k " down}"
	KeyWait, %k%
	Send % m "{" k " up}"
}
MyPush(k) { ;autocomplete logic
	ks:=""
	While (StrLen(k)==1 and k!="_") {
		ks:=ks k
		k:=""
		Loop, Parse, SPELLBOOK, % ", `t`n`r"
			If RegExMatch(A_LoopField, CACHE ks)=1 {
				c:=SubStr(A_LoopField "_", StrLen(CACHE ks)+1, 1)
				if RegExMatch(k, c)<=0
					k:=k c
			}
	}
	CACHE:=CACHE ks
	Send % ks
}
#If WinActive("ahk_exe Magicka2.exe")
F4::Suspend,Toggle
F5::Reload
a::MyPush("a")
q::MyPush("q")
s::MyPush("s")
w::MyPush("w")
d::MyPush("d")
e::MyPush("e")
f::MyPush("f")
r::MyPush("r")
;Not sure how to do it with shorter syntax. Ex: *~RButton:: does not delay, allowing early firing.
+LButton::QueuedHold("+","LButton")
^LButton::QueuedHold("^","LButton")
!LButton::QueuedHold("!","LButton")
RButton::QueuedHold("","RButton")
+RButton::QueuedHold("+","RButton")
^RButton::QueuedHold("^","RButton")
!RButton::QueuedHold("!","RButton")
MButton::QueuedHold("","MButton")
+MButton::QueuedHold("+","MButton")
^MButton::QueuedHold("^","MButton")
!MButton::QueuedHold("!","MButton")
XButton1::QueuedHold("","XButton1")
+XButton1::QueuedHold("+","XButton1")
^XButton1::QueuedHold("^","XButton1")
!XButton1::QueuedHold("!","XButton1")
XButton2::QueuedHold("","XButton2")
+XButton2::QueuedHold("+","XButton2")
^XButton2::QueuedHold("^","XButton2")
!XButton2::QueuedHold("!","XButton2")
Space::QueuedHold("","Space")
+Space::QueuedHold("+","Space")
^Space::QueuedHold("^","Space")
!Space::QueuedHold("!","Space")
;2 is the default focus slot for the prisms which are finishers.
2::QueuedHold("","2")
+2::QueuedHold("+","2")
^2::QueuedHold("^","2")
!2::QueuedHold("!","2")