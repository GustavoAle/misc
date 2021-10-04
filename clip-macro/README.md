# clip-macro
This xBase code runs a list of function/procedures (*separated with ';', and ended with ';#'*) passed as a string through parameter. 
All functions and procedures are based on CA-Clipper and Harbour built-in functions, 
	
This one must be compiled using Harbour because of the function 'HB_ATOKENS'
'''
local xComArrayList_ := HB_ATOKENS(xComInput_,';')
'''

*available here:* (https://harbour.github.io)

### Compile & run
When you've already installed Harbour compiler, just compile it using 
'''
hbmk2 macro.prg
'''

### Running
This code produces a message box in the console:
'''
./macro "alert('hello world');#"	
'''
######You can run any CA-Clipper and Harbour function or list of functions by passing through program parameter.
Each function must be separated by ';' and the list must be ended with ';#'
