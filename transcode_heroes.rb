require 'json'
require_relative 'valve_parser.rb'

heroes = ValveParser::parse('npc_heroes.txt')['DOTAHeroes']
heroes.delete 'npc_dota_hero_base'
heroes.delete 'Version'

File.open('heroes.js', 'w') do |f|
  f.write "heroes = #{heroes.to_json}"
end