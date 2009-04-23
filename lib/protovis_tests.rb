require 'protovis'
module ProtovisTests
  def render_protovis_tests
    js =""
    js << wedge_charts
    js << rule_charts
    js << line_charts
    js << dot_charts
    js << area_charts
    js << bar_charts
  end
  
  def create_and_render_panel 
      panel =  Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
      yield(panel)
      render_protovis_panel(panel)
  end
  
  def wedge_charts
    js= ""
    data= [1, 1.2, 1.7, 1.5, 0.7]
    sum= data.inject(0){|sum,item| sum + item}
    normalised_data= data.map {|item| item / sum }
    js << create_and_render_panel do |panel|
      wedge= Protovis::Wedge.new(:name=>'wedge',
                                 :data=> normalised_data,
                                 :left=> 75,
                                 :bottom => 75,
                                 :outerRadius => 70,
                                 :angle => "function(d) d * 2 * Math.PI")
      panel.add( wedge )
    end
  end
  
  def rule_charts
    js= ""
    js << create_and_render_panel do |panel|
      bar= Protovis::Bar.new(:name=>'bar',
                             :data=>[1,1.2,1.7,1.5,0.7],
                             :bottom=>10,
                             :width=>20,
                             :height=>"function(d) d* 70",
                             :left=>"function() this.index * 25 + 15")
      panel.add( bar )
      rule= Protovis::Rule.new(:name=> 'rule', :bottom=>10)
      panel.add( rule )
    end
    js << create_and_render_panel do |panel|
      bar= Protovis::Bar.new(:name=>'bar',
                             :data=>[1,1.2,1.7,1.5,0.7],
                             :bottom=>10,
                             :width=>20,
                             :height=>"function(d) d* 70",
                             :left=>"function() this.index * 25 + 15")
      panel.add( bar )
      axis= Protovis::Rule.new(:name=> 'axis', :bottom=>10)
      panel.add( axis )
      grid= Protovis::Rule.new(:name=> 'grid', 
                               :data => "function() pv.range(1,4)",
                               :bottom=>"function(d) d * 70 /2 + 10",
                               :strokeStyle => "white")
      panel.add( grid )
    end
    
    js << create_and_render_panel do |panel|
     rule= Protovis::Rule.new(:name=> 'rule', :data=> "function() pv.range(4)", :bottom=>"function(d) d * 70 /2 + 10")
     panel.add( rule)
     bar= Protovis::Bar.new(:name=>'bar',
                               :data=>[1,1.2,1.7,1.5,0.7],
                               :bottom=>10,
                               :width=>20,
                               :height=>"function(d) d* 70",
                               :left=>"function() this.index * 25 + 15")
      panel.add( bar )
    end
    
    js << create_and_render_panel do |panel|
      bar= Protovis::Bar.new(:name=>'bar',
                                :data=>[1,1.2,1.7,1.5,0.7],
                                :bottom=>10,
                                :width=>20,
                                :height=>"function(d) d* 70",
                                :left=>"function() this.index * 25 + 15")
      panel.add( bar )
      rule= Protovis::Rule.new(:name=> 'rule', :bottom=>10, :left=>15, :right=>15)
      panel.add( rule )
    end
    
    js << create_and_render_panel do |panel|
      bar= Protovis::Bar.new(:name=>'bar',
                                :data=>[1,1.2,1.7,1.5,0.7],
                                :left=>10,
                                :height=>20,
                                :width=>"function(d) d* 70",
                                :top=>"function() this.index * 25 + 15")
      panel.add( bar )

      rule= Protovis::Rule.new(:name=>'rule', :left=>10)
      panel.add(rule)
      rule2= Protovis::Rule.new(:name=>'rule2', 
                                :strokeStyle=>'white',
                                :data=>'function() pv.range(1, 4)',
                                :left=>'function(d) d * 70 / 2 + 10' )
      panel.add(rule2)
    end
  end
  
  def line_charts
    
    js = ""
    js << create_and_render_panel do |panel|
      line= Protovis::Line.new(:name=> 'line',
                             :left => "function(d) this.index * 20 + 15",
                             :bottom => "function(d) d *80",
                             :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2]
                            )
      panel.add( line )
    end
    js << create_and_render_panel do |panel|
      line= Protovis::Line.new(:name=> 'line',
                             :left => "function(d) this.index * 20 + 15",
                             :bottom => "function(d) d *80",
                             :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2]
                            )
      panel.add( line )
      line.add( Protovis::Dot.new(:name => 'dot'))
    end
    js << create_and_render_panel do |panel|
      line= Protovis::Line.new(:name=> 'line',
                             :left => "function(i) 75 + i * Math.cos(6 * Math.PI * i / 100)",
                             :bottom => "function(i) 75 + i * Math.sin(6 * Math.PI * i / 100)",
                             :data => "function() pv.range(68)"
                            )
      panel.add( line )
      line.add( Protovis::Dot.new(:name => 'dot'))
    end 

    js << create_and_render_panel do |panel|
      line= Protovis::Line.new(:name=> 'line',
                             :left => "function() this.index * 20 + 15",
                             :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2],
                             :top => "function(d) d * 80")
      panel.add( line )
    end

    js << create_and_render_panel do |panel|
      line= Protovis::Line.new(:name=> 'line',
                             :right => "function() this.index * 20 + 15",
                             :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2],
                             :top => "function(d) d * 80")
      panel.add( line )
    end

    js << create_and_render_panel do |panel|
      line= Protovis::Line.new(:name=> 'line',
                             :left=> "function() this.index * 10 + 10",
                             :data => "function() pv.range(14)",
                             :bottom => "function() Math.random() * 40 + this.offsetBottom",
                             :lineWidth => 5)
      line.offsetBottom= 10
      
      line2= Protovis::Line.new(:name=>'line2')
      line2.offsetBottom= 50
      line3= Protovis::Line.new(:name=>'line3')
      line3.offsetBottom= 100
      panel.add( line )
      line.add( line2 )
      line.add( line3 )
    end
    
  end
  
  def dot_charts
      js = ""
      js << create_and_render_panel do |panel|
        dot= Protovis::Dot.new(:name=> 'dot',
                               :left => "function(d) d[0] *150",
                               :bottom => "function(d) d[1] *50",
                               :data => [[0.1, 1], [0.5, 1.2], [0.9, 1.7], [0.2, 1.5], [0.7, 2.2]]
                              )
        panel.add( dot )
      end
      
      js << create_and_render_panel do |panel|
        dot= Protovis::Dot.new(:name=> 'dot',
                               :left => "function() this.index * 25 + 10",
                               :bottom => "function(d) d * 80",
                               :data => [1, 1.2, 1.7, 1.5, 0.7]
                              )
        panel.add( dot )
        bar= Protovis::Bar.new(:name => 'bar',
                                :bottom => 0,
                                :width => 1, 
                                :left => "function() dot.left() - 0.5",
                                :height=> "function(d) dot.bottom() - 5")
        dot.add(bar)
      end      
      nestedSetData= [[0.1, 1, 0.4], [0.5, 1.2, 0.3], [0.9, 1.7, 0.1],
              [0.4, 1.5, 1], [0.3, 1.4, 4], [0.7, 2.2, 1]]

      js << create_and_render_panel do |panel|
        dot= Protovis::Dot.new(:name=> 'dot',
                               :left => "function(d) d[0] * 100",
                               :bottom => "function(d) d[1] * 50",
                               :size => "function(d) d[2] * 200",
                               :data => nestedSetData
                              )
        panel.add( dot )
      end
       
      nestedSetData.sort! {|x,y| x[2] <=> y[2] }
      js << create_and_render_panel do |panel|
        dot= Protovis::Dot.new(:name=> 'dot',
                               :left => "function(d) d[0] * 100",
                               :bottom => "function(d) d[1] * 50",
                               :size => "function(d) d[2] * 200",
                               :data => nestedSetData,
                               :strokeStyle => "white",
                               :fillStyle => Protovis::RGBA.new(30,120,180, 0.4)
                              )
        panel.add( dot )
      end
      
      
      js << create_and_render_panel do |panel|
        dot= Protovis::Dot.new(:name=> 'dot',
                              :left => "function(d) d[0] * 50",
                              :top => "function(d) d[1] * 50",
                              :data=> [[0.1, 1], [0.5, 1.2], [0.9, 1.7], [0.2, 1.5], [0.7, 2.2]])
        panel.add( dot )
      end
      
      js << create_and_render_panel do |panel|
        dot= Protovis::Dot.new(:name=> 'dot',
                              :right => "function(d) d[0] * 50",
                              :top => "function(d) d[1] * 50",
                              :data=> [[0.1, 1], [0.5, 1.2], [0.9, 1.7], [0.2, 1.5], [0.7, 2.2]])
        panel.add( dot )
      end
      
      js << create_and_render_panel do |panel|
        dot= Protovis::Dot.new(:name=> 'dot',
                               :data => [Protovis::Shape::CIRCLE, Protovis::Shape::SQUARE, 
                                         Protovis::Shape::TRIANGLE, Protovis::Shape::CROSS, Protovis::Shape::DIAMOND],
                               :left => "function() Math.random() * 100 + 25",
                               :bottom => "function() this.index * 25 + 25",
                               :shape => "function(d) d",
                               :fillStyle => "function() pv.Colors.category10.values[this.index]")
          panel.add( dot )
      end
  end
  
  def area_charts
    js = ""
    js << create_and_render_panel do |panel|
      area= Protovis::Area.new(:name=> 'area', 
                               :bottom=>0,
                               :height => "function(d) d* 80",
                               :left => "function() this.index *25",
                               :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2])
      panel.add( area )
    end
    
    js << create_and_render_panel do |panel|
      area= Protovis::Area.new(:name=> 'area', 
                               :bottom=>0,
                               :height => "function(d) d* 80",
                               :left => "function() this.index *25",
                               :fillStyle => Protovis::RGBA.new(30, 120, 160, 0.4),
                               :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2])
      panel.add( area )
      area2= Protovis::Area.new(:name=> 'area2', 
                               :fillStyle => Protovis::RGBA.new(30, 180, 120, 0.4),
                               :data => [0.4, 0.2, 0.8, 1.2, 1.5, 1.1, 0.8])
      area.add( area2 )
    end
      
    js << create_and_render_panel do |panel|
      area= Protovis::Area.new(:name=> 'area', 
                               :bottom=>0,
                               :height => "function(d) d* 40",
                               :left => "function() this.index *25",
                               :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2])
      panel.add( area )
      area2= Protovis::Area.new(:name=> 'area2', 
                               :bottom => "function() area.bottom() + area.height()",
                               :data => [0.4, 0.2, 0.8, 1.2, 1.5, 1.1, 0.8])
      area.add( area2 )
    end
      

    js << create_and_render_panel do |panel|
      area= Protovis::Area.new(:name=> 'area', 
                               :bottom=>0,
                               :height => "function(d) d* 80",
                               :left => "function() this.index *25",
                               :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2])
      panel.add(area)
      line = Protovis::Line.new(:name=> 'line', 
                                :strokeStyle=> "black", 
                                :bottom=> 'function() area.bottom() + area.height()')
      area.add(line)
      line.add( Protovis::Dot.new(:name=>'dot'))
    end      
      
    js << create_and_render_panel do |panel|
      area= Protovis::Area.new(:name=> 'area', 
                               :bottom=>"function() this.index *25",
                               :width => "function(d) d* 80",
                               :left => 0,
                               :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2])
      panel.add(area)
    end
  
  
    js << create_and_render_panel do |panel|
      area= Protovis::Area.new(:name=> 'area', 
                               :bottom=>"function() this.index *25",
                               :width => "function(d) d* 40",
                               :left => 0,
                               :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2])
      panel.add(area)
      area2= Protovis::Area.new(:name=> 'area2', 
                               :left => "function() area.left() + area.width()",
                               :data => [0.4, 0.2, 0.8, 1.2, 1.5, 1.1, 0.8])
      area.add(area2)
      line = Protovis::Line.new(:name=> 'line', 
                                :strokeStyle=> "white")
      area2.add(line)
    end      
    
    js << create_and_render_panel do |panel|
      area= Protovis::Area.new(:name=> 'area', 
                               :bottom=>10,
                               :height => "function(d) d* 60",
                               :left => "function() this.index * 20 + 10",
                               :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2])
      panel.add(area)
      dot1= Protovis::Dot.new(:name=> 'dot1', :fillStyle=>"green")
      dot2= Protovis::Dot.new(:name=> 'dot2', :fillStyle=>"red")
      area.add(dot1, Protovis::Anchor::TOP)
      area.add(dot2, Protovis::Anchor::BOTTOM)
    end

    js << create_and_render_panel do |panel|
      area= Protovis::Area.new(:name=> 'area', 
                               :bottom=>75,
                               :height => "function(d) d* 30",
                               :left => "function() this.index * 22 + 10",
                               :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2])
      panel.add(area)
      area2= Protovis::Area.new(:name=> 'area2', 
                                :data => [0.4, 0.2, 0.8, 1.2, 1.5, 1.1, 0.8])
      area.add(area2, Protovis::Anchor::BOTTOM)
    end      
    
    js << create_and_render_panel do |panel|
      area= Protovis::Area.new(:name=> 'area', 
                               :bottom=>"function(d) d * 10 + 55",
                               :height => "function(d) d* 30",
                               :left => "function() this.index * 22 + 10",
                               :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2])
      panel.add(area)
      area2= Protovis::Area.new(:name=> 'area2', 
                                :data => [0.4, 0.2, 0.8, 1.2, 1.5, 1.1, 0.8])
      area.add(area2, Protovis::Anchor::BOTTOM)
    end      
      
    js << create_and_render_panel do |panel|
      area= Protovis::Area.new(:name=> 'area', 
                               :bottom=>"function(d) this.index * 20 + 10 ",
                               :width => "function(d) d* 60",
                               :left => 10,
                               :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2])
      panel.add(area)
      line = Protovis::Line.new(:name=>'line', :strokeStyle=>"green")
      line2= Protovis::Line.new(:name=> 'line2', :strokeStyle => "red")
      area.add(line, Protovis::Anchor::RIGHT)
      area.add(line2, Protovis::Anchor::LEFT)
    end      

    js << create_and_render_panel do |panel|
        area= Protovis::Area.new(:name=> 'area', 
                                 :left=>"function(d) this.index * 20 + 10 ",
                                 :height => "function(d) d* 75",
                                 :bottom => 10,
                                 :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2],
                                 :strokeStyle=>"black")
        panel.add(area)
      end
  end

  def bar_charts
    js = ""
    js << create_and_render_panel do |panel|
    	bar= Protovis::Bar.new(:name=> 'bar', 
                   :width=> 20,
                   :bottom=> 0, 
                   :height=> "function(d) d * 80",
                   :left => "function() this.index * 25",
                   :data => [1, 1.2, 1.7, 1.5, 0.7]
                   )
      panel.add( bar )
    end
    js << create_and_render_panel do |panel|
    	bar= Protovis::Bar.new(:name=> 'bar', 
                   :width=> 10,
                   :bottom=> 0, 
                   :height=> "function(d) d * 80",
                   :left => "function() this.index * 25",
                   :data => [1, 1.2, 1.7, 1.5, 0.7]
                   )
      panel.add(bar)
      bar2= Protovis::Bar.new(:name=> 'bar2', 
                   :data => [0.5, 1, 0.8, 1.1, 1.3],
                   :left => "function() bar.left() + bar.width()"
                   )
      bar.add( bar2)
    end    

    js << create_and_render_panel do |panel|
    	bar= Protovis::Bar.new(:name=> 'bar', 
                   :width=> 20,
                   :bottom=> 0, 
                   :height=> "function(d) d * 50",
                   :left => "function() this.index * 25",
                   :data => [1, 1.2, 1.7, 1.5, 0.7])
                 
     panel.add( bar )
     bar2= Protovis::Bar.new(:name=> 'bar2', 
                  :data => [0.5, 1, 0.8, 1.1, 1.3],
                  :bottom => "function() bar.height() + bar.bottom()"
                  )
     bar.add( bar2)
   end   

   js << create_and_render_panel do |panel|
    	bar= Protovis::Bar.new(:name=> 'bar', 
                   :bottom=> "function() this.index * 25",
                   :width=> "function(d) (d[1] -d[0])* 50", 
                   :height=> 20,
                   :left => "function(d) d[0] * 50",
                   :data => [[0, 1], [0.5, 1.2], [0.9, 1.7], [0.2, 1.5], [0.7, 2.2]])
     panel.add( bar )
   end   
   
   js << create_and_render_panel do |panel|
    	bar= Protovis::Bar.new(:name=> 'bar', 
                   :top => 0,
                   :width => 20,
                   :height =>  "function(d) d* 80",
                   :left => "function() this.index * 25",
                   :data => [1, 1.2, 1.7, 1.5, 0.7])
     panel.add( bar )
   end   
   
   js << create_and_render_panel do |panel|
      	bar= Protovis::Bar.new(:name=> 'bar', 
                     :bottom => 0,
                     :width => 20,
                     :height =>  "function(d) d* 80",
                     :right=> "function() this.index * 25",
                     :data => [1, 1.2, 1.7, 1.5, 0.7])
       panel.add( bar )
     end

     js << create_and_render_panel do |panel|
        	bar= Protovis::Bar.new(:name=> 'bar', 
                       :left => 0,
                       :right => 0,
                       :height =>  25,
                       :fillStyle => "function(d) d",
                       :top=> "function() this.index * 25",
                       :data => ["red", "orange", "yellow", "green", "blue", "purple"])
         panel.add( bar )
    end

    js << create_and_render_panel do |panel|
        	bar= Protovis::Bar.new(:name=> 'bar', 
                       :bottom => 2,
                       :width=> 20,
                       :height =>  "function(d) d * 80",
                       :left => "function() this.index * 25 + 2",
                       :strokeStyle => "function(d) (d > 1 ) ? 'red' : 'black'",
                       :data=> [1, 1.2, 1.7, 1.5, 0.7]
                       )
                     
         panel.add( bar )
       end
  end
end