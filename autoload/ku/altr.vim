

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
  let current_bufname = bufname('#')
  if empty(current_bufname)
    return []
  endif
  let bufname_list = []
  let direction = 'back'
  let bufname = current_bufname
  while !0
    let bufname = altr#_infer_the_missing_path(bufname, direction, altr#_rule_table())
    if type(bufname) != v:t_string
      if direction ==# 'back'
        let direction = 'forward'
        let bufname = current_bufname
        continue
      elseif direction ==# 'forward'
        break
      endif
    elseif bufname ==# current_bufname
      break
    endif
    call add(bufname_list, bufname)
  endwhile
  return map(bufname_list, '{
        \ "word" : v:val,
        \ "menu" : "file",
        \ }')
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
