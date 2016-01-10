-module(whereis).
-compile(export_all).

function(Fun) ->
    LF = fun(M) ->
		 [ _, {exports, EFs} | _ ] = M:module_info(), 
		 [ {F,A} || {F,A} <- EFs, F == Fun ]
	 end,
    L = [ {M,LF(M)} || {M,_File} <- code:all_loaded() ],
    [ {M, Funs} || {M,[_H|_T]=Funs} <- L ].
