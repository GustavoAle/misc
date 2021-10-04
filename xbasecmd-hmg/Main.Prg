#include "hmg.ch"

*#xcommand FEASF <cmdsay> => echo()
#xcommand TRY              => bError	:=	errorBlock( {|oErr| break( oErr ) } ) ;;
	                                 BEGIN SEQUENCE
#xcommand CATCH [<!oErr!>] => errorBlock( bError ) ;;
	                                 RECOVER [USING <oErr>] <-oErr-> ;;
	                                 errorBlock( bError )
#define CRLF (Chr(13)+chr(10))
#define WM_DROPFILES         563 // 0x0233

Function Main(cFile)
local aSeq,i
Public caret,nMode:=2,lEcho:=.f.,cDragndropfile:=cFile,lNoGui:=.f.,aGui:={},xReply

	caret	:=	0
	AddFontResource("8x12.tff")
      If upper(HB_ATOKENS(memoread(cFile),CRLF)[1]) = 'NOGUI' .or. upper(HB_ATOKENS(memoread(cFile),CRLF)[1]) = 'HIDE'
         lNoGui	:=	.t.
         load_fromfile(cFile)
      Else   
         Load Window Main
         *Load Window Flogo
         ON KEY RETURN OF Main ACTION Comm_d(main.cmd.value)
         main.width	:=	800 + (getborderwidth()*2)
         main.height	:=	600 +  getborderwidth() + gettitleheight()
         size_cmd()
         *Flogo.Center
         Main.Center
         echo("[ xBase & dBase Command Interpreter ]")
         echo(" [ Open source. Build: Nov. 5th 2013 ]")
         echo(".")
         echo("[ Builder: ]")
         echo("[ HMG 3.2 xBase ]")
         echo("[ Build for: ]")
         echo("[ Windows 7 (Aero enabled) ]")
         echo("[ Tested under Windows XP,Vista & 7 ]")
         CREATE EVENT PROCNAME SolveDrop() HWND Main.HANDLE MSG WM_DROPFILES
         CREATE EVENT PROCNAME SolveClick() HWND getcontrolhandle("Cmd","MAin") MSG 515 STOREINDEX nIndex
         EventProcessAllHookMessage ( nIndex, .T. ) 
           Activate Window Main
      Endif   
Return
Function alert(...)
   msgbox(...)
Return
/*
Function load_as(cName)

if !empty(cName)
   cName:=alltrim(cName)
else 
   echo("[Specify a name]")
   RETURN
endif
   
if !iswindowdefined(&cName)
   Load Window Cmd As &cName
   setproperty(cName,"row",main.row+20)
   setproperty(cName,"col",main.col+20)
   setproperty(cName,"width",800 + (getborderwidth()*2))
	setproperty(cName,"height",600 +  getborderwidth() + gettitleheight())
	setproperty(cName,"cmd","width",main.width - (getborderwidth() *2))
	setproperty(cName,"cmd","height",main.height - gettitleheight() - 16)
   ON KEY RETURN OF &cName ACTION Comm_d(getproperty(cName,"cmd","value"))
   ON KEY RETURN OF &cName ACTION Comm_d(getproperty(cName,"cmd","value"))
   Activate window &cName
else
   echo("[Window "+cName+"Already defined]")
endif   

return
*/
Function load_fromfile(cFile)
Local nStart:=1

	DragAcceptFiles( GetFormHandle('Main'), .T. )
	if lNoGui = .t.
	   nStart:=2
	endif   
	if !empty(cFile)
		if file(cFile)
			aSeq	:=	HB_ATOKENS(memoread(cFile),CRLF)
			For i	:=	1 to len(aSeq)
				exec_cmd(aSeq[i])
			NEXT i
		else
			echo("[ File not exist or bad path ]")
		endif	
	endif
	Return		

	Function echo(cSay)

	if lNoGui = .t.
	   RETURN
	endif   
	if !empty(cSay)
		main.cmd.value	:=	main.cmd.value + alltrim(cSay)+CRLF 
		main.cmd.caretpos	:=	len(main.cmd.value)
	endif

Return

