require 'json'
require 'active_support/core_ext/string/inflections.rb'
require_relative 'valve_parser.rb'


heroes = ValveParser::parse('npc_heroes.txt')['DOTAHeroes']
heroes.delete 'npc_dota_hero_base'
heroes.delete 'Version'

heroes2 = {}
heroes.values.sort { |a, b| a['url'] <=> b['url'] }.each do |v|
  k = heroes.key v
  v['name'] = v['url'].titleize
  heroes2[k[14..-1]] = v
end



File.open('heroes.js', 'w') do |f|
  f.write "heroes = #{heroes2.to_json}"
end