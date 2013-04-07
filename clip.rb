# Clip app

Camping.goes :Clip

module Clip
  set :views, File.dirname(__FILE__) + '/views'
end

module Clip::Controllers
  class Index < R '/'
    def get
      @clips = Clip.order('created_at desc').all
      
      render :index
    end
  end
  
  class Clips < R '/clips'
    def post
      @headers['Access-Control-Allow-Origin'] = '*'
      
      @url_regex = /\b((?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/?)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s\`!()\[\]{};:\'\".,<>?]))/i
      
      @result = {}
      
      if @input.url and @url_regex.match(@input.url) and not Clip.find_by_url(@input.url)
        Clip.create(:url => @input.url)
        
        @result[:success] = true
      else
        @result[:success] = false
      end
      
      @result = @result.to_json
      
      render :clips, :layout => false
    end
  end
end


module Clip::Models
  class Clip < Base
  end
  
  class BasicFields < V 1.0
    def self.up
      create_table Clip.table_name do |t|
        t.text :url
        t.timestamps
      end
    end
    
    def self.down
      drop_table Clip.table_name
    end
  end
end


def Clip.create
  Clip::Models.create_schema
end