Function Comm_d(cStr)
local comm,nlen
	nlen	:=	len(cStr)
	cCom	:=	rat(chr(13)+chr(10),main.cmd.value)
	cCom	:=	substr(main.cmd.value,cCom+1,nlen)

	if !empty(cCom) 
		main.cmd.value	:=	main.cmd.value + CRLF
		main.cmd.caretpos	:=	len(main.cmd.value)
		exec_cmd(alltrim(cCom))
	endif
Return
/*
Function xcom(xCom,cParam)
local aParam:={},i,l,xParam	:=	""
	msgbox(cParam)
	for i	:=	1 to len(cParam)
		if AT(",", cParam) !=0
			aadd(aParam, LEFT(cParam, AT(",", cParam) -1))
			cParam:=substr(cParam, AT(",", cParam) + 1)
		elseif !empty(cParam)
			aadd(aParam,cParam)	
			cParam:=""
		endif	
	next i

	For l	:=	1 to len(aParam)
		xParam	:=	xParam + "," + aParam[l]
	next l

	if substr(xParam,1,1) = ","
		xParam:=stuff(xParam,1,1,"")
	endif
	

	if !empty(xParam)
		&xcom(&xParam)
	else
		&xcom()
	endif	
	
Return
*/

Function exec_cmd(cCom)
local iunt,a:={},alt,isep,i,xcom:="msgbox",cParam,lEx:=.f.,xTmpVal,cEc
	if rat("xcom",lower(cCom)) !=0
		if (iunt:=rat("=t",cCom)) !=0
			*xcom(substr(cCom,iunt+1,at("|",cCom)-(iunt+1)),substr(cCom,rat("|",cCom)+1))
			*msgbox(xCom + "," + substr(cCom,rat("|",cCom)+1))
			*&xcom(substr(cCom,rat("|",cCom)+1))
			nMode:=2
		elseif (iunt:=rat("=f",cCom)) !=0
			nMode:=1
		endif	
		RETURN
	endif

	If nMode = 2
		/*for i	:=	1 to len(aAFunc)
			if rat(cCom,aAFunc[i]) !=0
				lEx:=.t.
				i	:=	len(aAFunc)
			endif
		next i	
		if lEx
			&cCom
		elseif msgyesno("The function "+cCom+" is not in the list of functions (essential.dll)."+chr(13)+"Try run it?","Are you sure?")
			&cCom
		endif
		*/
	   if at("CCOM",upper(cCom)) != 0 
		  echo("[Paradoxical statement cCom]")
		  echo("[Forced return]")
		  RETURN
	   endif    
	   if type(cCom)="U"

		  Try 
			 xReply	:=	&cCom
		  Catch
			 echo("[Undefined or wrong: "+alltrim(cCom)+" ]")
		  End
			if lEcho = .t.
			cEc := valtype(xReply)
				if cEc == "N"
					echo(cCom+" [=] "+str(xReply))
				endif
				if cEc == "A"
					echo(cCom+" [=] ARRAY")
				endif
				if cEc == "L"
					if xReply = .t.
						echo(cCom+" [=] .T.")
					else
						echo(cCom+" [=] .F.")
					endif	
				endif
				xReply := nil	
			endif	
	   endif   
		RETURN
	endif	
	if rat("clearall",lower(cCom)) !=0
		main.cmd.value	:=	""
		RETURN
	endif

	if rat("help",lower(cCom)) !=0
		For i	:=	1 to len(aAFunc)
			echo("[ "+aAFunc[i]+" ]")
		next i	
		RETURN
	endif

	if rat("set",lower(cCom)) !=0
		if (isep:=rat(":",cCom)) !=0
			if rat("backcolor",lower(cCom)) !=0
				if (isep:=rat("=",cCom)) !=0
					aadd(a,val(substr(cCom,isep+1,3)))
					aadd(a,val(substr(cCom,isep+5,3)))
					aadd(a,val(substr(ccom,isep+9,3)))
					main.cmd.backcolor	:=	a
				endif
				RETURN
			endif	
			if rat("fontcolor",lower(cCom)) !=0
				if (isep:=rat("=",cCom)) !=0
					aadd(a,val(substr(cCom,isep+1,3)))
					aadd(a,val(substr(cCom,isep+5,3)))
					aadd(a,val(substr(ccom,isep+9,3)))
					main.cmd.fontcolor	:=	a
				endif
				RETURN
			endif
			if rat("title",lower(cCom)) !=0
				if (isep:=rat("=",cCom)) !=0
					main.title:=substr(cCom,isep+1,len(cCom))
				endif
				RETURN
			endif
			if rat("fontbold",lower(cCom)) !=0
				if rat("=f",lower(cCom)) !=0
					main.cmd.fontbold	:=	.f.
				else
					main.cmd.fontbold	:=	.t.
				endif
				RETURN
			endif

			if rat("fontitalic",lower(cCom)) !=0
				if rat("=f",lower(cCom)) !=0
					main.cmd.fontitalic	:=	.f.
				else
					main.cmd.fontitalic	:=	.t.
				endif
				RETURN
			endif

			if rat("fontsize",lower(cCom)) !=0
				if (isep:= rat("=",cCom)) !=0
					main.cmd.fontsize	:=	val(substr(cCom,isep+1,len(cCom)))
				endif
				RETURN
			endif	

			if rat("fontname",lower(cCom)) !=0	
				if (isep:= rat("=",cCom)) !=0
					main.cmd.fontname	:=	substr(cCom,isep+1,len(cCom))
				else
					main.cmd.fontname	:=	"9x18-iso8859-1"
				endif
				RETURN
			endif

			if rat("height",lower(cCom)) !=0	
				if (isep:= rat("=",cCom)) !=0
					main.height	:=	val(substr(cCom,isep+1,len(cCom)))
				endif
				RETURN
			endif

			if rat("width",lower(cCom)) !=0	
				if (isep:= rat("=",cCom)) !=0
					main.width	:=	val(substr(cCom,isep+1,len(cCom)))
				endif
				RETURN
			endif
		else
			echo("[Incorret Statements]")
			RETURN
		endif
	endif	

	if rat("maximize-win",lower(cCom)) !=0
		main.maximize
		RETURN
	endif

	if rat("minimize-win",lower(cCom)) !=0
		main.minimize
		RETURN
	endif

	if rat("restore-win",lower(cCom)) !=0
		main.restore
		RETURN
	endif

	if rat("file-edit",lower(cCom)) !=0
		if (iunt:=rat(":",cCom)) !=0
			if file(substr(cCom,iunt+1,len(cCom)))
				alt	:=	main.title 
				main.title	:=	"[ESC] Exit| [CTRL+S] Save"
				main.cmd.value	:=	memoread(substr(cCom,iunt+1,len(cCom)))
				main.cmd.caretpos	:=	len(main.cmd.value)
			else
				echo("[File not exist or bad path]")
				main.cmd.caretpos	:=	len(main.cmd.value)
			endif	
			
		else
			main.cmd.value	:=	main.cmd.value + "[ Wrong Statements .];" 
		endif	
		RELEASE KEY RETURN OF MAIN
		ON KEY CONTROL+S OF MAIN ACTION safe_ed(substr(cCom,iunt+1,len(cCom)),main.cmd.value)
		ON KEY ESCAPE OF Main ACTION Relkey(alt)
		RETURN
	endif

	If rat("webdownload",lower(cCom)) !=0

		if (iunt:=rat(">",cCom)) !=0
			if GETURL(substr(cCom,iunt+1,len(cCom)),substr(cCom,rat("/",cCom)+1,len(cCom)))
				echo("[Download successful]")
			else 	
				echo("[ Download Failure ]")
			endif	
			main.cmd.caretpos	:=	len(main.cmd.value)
		else
				echo("[ Wrong Statements ]") 			
		endif
		RETURN
	Endif	

	If rat("asc",lower(cCom))!=0
	/*
		for i	:=	1 to 255

		main.cmd.value :=REPLICATE(chr(16),4330)
		main.cmd.value :=REPLICATE(chr(17),4330)
		main.cmd.value :=REPLICATE(chr(18),4330)
		main.cmd.value :=REPLICATE(chr(19),4330)	
		main.cmd.value :=REPLICATE(chr(20),4330)
		next i
	*/
		RETURN
	endif
		
	echo("[ Command Unavailable or Unknown ]")
	if lNoGui = .f.
	   main.cmd.caretpos	:=	len(main.cmd.value)
	endif
