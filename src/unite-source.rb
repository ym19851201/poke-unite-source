require 'json'

type_hash = {'11' => 'くさ', '3' => 'どく', '9' => 'ほのお', '2' => 'ひこう',
             '10' => 'みず', '6' => 'むし', '0' => 'ノーマル', '12' => 'でんき',
             '4' => 'じめん', '17' => 'フェアリー', '1' => 'かくとう',
             '13' => 'エスパー', '5' => 'いわ', '8' => 'はがね', '7' => 'ゴースト',
             '14' => 'こおり', '15' => 'ドラゴン', '16' => 'あく'
}

this_dir = File.expand_path(File.dirname(__FILE__))
open(this_dir + '/data.txt') do |f|
  obj = JSON.load f
  obj.each.with_index do |e, i|
    no = i + 1
    types = e['types'].flatten
    name = e['name']
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
    command =  "'No.#{no}:\\ #{name}',\\ 'HP:\\ #{h}',\\ 'こうげき:\\ #{a}',\\ 'ぼうぎょ:\\ #{b}',\\ 'とくこう:\\ #{c}',\\ 'とくぼう:\\ #{d}',\\ 'すばやさ:\\ #{s}'"
    types.each.with_index do |t, j|
      command += ",\\ 'タイプ#{j+1}:\\ #{t}'"
    end
    puts "No.#{no}: #{name}\t10new +call\\ append(0,[#{command}])"
  end
end
