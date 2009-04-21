module Protovis
    
    def js_function(function_name)
      JavascriptFunction.new(function_name)
    end
    
    class RGBA
      attr_accessor :red
      attr_accessor :green
      attr_accessor :blue
      attr_accessor :alpha
      def initialize(red, green, blue, alpha )
        self.red= red
        self.green= green
        self.blue= blue
        self.alpha= alpha
      end
      
      def to_js
        %{"rgba(#{@red}, #{@green}, #{@blue}, #{@alpha})"}
      end
    end
    
    class ProtoVisObject
      attr_accessor :children
      
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
              elsif val.respond_to?(:to_js)
                val= val.to_js
              elsif val.class == String && val.index("func") != 0 #TODO: Treating string literal arguments and functions as identical is bad...
                val = "\"#{val}\""
              end
              prop << "#{key}(#{val})."
            end
          end
          prop.chomp(".")
        end
        def add( child ) 
          if self.children == nil 
            self.children = [] 
          end
          
          self.children << child
          child.parent= self
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
    
    class Line < Mark
      js_attr_accessor :lineWidth
      js_attr_accessor :strokeStyle
      js_attr_accessor :fillStyle
      def initialize( options = {} )
        super( options )
        self.type = "pv.Line"
        self.lineWidth= options[:lineWidth] unless options[:lineWidth] == nil
        self.strokeStyle= options[:strokeStyle] unless options[:strokeStyle] == nil
        self.fillStyle= options[:fillStyle] unless options[:fillStyle] == nil
      end
    end
    
    class Dot < Line 
      js_attr_accessor :size
      js_attr_accessor :shape
      js_attr_accessor :angle
      def initialize( options = {} )
        super( options )
        self.type = "pv.Dot"
        self.size= options[:size] unless options[:size] == nil
        self.shape= options[:shape] unless options[:shape] == nil
        self.angle= options[:angle] unless options[:angle] == nil
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

      js_attr_accessor :width
      js_attr_accessor :height
      js_attr_accessor :fillStyle
    
      def initialize( options = {} )
        super( options )
        self.type = "pv.Bar"
        self.width= options[:width] unless options[:width] == nil
        self.height= options[:height] unless options[:height] == nil
        self.fillStyle= options[:fillStyle] unless options[:fillStyle] == nil
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