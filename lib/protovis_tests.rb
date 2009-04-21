require 'protovis'
module ProtovisTests
  def render_protovis_tests
    js =""
    js << bar_charts
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