" Smooth Scrooll modified
" 2011/01/23
" [original] http://www.vim.org/scripts/script.php?script_id=1601
"
" * The global variable g:scroll_skip_line_size is the scroll lines by one time.
" * The scroll is stopped when reaching the top and bottom of the buffer.
"

" Smooth Scroll
"
" Remamps
"  <C-U>
"  <C-D>
"  <C-F>
"  <C-B>
"
" to allow smooth scrolling of the window. I find that quick changes of
" context don't allow my eyes to follow the action properly.
"
" The global variable g:scroll_factor changes the scroll speed.
"
"
" Written by Brad Phelan 2006
" http://xtargets.com
let g:scroll_factor = 5000
let g:scroll_skip_line_size = 4
function! SmoothScroll(dir, windiv, factor)
   let wh=winheight(0)
   let i=0
   let j=0
   while i < wh / a:windiv
      let t1=reltime()
      let i = i + 1
      if a:dir=="d"
         if line('w$') == line('$')
           break
         endif
         exec "normal \<C-E>j"
      else
         if line('w0') == 1
           break
         endif
         exec "normal \<ESC>k"
      end

      if j >= g:scroll_skip_line_size
        let j = 0
        redraw
        while 1
           let t2=reltime(t1,reltime())
           if t2[1] > g:scroll_factor * a:factor
              break
           endif
        endwhile
      else
        let j = j + 1
      endif
   endwhile
endfunction