Return

Function fstep(nStart,nEnd,nStep,aAction)
Local i,a,cAct
   if empty(nStart) .and. empty(nEnd)
      RETURN
   endif
   if empty(nStep)
      nStep	:=	1
   endif
   
   for i	:=	nStart to nEnd Step nStep
      for a	:=	1 to len(aAction)
         cAct	:=	aAction[a]
         Try
            xReply	:=	&cAct
         Catch
            echo("[Undefined or wrong: "+alltrim(cAct)+" ]")
         End 
      Next a
   next i
Return

Function safe_ed(cFile,cStr)

	memowrit(cFile,cStr)
	RELEASE KEY CONTROL+S OF MAIN
	ON KEY RETURN OF Main ACTION Comm_d(main.cmd.value)
	main.cmd.value :=""
	main.cmd.caretpos	:=	len(main.cmd.value)
return

Function size_cmd()
	main.cmd.width	:=	main.width - (getborderwidth() *2)
	main.cmd.height	:=	main.height - gettitleheight() - 67
	main._perc.row	:=	main.height - 26 - gettitleheight()
	main._mem.row	:=	main.height - 26 - gettitleheight()
	main._1st.row	:=	main.height - 26 - gettitleheight()
	main._2nd.row	:=	main.height - 26 - gettitleheight()
	Main._exit.Col	:=	Main.width	- (getborderwidth() *2) - 32
	Main._about.Col	:=	Main.width	- (getborderwidth() *2) - 70
Return

Function update_mem()
Local cPerc:=alltrim(str( int(100*(memorystatus(1)-memorystatus(2))/memorystatus(1) )))
If cPerc != "100"
	Main._1st.picture	:=	"_"+substr(cPerc,1,1)
	Main._2nd.picture	:=	"_"+substr(cPerc,2,1)
Else
	Main._1st.Picture	:=	"_9"
	Main._2nd.Picture	:=	"_9"
endif
Return

Function relkey(alt)
RELEASE KEY ESCAPE OF MAIN
ON KEY RETURN OF Main ACTION Comm_d(main.cmd.value)
main.title	:=	alt
main.cmd.value :=""
main.cmd.caretpos	:=	len(main.cmd.value)
Return


Function var( cVarN,xCont)
Public &cVarN	:=	xCont
Return nil

Function SetTheme()


DwmExtendFrameIntoClientArea(Main.HANDLE, 0,0,35,40)
*SET WINDOW Main TRANSPARENT TO COLOR {0,0,0}
*Main.Cmd.Backcolor:={0,0,0}
FLASH WINDOW Main TASKBAR COUNT 2 INTERVAL 300

Return

Function SolveDrop()
Local hWnd  	:=	EventHWND()
Local wParam	:=	EventWPARAM()

SetForegroundWindow( hWnd )
aFiles	:=	{DragQueryFile( wParam )}
DragFinish( wParam )
load_fromfile(aFiles[1])
Return Nil

Function SolveClick()

msgbox(GetCursorPos()[1],GetCursorPos()[2])

Return NIL

Function call(cFile)
	load_fromfile(cFile)
Return

Function Request_exit()
Local lExit := MsgYEsNo("Are you sure?","Exit")
	If lExit	=	.t.
		Main.Release
	endif
Return	
***********************************************************************************************
#pragma BEGINDUMP


#define _WIN32_WINNT 0x0601
#include "windows.h"
#include "Uxtheme.h"
#include "hbapi.h"
#include <commctrl.h>
#include <wingdi.h>
#include <winuser.h>
#include "hbvm.h"

VOID *hDWMAPI = NULL;
typedef HRESULT (WINAPI * func_DwmExtendFrameIntoClientArea) (HWND, const MARGINS *);

