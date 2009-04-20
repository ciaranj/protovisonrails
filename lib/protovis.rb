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
              prop << "#{key}(#{@js_properties[key]})."
            end
          end
          prop.chomp(".")
        end
    end

    class Mark < ProtoVisObject
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
        end
    end

    class Bar < Mark
      js_attr_accessor :width
      js_attr_accessor :height
      js_attr_accessor :lineWidth
      js_attr_accessor :strokeStyle
      js_attr_accessor :fillStyle
    
      def initialize( options = {} )
        self.type = "pv.Bar"
        self.width= options[:width] unless options[:width] == nil
        self.height= options[:height] unless options[:height] == nil
        super( options )
      end
    end
    
    
    
    class Panel < Bar
      
      attr_accessor :children
      
      def initialize( options = {} )
        options[:name]= "vis" if options[:name] == nil
        super ( options )
        self.children = []
  
      end
    
      def add( child ) 
        self.children << child
      end 
      
      def to_js
        js= "var #{@name}= new pv.Panel()#{properties_as_js};\n"
        self.children.each do |child|
          js << "var #{child.name}= #{@name}.add(#{child.type})#{child.properties_as_js};\n" 
        end
        return js
      end
    end
    
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
      # 
      # Example usage:
      #   my_js= <<eos
      #             add(pv.Rule)
      #                .data(function() pv.range(0, 2, .5))
      #                .bottom(function(d) d * 70)
      #                .anchor("left").add(pv.Label)
      #              .root.add(pv.Bar)
      #                .data([1, 1.2, 1.7, 1.5, .7])
      #                .height(function(d) d * 70).width(20)
      #                .bottom(0).left(function() this.index * 25 + 4)
      #eos                .anchor("bottom").add(pv.Label)
      #  
      #  chart_raw_js(800, 600, my_js)
      def chart_raw_js(width, height, raw_js)

       # chart_js= "var vis= new pv.Panel().width(#{width}).height(#{height})\n"
       panel =  Panel.new(:name=> 'panel', :width=> width, :height => height )
       bar= Bar.new(:name=> 'bars', 
                    :width=> 20,
                    :bottom=> 0, 
                    :height=> "function(d) d * 70",
                    :left => "function() this.index * 25 + 4",
                    :data => "[1, 1.2, 1.7, 1.5, .7]"
                    )
                    
       panel.add( bar )
       chart_js= panel.to_js
      # chart_js << raw_js
       chart_js<< "#{panel.name}.render();"
       javascript_tag(chart_js)
      end
      
      def chart(width, height, chart) 
        
        chart.sprint_data
        my_js= <<eos
                   vis.add(pv.Rule)
                      .data(function() pv.range(0, 2, .5))
                      .bottom(function(d) d * 70)
                      .anchor("left").add(pv.Label);
                      
                    vis.add(pv.Bar)
                      .data([1, 1.2, 1.7, 1.5, .7])
                      .height(function(d) d * 70).width(20)
                      .bottom(0).left(function() this.index * 25 + 4)
                      .anchor("bottom").add(pv.Label);
eos
        return chart_raw_js(width, height, my_js)
      end
end