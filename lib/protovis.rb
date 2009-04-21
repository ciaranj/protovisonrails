module Protovis
    
    def js_function(function_name)
      JavascriptFunction.new(function_name)
    end
    
    class ProtoVisObject
      
       def self.js_attr_accessor(*accessors)
         accessors.each do |m|
            class_eval %{
              attr_reader :#{m}
              def #{m}= (value)
                  @js_properties= {} if @js_properties == nil
                  @js_properties[:#{m}] = value
                  @#{m}= value
              end
            }
         end
      end

      attr_accessor :name
      attr_accessor :type
      
        def to_js
          return ""
        end
        
        def properties_as_js
          prop =""
          if @js_properties != nil && @js_properties.keys != nil 
            prop <<"."
            @js_properties.keys.each do|key|
              val= @js_properties[key]
              if val.class == Array
                val = val.inspect
              end
              prop << "#{key}(#{val})."
            end
          end
          prop.chomp(".")
        end
    end

    class Mark < ProtoVisObject
      attr_accessor :parent

        js_attr_accessor :data
        js_attr_accessor :visible
        js_attr_accessor :left
        js_attr_accessor :right
        js_attr_accessor :top
        js_attr_accessor :bottom
        
        def initialize( options = {} )
          self.data= options[:data] unless options[:data] == nil
          self.visible= options[:visible] unless options[:visible] == nil
          self.left= options[:left] unless options[:left] == nil
          self.right= options[:right] unless options[:right] == nil
          self.top= options[:top] unless options[:top] == nil
          self.bottom= options[:bottom] unless options[:bottom] == nil
          self.name= options[:name] unless options[:name] == nil
          self.parent = nil
        end
    end
    
    class Rule < Mark 
      js_attr_accessor :lineWidth
      js_attr_accessor :strokeStyle

      def initialize( options = {} )
        super( options )
        self.type = "pv.Rule"
        self.lineWidth= options[:lineWidth] unless options[:lineWidth] == nil
        self.strokeStyle= options[:strokeStyle] unless options[:strokeStyle] == nil
      end
    end

    class Bar < Rule
      attr_accessor :children

      js_attr_accessor :width
      js_attr_accessor :height
      js_attr_accessor :fillStyle
    
      def initialize( options = {} )
        super( options )
        self.type = "pv.Bar"
        self.width= options[:width] unless options[:width] == nil
        self.height= options[:height] unless options[:height] == nil
        self.fillStyle= options[:fillStyle] unless options[:fillStyle] == nil
        self.children = []
      end

      def add( child ) 
        self.children << child
        child.parent= self
      end 
      
      def get_parents( parents =[])
          if self.children && self.children.size > 0 
            parents << self
            self.children.each do |child|
             child.get_parents( parents) 
            end
          end
      end
      
      def get_children( children =[])
        if self.children && self.children.size > 0 
          self.children.each do |child|
           child.get_children( children) 
          end
        else
          children << self
        end
      end
      
    end
    
    class Area < Bar
      def initialize( options = {} )
        super( options )
        self.type= "pv.Area"
      end
    end    
    
    class Panel < Bar
      
      
      def initialize( options = {} )
        options[:name]= "vis" if options[:name] == nil
        super ( options )
        self.type= "pv.Panel"
      end
    
      
      def to_js
        # find_parents  
        parents=[]
        self.get_parents( parents )
        js = ""
        parents.each do |parent|
          if parent == self
            js<< "var #{@name}= new pv.Panel()#{properties_as_js};\n"
          else
            js<< "var #{parent.name}= #{parent.parent.name}.add(#{parent.type})#{parent.properties_as_js};\n"
          end
        end
        children= []
        self.get_children( children )
        children.each do |child|
            js<< "var #{child.name}= #{child.parent.name}.add(#{child.type})#{child.properties_as_js};\n"
        end        
        return js
      end
    end
    
#    class Range
#      
#      pv.range = function(start, end, step) {
#    end
    
    class JavascriptFunction
      attr_accessor :functionName
      def initialize(functionName)
        self.functionName= functionName
      end
      def to_json
        return self.functionName
      end
    end
  
    def protovis_includes
      includes= ""
      includes << javascript_include_tag('protovis.js')+ "\n"
    end
    
      # Constructs a protovis chart of a particular fixed width and height, using the passed in 
      # raw javascript to construct the chart.
      def chart_raw_js( raw_js)
         javascript_tag(raw_js)
      end

      def render_protovis_panel(panel)
         chart_js= panel.to_js
         chart_js<< "#{panel.name}.render();"
         chart_raw_js( chart_js )
      end

end