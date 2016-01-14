

scriptencoding utf-8


let s:save_cpo = &cpo
set cpo&vim


function! ku#altr#available_sources() abort "{{{
  return ['altr']
endfunction "}}}


function! ku#altr#action_table(source_name_ext) abort "{{{
  return ku#file#action_table(a:source_name_ext)
endfunction "}}}


function! ku#altr#key_table(source_name_ext) abort "{{{
  return ku#file#key_table(a:source_name_ext)
endfunction "}}}


function! ku#altr#gather_items(source_name_ext, pattern) abort "{{{
  let pwd = expand('#:p')
  let cwd = pwd
  let files = []
  while !0
    call add(files, pwd)
    let path = altr#_infer_the_missing_path(pwd, 'forward', altr#_rule_table())
    if type(path) == type('')
      let pwd = path
      if pwd == cwd
        break
      endif
    else
      break
    endif
    unlet path
  endwhile
  return map(files, '{
        \ "word" : v:val,
        \ }')
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
