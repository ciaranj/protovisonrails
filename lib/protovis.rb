module Protovis
    
    def js_function(function_name)
      JavascriptFunction.new(function_name)
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

        chart_js= "new pv.Panel().width(#{width}).height(#{height})"
        chart_js << "." + raw_js
       chart_js<< ".root.render();"
       javascript_tag(chart_js)
      end
      
      def chart(width, height) 
        my_js= <<eos
                   add(pv.Rule)
                      .data(function() pv.range(0, 2, .5))
                      .bottom(function(d) d * 70)
                      .anchor("left").add(pv.Label)
                    .root.add(pv.Bar)
                      .data([1, 1.2, 1.7, 1.5, .7])
                      .height(function(d) d * 70).width(20)
                      .bottom(0).left(function() this.index * 25 + 4)
                      .anchor("bottom").add(pv.Label)
eos
        return chart_raw_js(width, height, my_js)
      end
end