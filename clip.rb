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
      
      @result = {}
      
      clip = Clip.new(:url => @input.url)
      
      if clip.save
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
    validates :url, :presence => true
    validates :url, :uniqueness => true
    validates :url, :format => { :with => /\b((?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/?)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s\`!()\[\]{};:\'\".,<>?]))/i, :message => 'Requires a valid URL' }
    
    def smart_add_url_protocol
      unless self.url[/^http:\/\//] || self.url[/^https:\/\//]
        self.url = 'http://' + self.url
      end
    end
    
    def save
      self.smart_add_url_protocol
      super
    end
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
