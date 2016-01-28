# coding: utf-8

require 'json'
require 'bundler'
gems = Bundler.require

def has_gem?(gems, gem_name)
  gems.map {|e| e.name}.include?(gem_name)
end

type_hash = {'11' => 'くさ', '3' => 'どく', '9' => 'ほのお', '2' => 'ひこう',
             '10' => 'みず', '6' => 'むし', '0' => 'ノーマル', '12' => 'でんき',
             '4' => 'じめん', '17' => 'フェアリー', '1' => 'かくとう',
             '13' => 'エスパー', '5' => 'いわ', '8' => 'はがね', '7' => 'ゴースト',
             '14' => 'こおり', '15' => 'ドラゴン', '16' => 'あく'
}

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
    types = e['types'].flatten
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
    types.map! do |t|
      if type_hash[t]
        type_hash[t]
      else
        t
      end
    end
    insert_str =  "'No.#{no}:\\ #{name}',\\ 'HP:\\ #{h}',\\ 'こうげき:\\ #{a}',\\ 'ぼうぎょ:\\ #{b}',\\ 'とくこう:\\ #{c}',\\ 'とくぼう:\\ #{d}',\\ 'すばやさ:\\ #{s}'"
    types.each.with_index do |t, j|
      insert_str += ",\\ 'タイプ#{j+1}:\\ #{t}'"
    end
    puts "No.#{no}: #{name}(#{roma})\t10new +call\\ append(0,[#{insert_str}])"
  end
end
