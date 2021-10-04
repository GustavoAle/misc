#include <hmg.ch>

Function GETURL(cUrl,cSave)
local oTip,lRet:=.t.,cRet

oTip := TURL():New(cUrl)

* Indentifica o Protocolo
if lower(substr(cUrl,0,4))="http"
	oTip := TipClientHttp():New(TURL():New(cUrl))
	if oTip:Open()
		cRet := oTip:ReadAll()
		if !empty(cSave)
			memowrit(cSave,cRet)
		endif
	oTip:Close()	
	else 
		lRet:= .F.
	endif
endif
if lower(substr(cUrl,0,3))="ftp"
	oTip := TipClientFtp():New(TURL():New(cUrl))
	if oTip:Open()
		if !empty(cSave)
			lRet:=oTip:downloadfile(cSave,cSave)
		endif
	oTip:Close()	
	else 
		lRet:=.f.
	endif
endif

Return lRet

Function POSTURL(cUrl,hPost,cSave)
local oTip,cRet

oTip := TURL():New(cUrl)

* Indentifica o Protocolo
if lower(substr(cUrl,0,4))="http"
	oTip := TipClientHttp():New(TURL():New(cUrl))
endif
if lower(substr(cUrl,0,3))="ftp"
	oTip := TipClientFtp():New(TURL():New(cUrl))
endif
if lower(substr(cUrl,0,4))="smtp"
	oTip := TipClientSmtp():New(TURL():New(cUrl))
endif
if lower(substr(cUrl,0,4))="pop"
	oTip := TipClientPoP():New(TURL():New(cUrl))
endif

if oTip:Open()
	If oTip:Post(hPost)
	cRet := oTip:Readall()
	endif
	
	if !empty(cSave)
		memowrit(cSave,cRet)
	endif
oTip:Close()	
endif

Return