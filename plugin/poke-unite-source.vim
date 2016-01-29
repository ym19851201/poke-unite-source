let s:script_path = expand('<sfile>:p:h') "
execute("command! PokeUnite :Unite script:ruby:".s:script_path."/../src/unite-source.rb")
call unite#custom#source('script', 'matchers', ["matcher_migemo"])
