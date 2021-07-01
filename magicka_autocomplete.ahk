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
aaaaa	aqaaaaa	asf,asa	awawa	aearr	afafa	arara
qqf	qsqsq	qwwww	qdqqqq,qdw	qeqqq	qfasa	qrsqreqr,qrdsr
sasas	sqfaes	sssss	sdsss	se,sefqs,sedqfs	sffqsf	srqrrs
wa,waf	wqwww	wswwwww	wwwww	wdwwww	wed	wfwwww	wrwwww
dqfqqf	dssfqf	dwwww	ddddd	dedrqrq	dffff	drrrr
eaqqrsaaf	eqqqfs	essffq	ewwqqf	eddqrqr	efffqs	errss
fafaf	fqffqffqf,fqqfasa,fqasa,fqdwff	fsfsf	fwwww	fdfdf	fefdd	fffff
rarar	rqrr	rsrsr,rse,rsqrqerq	rwwwww	rdrdr	re,reqrdr	rrrrr
)"
global CACHE:="" ;This is what the script thinks your current element combination is. Use RButton to reset when it de-syncs. (Ex: death, cutscene while spelling)
SetKeyDelay, 48, 96
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
#If WinActive("ahk_exe Magicka.exe")
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
+LButton::QueuedHold("+","LButton")
+RButton::QueuedHold("+","LButton")
RButton::QueuedHold("","RButton")
XButton1::QueuedHold("+","MButton")
XButton2::QueuedHold("+","RButton")
Space::QueuedHold("","Space")
