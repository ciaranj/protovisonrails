require 'protovis'
module ProtovisTests
  def render_protovis_tests
    js =""
    js << area_charts
    js << bar_charts
  end
  
  def area_charts
    js = ""
    panel =  Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
    area= Protovis::Area.new(:name=> 'area', 
                             :bottom=>0,
                             :height => "function(d) d* 80",
                             :left => "function() this.index *25",
                             :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2])
    panel.add( area )
    js << render_protovis_panel(panel) 
    
      panel =  Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
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
      js << render_protovis_panel(panel)
      
      
      panel =  Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
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
      js << render_protovis_panel(panel)
      

      panel =  Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
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

      js << render_protovis_panel(panel)
      
      
      panel =  Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
      area= Protovis::Area.new(:name=> 'area', 
                               :bottom=>"function() this.index *25",
                               :width => "function(d) d* 80",
                               :left => 0,
                               :data => [1, 1.2, 1.7, 1.5, 0.7, 0.5, 0.2])
      panel.add(area)
      js << render_protovis_panel(panel)
  
  
      panel =  Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
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
      js << render_protovis_panel(panel)    
  end

  def bar_charts
    js = ""
      panel =  Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
    	bar= Protovis::Bar.new(:name=> 'bar', 
                   :width=> 20,
                   :bottom=> 0, 
                   :height=> "function(d) d * 80",
                   :left => "function() this.index * 25",
                   :data => [1, 1.2, 1.7, 1.5, 0.7]
                   )
      panel.add( bar )
      js << render_protovis_panel(panel)

      panel=Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
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
  
      js << render_protovis_panel(panel)
    
      panel=Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
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
     js << render_protovis_panel(panel)
   
      panel=Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
    	bar= Protovis::Bar.new(:name=> 'bar', 
                   :bottom=> "function() this.index * 25",
                   :width=> "function(d) (d[1] -d[0])* 50", 
                   :height=> 20,
                   :left => "function(d) d[0] * 50",
                   :data => [[0, 1], [0.5, 1.2], [0.9, 1.7], [0.2, 1.5], [0.7, 2.2]])
     panel.add( bar )
     js << render_protovis_panel(panel)
   
   
      panel=Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
    	bar= Protovis::Bar.new(:name=> 'bar', 
                   :top => 0,
                   :width => 20,
                   :height =>  "function(d) d* 80",
                   :left => "function() this.index * 25",
                   :data => [1, 1.2, 1.7, 1.5, 0.7])
     panel.add( bar )
     js << render_protovis_panel(panel)
   
   
        panel=Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
      	bar= Protovis::Bar.new(:name=> 'bar', 
                     :bottom => 0,
                     :width => 20,
                     :height =>  "function(d) d* 80",
                     :right=> "function() this.index * 25",
                     :data => [1, 1.2, 1.7, 1.5, 0.7])
       panel.add( bar )
       js << render_protovis_panel(panel)   

          panel=Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
        	bar= Protovis::Bar.new(:name=> 'bar', 
                       :left => 0,
                       :right => 0,
                       :height =>  25,
                       :fillStyle => "function(d) d",
                       :top=> "function() this.index * 25",
                       :data => ["red", "orange", "yellow", "green", "blue", "purple"])
         panel.add( bar )
         js << render_protovis_panel(panel)


          panel=Protovis::Panel.new(:name=> 'panel', :width=> 150, :height => 150 )
        	bar= Protovis::Bar.new(:name=> 'bar', 
                       :bottom => 2,
                       :width=> 20,
                       :height =>  "function(d) d * 80",
                       :left => "function() this.index * 25 + 2",
                       :strokeStyle => "function(d) (d > 1 ) ? 'red' : 'black'",
                       :data=> [1, 1.2, 1.7, 1.5, 0.7]
                       )
                     
         panel.add( bar )
         js << render_protovis_panel(panel)
  end
end