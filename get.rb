require_relative './simplan.rb'
require 'json'
s = SimplanRetriver.new
act = s.get_actions

act.each_with_index do |a,index|
    puts "------------ #{index+1} --------------------"
    puts a
end
