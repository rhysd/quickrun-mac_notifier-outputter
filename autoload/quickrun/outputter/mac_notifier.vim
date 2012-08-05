" Author : rhysd <lin90162@yahoo.co.jp>
" License: MIT License http://www.opensource.org/licenses/mit-license.php

" load guard {{{
if exists('g:quickrun_notifier_outputter_loaded') && g:quickrun_notifier_outputter_loaded
    finish
endif
let g:quickrun_notifier_outputter_loaded = 1
"}}}

" check if executable {{{
" Mountain Lion Only
if !has('mac')
    echoerr 'this outputter is for later OS X 10.8 only!'
    finish
end

if !executable('terminal-notifier')
    echoerr "this outputter needs terminal-notifier!\nsee below URL\nhttps://github.com/alloy/terminal-notifier"
    finish
endif
"}}}

let s:save_cpo = &cpo
set cpo&vim

" variables {{{
" notification title
if !has('g:outputter_notifier_title')
    let g:outputter_notifier_title = 'vim-quickrun'
endif

" notification id
if !has('g:outputter_notifier_id')
    let g:outputter_notifier_id = 'vim-quickrun-outputter'
endif

let s:has_vimproc = globpath(&rtp, 'autoload/vimproc.vim') != ''
"}}}

" outputter {{{
let s:outputter = quickrun#outputter#buffered#new()

function! s:outputter.finish(session)
    if s:has_vimproc
        call vimproc#system('terminal-notifier -title "'. g:outputter_notifier_title .
                           \'" -group ' . g:outputter_notifier_id .
                           \' -message "' . self._result . '"')
    else
        call system('terminal-notifier -title "'. g:outputter_notifier_title .
                   \'" -group ' . g:outputter_notifier_id .
                   \' -message "' . self._result . '"')
    endif
endfunction

function! quickrun#outputter#mac_notifier#new()
    return deepcopy(s:outputter)
endfunction

function! s:remove_notifications()
    if s:has_vimproc
        call vimproc#system('terminal-notifier -remove '.g:outputter_notifier_id)
    else
        call system('terminal-notifier -remove '.g:outputter_notifier_id)
    endif
endfunction
"}}}

" mappings {{{
nnoremap <Plug>(outputter_notifier_remove_notifications) :<C-u>call <SID>remove_notifications()<CR>
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo
