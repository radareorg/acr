" acr syntax plugin for vim
"
" @author: pancake <pancake@nopcode.org>

if exists("b:current_syntax")
	finish
endif

syn case ignore

syn keyword acrContact PKGNAME VERSION CONTACT
syn keyword acrDirective EXPORT_DEFINED NOP
syn keyword acrDirective REQUIRE_ACR_VERSION
syn keyword acrLanguage LANG_LUA LANG_C LANG_CC LANG_OBJC LANG_CXX LANG_BASH LANG_TCL LANG_PERL
syn keyword acrLanguage LANG_JAVA LANG_PYTHON LANG_RUBY LANG_VALA
syn keyword acrKeyword CHKPRG CHECK_PROGRAM 
syn keyword acrKeyword CHKINC CHECK_INCLUDE
syn keyword acrKeyword CHKFNC CHECK_FUNCTION
syn keyword acrKeyword ENDIAN CHECK_ENDIAN SIZEOF
syn keyword acrKeyword INCLUDE
syn keyword acrKeyword CHECK CHECK_EXEC
syn keyword acrKeyword CHK_PM CHECK_PERL_MODULE
syn keyword acrKeyword CHK_PY CHECK_PYTHON_MODULE
syn keyword acrKeyword CHK_RU CHECK_RUBY_MODULE
syn keyword acrKeyword CHK_CP CHECK_CLASSPATH
syn keyword acrKeyword CHKVER CHECK_VERSION
syn keyword acrKeyword PKGCFG PKGCONFIG
syn keyword acrKeyword CHKLIB CHECK_LIB
syn keyword acrKeyword USE_DL USE_ICONV USE_PTHREAD USE_LIBTOOL
syn keyword acrKeyword USE_PERL_THREADS USE_X11 USE_TK USE_GMAKE USE_JNI
syn keyword acrKeyword PKGCONFIG PKGCFG EXEC
syn keyword acrKeyword SUBDIRS SUBST_FILES
syn keyword acrKeyword IF IFNOT IFAND IFNOTAND IFEQ IFNOTEQ IFEQVAL IFOR IFNOTOR IFNOTEQVAL
syn keyword acrKeyword IFNULL IFNOTNULL DIE 
syn keyword acrKeyword DIENOT DIENOW
syn keyword acrKeyword ARG_WITH ARG_WITHOUT ARG_ENABLE ARG_DISABLE
syn keyword acrOutput EXPORT OUTPUT_H OUTPUT_SH SUBST 
syn keyword acrOutput SUBST_FILES SUBDIRS SUBCONF REPORT
syn match acrOperator "=" 
syn match acrOperator "+="
syn match acrOperator "?="
syn match acrOperator "<-"
syn keyword acrTodo TODO FIXME XXX NOTE
"syn region acrTag start="@" end="@" # TODO
syn region acrComment start="//" skip="\\$" end="$" keepend
syn region  acrComment start="/\*" end="\*/" contains=acrTodo
syn region  acrComment start="((" end="))" contains=acrTodo
syn region  acrComment start="##" end="##" contains=acrTodo
"syn region  acrComment start="//" end="\\" contains=acrTodo
syn region  acrOutput start="<<EOF" end="<<EOF" contains=acrTodo
"syn match   acrNumber "-\=\<\d*\.\=[0-9_]\>" # may help ?
syn match acrSeparator ";" 
syn match acrSeparator "{" 
syn match acrSeparator "}" 
syn match acrSeparator "}{" 
syn match acrSeparator "}ELSE{" 
syn match acrError "<="
syn match acrMark "\$[a-zA-Z]*"

syn sync ccomment acrComment

command -nargs=+ HiLink hi def link <args>

HiLink acrSpecial Number
HiLink acrContact Special
HiLink acrKeyword Type
HiLink acrLanguage acrKeyword
HiLink acrOperator Type
HiLink acrDirective String
HiLink acrTodo Todo
HiLink acrComment Comment
HiLink acrKeyword Repeat
HiLink acrOutput Number
HiLink acrSeparator Macro
HiLink acrError Error
HiLink acrMark Function

delcommand HiLink

let b:current_syntax = "acr"
