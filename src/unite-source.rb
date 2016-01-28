# coding: utf-8

require 'json'
require 'bundler'
gems = Bundler.require

def has_gem?(gems, gem_name)
  gems.map {|e| e.name}.include?(gem_name)
end

hira = 'あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをんがぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽゔぁぃぅぇぉっゃゅょー'
kata = 'アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲンガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポヴァィゥェォッャュョー'

ary = [kata.each_char.to_a, hira.each_char.to_a].transpose
KATA_TO_HIRA = Hash[*ary.flatten]

def to_hira(str)
  str.each_char.to_a.map {|c| KATA_TO_HIRA[c]}.join
end

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
    if has_gem?(gems, 'romkan')
      hira = to_hira name
      roma = hira.to_roma
    end
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
    puts "No.#{no}: #{name}(#{roma})\t10new +call\\ append(0,[#{insert_str}])"
  end
end
