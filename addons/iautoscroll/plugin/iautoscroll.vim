" Filename: iautoscroll.vim
" Author: Yu Yuwei <acevery@gmail.com>
" Verson: 0.5
" Last Modify: Dec 16, 2008
" Function: Scrolling to center when cursor hit the last line in window
"      while inserting
" Usage: in your ~/.vimrc, let g:IAutoScrollMode="<mode>", where <mode>
"        is "on" for scroll to center, "off" to disable this plugin.
" Changlog:
"   0.5: Dec 16, 2008
"       Add scrolling when cursor hit the top of screen
"       remove "top" option, only scroll to center
"   0.4: Dec 12, 2008
"       Move the line and col check into if clause, 
"       Which is a little overhead before if :)
"   0.3: Oct 06, 2008
"       Fix logical error using "off"
"       Move cursor to original place after scrolling
"   0.2: Sep 20, 2008
"       Support to scroll to top
" ----------
"

if !exists("IAutoScrollMode")
    let IAutoScrollMode = "on"
endif

autocmd! CursorMovedI * silent call ICheck_Scroll()

function ICheck_Scroll()
    " we only check scroll when enabled:)
    if g:IAutoScrollMode == "on"
        " first, get the line number in window
        let cursor_line_no = winline()
        " second, get the window height
        let winht = winheight(winnr())
        " if we hit the bottom, just move to center or top
        if cursor_line_no == winht || cursor_line_no == 1
            " now store get the current line and column
            let cur_line = line('.')
            let cur_col = col('.')
            " OK, we are ready to move :)
            exec "normal zz"
            " we need move cursor back to the original place,
            " otherwise insert mode in new line
            " would put cursor one space ahead. 
            exec "call cursor(cur_line,cur_col)"
        endif
    endif
endfunction
