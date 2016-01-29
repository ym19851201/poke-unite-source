# coding: utf-8

require 'json'

this_dir = File.expand_path(File.dirname(__FILE__))
open(this_dir + '/data.txt') do |f|
  data = f.read
  data = data.encode(
    'utf-16',
      'utf-8', 
        :invalid => :replace, 
          :undef => :replace
  ).encode('utf-8')

  obj = JSON.load data
  obj.each.with_index do |e, i|
    no = i + 1
    types = e['types']
    abilities = e['abilities']
    name = e['name']
    h = e['H']
    a = e['A']
    b = e['B']
    c = e['C']
    d = e['D']
    s = e['S']
    insert_str =  "'No.#{no}:\\ #{name}',\\ 'HP:\\ #{h}',\\ 'こうげき:\\ #{a}',\\ 'ぼうぎょ:\\ #{b}',\\ 'とくこう:\\ #{c}',\\ 'とくぼう:\\ #{d}',\\ 'すばやさ:\\ #{s}'"
    types.each.with_index do |t, j|
      insert_str += ",\\ 'タイプ#{j+1}:\\ #{t}'"
    end
    abilities.each.with_index do |ability, j|
      insert_str += ",\\ '特性#{j+1}:\\ #{ability}'"
    end
    puts "No.#{no}: #{name}\t10new +call\\ append(0,[#{insert_str}])"
  end
end