BOOL HMG_DWMAPI ()
{
   if (hDWMAPI == NULL)
       hDWMAPI = LoadLibrary( "Dwmapi.dll" );
   if (hDWMAPI)
      return TRUE;
   else
      return FALSE;
}

//        DwmExtendFrameIntoClientArea (hWnd, cxLeftWidth, cxRightWidth, cyTopHeight, cyBottomHeight)
HB_FUNC ( DWMEXTENDFRAMEINTOCLIENTAREA )
{
   HWND    hWnd = (HWND) hb_parnl (1);
   HRESULT nRet = ( HRESULT ) NULL;
   MARGINS MarInset;
   
   MarInset.cxLeftWidth    = (int) hb_parnl (2);
   MarInset.cxRightWidth   = (int) hb_parnl (3);
   MarInset.cyTopHeight    = (int) hb_parnl (4);
   MarInset.cyBottomHeight = (int) hb_parnl (5);
   
   if( HMG_DWMAPI() )
   {
      func_DwmExtendFrameIntoClientArea pDwmExtendFrameIntoClientArea = ( func_DwmExtendFrameIntoClientArea ) GetProcAddress( hDWMAPI, "DwmExtendFrameIntoClientArea" );
      if( pDwmExtendFrameIntoClientArea )
         nRet = ( HRESULT ) pDwmExtendFrameIntoClientArea ( hWnd, &MarInset );
   }
   hb_retl( ( nRet == S_OK ) );
} 


HB_FUNC( DRAGACCEPTFILES )
{
   DragAcceptFiles( ( HWND ) hb_parnl( 1 ), hb_parl( 2 ) );
}

HB_FUNC( DRAGQUERYFILE )
{
   HDROP hDrop = ( HDROP ) hb_parnl( 1 );
   TCHAR lpBuffer[ MAX_PATH + 1 ];

   DragQueryFile( hDrop, 0, lpBuffer, MAX_PATH );
   hb_retc( lpBuffer );
}

HB_FUNC( DRAGFINISH )
{
   DragFinish( (HDROP) hb_parnl( 1 ) );
}
#pragma ENDDUMP


DECLARE DLL_TYPE_INT AddFontResource ( DLL_TYPE_LPCTSTR lpszFilename ) IN GDI32.DLL
DECLARE DLL_TYPE_BOOL RemoveFontResource ( DLL_TYPE_LPCTSTR lpFileName ) IN GDI32.DLL
DECLARE DLL_TYPE_LONG ;
	FindWindow ( DLL_TYPE_LPSTR lpClassName, DLL_TYPE_LPSTR lpWindowName ) ;
	IN USER32.DLL
   
*DECLARE DLL_TYPE_LONG FindWindowEx ( HWND hwnd, HWND hwndchild, DLL_TYPE_LPSTR lpClassName, DLL_TYPE_LPSTR lpWindowName ) IN USER32.DLL
DECLARE DLL_TYPE_LONG EnumWindows ( HWND hwnd, LPARAM lParam ) IN USER32.DLL
DECLARE DLL_TYPE_LONG EnumWindowsProc ( HWND hwnd, LPARAM lParam ) IN USER32.DLL
DECLARE DLL_TYPE_LONG GetClassName(DLL_TYPE_HWND hWnd,DLL_TYPE_LPSTR lpClassName,DLL_TYPE_INT nMaxCount) IN USER32.DLL
DECLARE DLL_TYPE_LONG CloseWindow(DLL_TYPE_HWND hWnd) IN USER32.DLL
DECLARE DLL_TYPE_LONG EndTask(DLL_TYPE_HWND hWnd, DLL_TYPE_BOOL fShutDown, DLL_TYPE_BOOL fForce) IN USER32.DLL
*DECLARE DLL_TYPE_LONG GetDC(DLL_TYPE_HWND hWnd) IN USER32.DLL
*DECLARE DLL_TYPE_LONG GetParent(DLL_TYPE_HWND hWnd) IN USER32.DLL
*DECLARE DLL_TYPE_LONG SetWindowLong(DLL_TYPE_HWND hWnd, DLL_TYPE_INT nIndex,DLL_TYPE_LONG dwNewLong) IN USER32.DLL