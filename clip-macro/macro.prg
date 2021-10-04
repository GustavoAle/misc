#xcommand TRY              => bError	:=	errorBlock( {|oErr| break( oErr ) } ) ;;
	                                 BEGIN SEQUENCE

#xcommand CATCH [<!oErr!>] => errorBlock( bError ) ;;
	                                 RECOVER [USING <oErr>] <-oErr-> ;;
	                                 errorBlock( bError )

#define CRLF (Chr(13)+chr(10))


FUNCTION MAIN(xComInput_)
	local i := 1, errcount := 0
	local xComArrayList_ := HB_ATOKENS(xComInput_,';')
	local xReply


	WHILE (xComArrayList_[i] != '#' .AND. errcount < 20)
		TRY 
			xReply := &(xComArrayList_[i])
		CATCH
			errcount++
			? "ERR"+ str(errcount) + " UNDEF: "+stdinput[i]
		END
		i++
	END

RETURN NIL
