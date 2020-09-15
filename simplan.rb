# coding: iso-8859-1
# Construtor de Extração de Dados Simplan (Redmine)
# Script Ruby
# Author david.silva@tjpa.jus.br
# Date: 25-08-2020
require 'httparty'
require 'json'
require 'date'
require_relative './activity.rb'

class SimplanRetriver
  include HTTParty

  attr_accessor :activities
  
  def initialize
    @cfg = ConfigRetriver.new
    @activities = Array.new
  end

  def get_actions
    begin
      @res = HTTParty.get('http://simplan/issues.json',
                    :query => @cfg.get_query,
                    :headers => @cfg.get_headers
                         )
      # puts "Status ok: " + @res.code.to_s
      jp = JSON.parse(@res.body)
      
      @ajp = jp['issues']

      # puts "Total: " + @ajp.size.to_s

      @ajp.each_with_index do |act,index|
        #puts "#{index+1} #{act['subject']}"
        activity_object = Activity.new(act['subject'],act['done_ratio'])
        activity_object.id_activity = act['id']
        activity_object.project_name = act['project']['name']
        activity_object.assigned_to_name = act['assigned_to']['name']
        activity_object.due_date = act['due_date']
        activity_object.start_date = act['start_date']
        activity_object.cfn_area = act['custom_fields'][0]['value']
        activity_object.cfn_notes_monitor = act['custom_fields'][1]['value']
        activity_object.cfn_resource = act['custom_fields'][2]['value']
        activity_object.cfn_performance = act['custom_fields'][3]['value']
        activity_object.cfn_recomend_dificulties = act['custom_fields'][4]['value']
        activity_object.cfn_description = act['custom_fields'][5]['value']
        activity_object.cfn_product = act['custom_fields'][6]['value']
        activity_object.cfn_unit = act['custom_fields'][7]['value']
        activity_object.cfn_product_description = act['custom_fields'][8]['value']
        activity_object.cfn_qtd_program = act['custom_fields'][9]['value']
        activity_object.cfn_qtd_exec = act['custom_fields'][10]['value']
        activity_object.cfn_macrochallenge = act['custom_fields'][11]['value']
        activity_object.updated_at = act['updated_on']
        activity_object.tracker_type = act['tracker']['name']
        activity_object.status = act['status']['name']
        # activity_object.cfn = JSON.parse(act['custom_fields'])

        # Unpack Custom fields
                
        act['custom_fields'].each do |w|
          k = 1
          custom_variable_name = ''
          custom_variable_value = nil
          
          w.each do |key,value|
            # puts "#{k} - #{key} - #{value}"
            if key.eql? "name"
              custom_variable_name = value.gsub(/\s+/,'_').downcase
              # custom_variable_name = value

            end
            if key.eql? "value"
              custom_variable_value = value
            end
            k += 1
          end
          tmp = {custom_variable_name=>custom_variable_value}
          activity_object.cfn.append(tmp)
        end

        # End Unpacked
        
        @activities.append(activity_object)
        
      end
    rescue SocketError => e
      puts "Error: "
      puts e.message
    end
    @activities
  end


  def write_actions_file_csv
    begin
      fileName = DateTime.now.iso8601.gsub! ":","."
      fileName = 'sp.' + fileName + '.csv'
      f = File.open(fileName, "a")
      f.write(DateTime.now.iso8601)
    rescue IOError => e
      puts e.message
    ensure
      f.close unless f.nil?
    end
  end
end

class ConfigRetriver
  def initialize
    @headers = {
      "X-Redmine-API-Key" => ""
    }
    @query = {
      "status_id" => '*', # open - closed - * (all)
      "project_id" => '5',
      "limit" => '400',
      "tracker_id" => '1'
    }
  end
  def get_headers
    @headers
  end
  def get_query
    @query
  end
    
end

